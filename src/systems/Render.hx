package systems;

import components.Sprite;
import components.Position;

class Render extends ecs.System {
    @:fastFamily var drawable : { spr:Sprite, pos:Position };
    override function update(_dt: Float) {
        iterate(drawable, {
            spr.anim.setPosition(pos.x, pos.y);
        });
    }
}