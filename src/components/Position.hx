package components;

import hxmath.math.Vector2;

@:forward
abstract Position(Vector2) {

    public inline function new(x = .0, y = .0) this = new Vector2(x, y);

}