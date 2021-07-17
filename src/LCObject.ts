import * as THREE from "three";

export class LCObject {

    private sketch : HTMLImageElement;
    private startColor : number;
    private offsetDirection : THREE.Vector2;
    private x : number;
    private y : number;

    constructor(
        sketch : HTMLImageElement,
        startColor : number,
        offsetDirection : THREE.Vector2
    ) {
        this.sketch = sketch;
        this.startColor = startColor;
        this.offsetDirection = offsetDirection;
    }

    setX(x : number) {
        this.x = x;
        return this;
    }

    setY(y : number) {
        this.y = y;
        return this;
    }



}