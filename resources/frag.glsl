uniform vec3 u_resolution;
uniform float u_time;
uniform sampler2D u_texture;
uniform float u_speed;

vec2 rotate2D(vec2 _st, float _angle) {
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

const float PI_1_2 = 1.57079632679;
const float PI = 3.14159265359;

vec3 color;
vec2 coord;

void init() {
    coord = gl_FragCoord.xy / u_resolution.z;
}

float sinShit(float offset) {
	return ((sin(u_time * u_speed + offset) + 1.0) / 2.0);
}

float getTexOpacity(vec2 _coord) {
	return texture2D(u_texture, _coord).g;
}

bool isBlack(vec2 _coord) {
	return getTexOpacity(_coord) == 0.0;
}

bool isWhite(vec2 _coord) {
	return getTexOpacity(_coord) == 1.0;
}

void drawColorfulShit(vec2 _coord, float colorOffset) {
	if (getTexOpacity(_coord) < 0.7) {
		color.b = sinShit(0.0 + colorOffset);
		color.r = sinShit(PI_1_2 + colorOffset);
		color.g = sinShit(PI + colorOffset);
	}
}

void draw() {
	color = vec3(0.5);

	float power = 0.8;

	drawColorfulShit(rotate2D(coord, power * 0.02), PI_1_2);
	drawColorfulShit(rotate2D(coord, power * 0.01), PI_1_2 / 2.0);
	drawColorfulShit(rotate2D(coord, power * -0.02), -PI_1_2);
	drawColorfulShit(rotate2D(coord, power * -0.01), -PI_1_2 / 2.0);

	drawColorfulShit(coord, 0.0);
}

void main() {
    init();
    draw();
	gl_FragColor = vec4(color, 1.0);
}