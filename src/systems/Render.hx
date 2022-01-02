package systems;

import h2d.Graphics;
import components.Sprite;
import components.Position;

class Render extends ecs.System {
    @:fastFamily var drawable : { spr:Sprite, pos:Position };
    override function update(_dt: Float) {
        iterate(drawable, {
            // var gfx = new Graphics();
            // gfx.beginFill();
            // gfx.clear();
            // gfx.drawRect(pos.x, pos.y, 1, 1);
            // gfx.endFill();
            // defaultParent.addChild(gfx);
            spr.anim.setPosition(pos.x - 8, pos.y - 16);
        });
    }
}