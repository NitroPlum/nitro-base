package systems;

import echoes.System;
import components.Position;
import components.Velocity;

class Movement extends System {
    @u function move(dt: Float, pos: Position, vel: Velocity) {
        pos.x += vel.x * dt;
        pos.y += vel.y * dt;
    }
}