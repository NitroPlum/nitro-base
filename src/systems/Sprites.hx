package systems;

import h2d.Graphics;
import components.Sprite;
import components.Position;

class Sprites extends ecs.System {
    @:fastFamily var drawable : { spr:Sprite, pos:Position };

    public function new(_universe : ecs.Universe) {
        super(_universe);
    }

    override function onEnabled() {
        drawable.onEntityRemoved.subscribe(removeFromScene);
    }

    function removeFromScene(entity) {
        setup(drawable, {
            table(Sprite).get(entity).anim.remove();
        });
    }

    override function update(_dt: Float) {
        iterate(drawable, {
            spr.anim.setPosition(pos.x - 8, pos.y - 8);
        });
    }
}