package systems;

import h2d.Interactive;
import hxd.Res;
import aseprite.res.Aseprite;
import systems.Camera.cam;
import ecs.System;
import systems.Player.PlayerState;
import components.Velocity;
import components.Position;
import components.FSM;
import components.Sprite;
import Layers.uiLayer;
import h2d.Flow;

class Heartbar {
    var flow = new Flow(uiLayer);
    var sprites: Array<Sprite> = [];
    var lastHealth = 0;
    public function new (aseprite: Aseprite, numHearts: Int, heartsPerRow: Int, heartSize:Int, spacing: Int = 1, invert: Bool = false) {
        flow.addSpacing(spacing);
        flow.maxWidth = heartsPerRow * (heartSize + spacing);
        flow.overflow = FlowOverflow.Limit;
        flow.multiline = true;

        for(h in 0...numHearts) {
            sprites.push(loadAnim(aseprite, "4", flow));
        }

        flow.reflow();
    }

    public function update(health: Int, maxHealth: Int, subHearts = 4) {
        // don't waste time updating if the value hasn't changed
        if(health == lastHealth) return;
        lastHealth = health;

        for(s in 0...sprites.length) {
            if(health <= 0) {
                sprites[s].play("0");
            }
            else if(health < subHearts) {
                sprites[s].play(Std.string(health));
            } else {
                sprites[s].play(Std.string(subHearts));
            }
            health -= subHearts;
        }
    }
}

class StartMenu {
    var button = new Interactive(100, 100);
    function new() {
    }
}

class UI extends System {
    @:fastFamily var player : { playerFSM: FSM<PlayerState>, playerSpr:Sprite, playerPos:Position, playerVel: Velocity };
    
    var hearts: Heartbar = null;
    override function onEnabled() {
        hearts = new Heartbar(Res.LA_Heart, 8, 4, 8, 4);
    }

    override function update(_dt: Float) {
        uiLayer.setPosition(cam.x - cam.viewportWidth / 2, cam.y - cam.viewportHeight / 2);
        hearts.update(19, 25);
    }
}
