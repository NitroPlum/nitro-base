package components;

import hxmath.math.Vector2;

@:forward
abstract Velocity(Vector2) {

    public inline function new(x = .0, y = .0) this = new Vector2(x, y);
    public inline function copy(vec: Vector2) {
        this.x = vec.x;
        this.y = vec.y;
    }
}