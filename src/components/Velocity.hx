package components;

import h2d.col.Point;

class Velocity extends Point {
    public function new(x = .0, y =.0) {
        super(x, y);
    }

    public function setDir(point: Point, mag: Float) {
        set(point.x * mag, point.y * mag);
    }
}