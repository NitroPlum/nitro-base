package systems;

import systems.Player.PlayerState;
import components.FSM;
import components.Position;
import h2d.Scene;

var cam: h2d.Camera;
var s2d: h2d.Scene;
var camW: Int;
var camH: Int;

function initCamera(_s2d: Scene) {
    s2d = _s2d;
    cam = s2d.camera;
    cam.anchorX = 0.5;
    cam.anchorY = 0.5;

    // TODO: Support more viewport modes. I may not even need it.
    letterbox();
}

function updateCamSize() {
    camW = Std.int(cam.viewportWidth / 2);
    camH = Std.int(cam.viewportHeight / 2);
}

function letterbox() {
    s2d.scaleMode = LetterBox(Const.referenceWidth, Const.referenceHeight, true);
    updateCamSize();
}

class Camera extends ecs.System {
    @:fastFamily var player : { fsm: FSM<PlayerState>, pos : Position };

    override function update(_dt: Float) {
        iterate(player, {
            cam.setPosition(pos.x, pos.y);
        });
    }
}