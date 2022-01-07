package systems;

import components.Position;
import h2d.Scene;
import systems.Enemy.EnemyState;
import systems.Player.PlayerState;
import components.FSM;
import h2d.col.Point;
import ecs.System;

enum HitType {
    None;
    Hurt;
    Block;
    Hit;
    Level;
}

// Circular area we can use to test
class Area extends Point {
    public var offsetX: Float = .0;
    public var offsetY: Float = .0;
    public var radius: Float = 8;
    public var enabled: Bool = false;
    public var sinceEnabled: Int; // How long since first enabled? We can use this to check for parry timing
    public var hitType: HitType = None;
    public function new(x = 0, y = 0, enable = false) {
        super(x, y);
        enabled = enable;
    }

    public function touches(a: Area) {
        return Math.abs(distance(a)) < Math.abs(a.radius + radius);
    }

    public function update(pos: Position) {
        if(enabled) {
            set(pos.x + offsetX, pos.y + offsetY);
            hitType = HitType.None;
        }
    }
}

class Hitbox extends Area {
    public function new(x = 0, y = 0, enable = false) {
        super(x, y);
        enabled = enable;
    }
}

class Hurtbox extends Area {
    public function new(x = 0, y = 0, enable = false) {
        super(x, y);
        enabled = enable;
    }
}

class Blockbox extends Area {
    public function new(x, y) {
        super(x, y);
    }
}

var debug: Scene;
function initHitboxDebug(_s2d: Scene) {
    debug = _s2d;
}

function drawArea(area: Area, g: h2d.Graphics, color: Int, checkFill = false) {
    if(area.enabled) {
        if(checkFill && area.hitType != HitType.None) {
            g.beginFill(color);
        }
        g.lineStyle(1., color, 1.);
        g.drawCircle(area.x, area.y, area.radius);
        g.endFill();
    }
}

class Hitboxes extends System {
    // Everything has a hit/hurt/block box. Just disable/enable them as needed;
    // tick sinceEnabled timers on each box, then resolve
    @:fastFamily var player : { playerFSM: FSM<PlayerState>, hit: Hitbox, hurt: Hurtbox, block: Blockbox, pos: Position };
    @:fastFamily var enemies : { enemyFSM: FSM<EnemyState>, eHit: Hitbox, eHurt: Hurtbox, eBlock: Blockbox, ePos: Position };

    var resolved: Bool = false;

    // For debug rendering
    var debugDraw = new h2d.Graphics(debug);
    
    override function update(_dt: Float) {
        debugDraw.clear();
        iterate(player, {
            hit.update(pos);
            // hurt.update(pos);
            // block.update(pos);
            iterate(enemies, {
                // eHit.update(pos);
                eHurt.update(ePos);
                // eBlock.update(pos);
                // resolved = false;

                // Prioritize Player Actions
                if(hit.enabled) {
                    if(eBlock.enabled && hit.touches(eBlock)) {
                        // Enemy Blocked
                        resolved = true;
                    }
                    
                    else if(eHurt.enabled && hit.touches(eHurt)) {
                        // Enemy Was Hit
                        hit.hitType = HitType.Hurt;
                        resolved = true;
                    }

                    else if(eHit.enabled && hit.touches(eHit)) {
                        // CLASH
                        resolved = true;
                    }
                }

                if(resolved == false && eHit.enabled) {
                    if(block.enabled && eHit.touches(block)) {
                        //Player Blocked
                        resolved = true;
                    } else if(hurt.enabled && eHit.touches(hurt)) {
                        //Player Blocked
                        resolved = true;
                    }
                }        
                drawArea(eHurt, debugDraw, 0x0000FF);        
            });
            drawArea(hit, debugDraw, 0xFF0000, true);
        });
    }
}