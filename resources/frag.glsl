uniform vec3 u_resolution;
uniform float u_time;
uniform sampler2D u_texture;
uniform float u_speed;

vec3 color;
vec2 coord;

vec3 hsl2rgb(in vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0);
    return c.z + c.y * (rgb-0.5)*(1.0-abs(2.0*c.z-1.0));
}

vec3 rgb2hsl(in vec3 c) {
    float h = 0.0;
	float s = 0.0;
	float l = 0.0;
	float r = c.r;
	float g = c.g;
	float b = c.b;
	float cMin = min(r, min(g, b));
	float cMax = max(r, max(g, b));

	l = (cMax + cMin) / 2.0;
	if (cMax > cMin) {
		float cDelta = cMax - cMin;
        
        s = l < .0 ? cDelta / (cMax + cMin) : cDelta / (2.0 - (cMax + cMin));
        
		if (r == cMax) {
			h = (g - b) / cDelta;
		} else if (g == cMax) {
			h = 2.0 + (b - r) / cDelta;
		} else {
			h = 4.0 + (r - g) / cDelta;
		}

		if (h < 0.0) {
			h += 6.0;
		}
		h = h / 6.0;
	}
	return vec3(h, s, l);
}

vec3 hueShift(in vec3 color, in float shift) {
    vec3 p = vec3(0.55735) * dot(vec3(0.55735), color);
    vec3 u = color - p;
    vec3 v = cross(vec3(0.55735), u);
    color = u * cos(shift * 6.2832) + v * sin(shift * 6.2832) + p;
    return vec3(color);
}

void init() {
    coord = gl_FragCoord.xy / u_resolution.xy;
}

void draw() {
    vec3 texColor = texture2D(u_texture, coord).xyz;
    color = hueShift(texColor, u_time * u_speed);
}

void main() {
    init();
    draw();
    gl_FragColor = vec4(color, 1.0);
}