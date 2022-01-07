import components.Velocity;
import hxmath.math.Vector2;

@:publicFields
class NitroMath {
    // TODO: Use Fast Inverse Square Root Instead? Seems like it may not be needed.
    static inline function directionTo(ax: Float, ay: Float, bx: Float, by: Float, result: Velocity) {
        var dirX = bx - ax;
        var dirY = by - ay;
        var mag = Math.sqrt(dirX*dirX + dirY*dirY);
        if(mag == 0) return; // prevent div/0
        result.set(dirX / mag, dirY / mag);
    }

    static inline function multVelVec(vel: Velocity, vec: Vector2) {
        vel.set(vel.x * vec.x, vel.y * vec.y);
    }

    static inline function multVelF(vel :Velocity, fl: Float) {
        vel.set(vel.x * fl, vel.y * fl);
    }
}