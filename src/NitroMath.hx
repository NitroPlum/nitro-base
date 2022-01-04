import hxmath.math.Vector2;

// TODO: Use Fast Inverse Square Root Instead? Seems like it may not be needed.
inline function directionTo(ax: Float, ay: Float, bx: Float, by: Float) {
    var dirX = (bx - ax) * (bx - ax);
    var dirY = (by - ay) * (by - ay);
    var mag = Math.sqrt(dirX + dirY);
    return new Vector2(dirX / mag, dirY / mag);
}