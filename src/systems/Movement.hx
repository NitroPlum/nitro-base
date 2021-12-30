package systems;

import ecs.System;
import components.Position;
import components.Velocity;

class Movement extends System {
    @:fastFamily var movables : { pos : Position, vel : Velocity };
    override function update(_dt: Float) {
        iterate(movables, {
            pos.x += vel.x * _dt;
            pos.y += vel.y * _dt;
        });
    }
}