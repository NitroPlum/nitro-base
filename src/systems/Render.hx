package systems;

import components.Sprite;
import components.Position;

class Render extends echoes.System {
    @u function updateSpritePosition(spr:Sprite, pos:Position) {
        spr.anim.setPosition(pos.x, pos.y);
    }
}