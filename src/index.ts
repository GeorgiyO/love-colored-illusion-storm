import * as THREE from "three";
import {readFile, uniformOf} from "./Util";
import {Texture} from "three";

(async () => {

    const root = document.getElementById("root");

    const textureLoader = new THREE.TextureLoader();

    const w = window.innerWidth;
    const h = window.innerHeight;

    const scene = new THREE.Scene();
    const camera = new THREE.OrthographicCamera(0, w, 0, h, 0.1, 11);
    const renderer = new THREE.WebGLRenderer();

    const canvasDom = renderer.domElement;

    const uniforms = {
        u_resolution: uniformOf(
            (w : number, h : number) => new THREE.Vector3(w, h, w / h)
        ),
        u_time: uniformOf(
            (v : number) => v
        ),
        u_texture: uniformOf(
            (texture : Texture) => texture
        ),
        u_speed: uniformOf(
            (v : number) => v
        )
    };

    const canvas = new THREE.Mesh(
        new THREE.PlaneGeometry(1, 1),
        new THREE.ShaderMaterial({
            fragmentShader: await readFile("resources/frag.glsl"),
            uniforms
        })
    );

    await init();
    await initUniforms();
    await addObjects();
    await addEventListeners();
    await render(0);

    function init() {

        renderer.setSize(w, h);
        root.appendChild(canvasDom);
        camera.position.z = 8;

        canvas.scale.x = w;
        canvas.scale.y = h;

        canvas.position.x = w / 2;
        canvas.position.y = h / 2;

        canvas.rotation.y = Math.PI;
    }

    async function initUniforms() {
        uniforms.u_resolution.set(w, h);
        uniforms.u_time.set(0);
        uniforms.u_texture.set(
            await textureLoader.loadAsync("resources/2a.png")
        );
        uniforms.u_speed.set(-2);
    }

    function addObjects() {
        [canvas]
            .forEach((o) => scene.add(o));
    }

    function addEventListeners() {
        window.onresize = () => {
            const w = window.innerWidth;
            const h = window.innerHeight;
            camera.right = w;
            camera.bottom = h;
            renderer.setSize(w, h);
            uniforms.u_resolution.set(w, h)
        };
    }

    function render(time : number) {
        update(time);
        renderer.render(scene, camera);
        requestAnimationFrame(render);
    }

    function update(time : number) {
        time /= 1000;
        uniforms.u_time.set(time);
    }
})();
