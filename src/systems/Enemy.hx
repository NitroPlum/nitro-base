package systems;

import hxmath.math.Vector2;
import h2d.col.Point;
import NitroMath.directionTo;
import systems.Player.PlayerState;
import components.CurrentRoom.RoomState;
import Const.UNIVERSE;
import Const.defaultParent;
import components.Sprite.loadAnim;
import components.Position;
import components.Velocity;
import components.Sprite.Sprite;
import components.FSM;
import ecs.System;

enum EnemyState {
    IDLE;
    RUN;
    SWORD;
    ROLL;
}

var script = "
    NM.directionTo(pos.x, pos.y, pPos.x, pPos.y, vel);
    NM.multVelF(vel, dt);
";

function spawnEnemy(x: Int, y: Int, roomId:Int) {
    var entity = UNIVERSE.createEntity();
    var fsm = new FSM<EnemyState>(EnemyState.IDLE);
    UNIVERSE.setComponents( entity,
        fsm,
        new Position(x, y),
        new Velocity(0., 0.),
        loadAnim(hxd.Res.Link, "IDLE", defaultParent),
        new RoomState(roomId),
        new systems.Hitboxes.Hitbox(x, y),
        new systems.Hitboxes.Hurtbox(x, y, true),
        new systems.Hitboxes.Blockbox(x, y)
    );
}

class Enemy extends System {
    @:fastFamily var player : { playerFSM: FSM<PlayerState>, playerSpr:Sprite, playerPos:Position, playerVel: Velocity };
    @:fastFamily var enemies : { fsm: FSM<EnemyState>, spr:Sprite, pos:Position, vel: Velocity };

    var parser = new hscript.Parser();
    var interp = new hscript.Interp();
    
    override function update(_dt: Float) {
        var program = parser.parseString(script);
        var pPos:Position = null;
        iterate(player, {pPos = playerPos;});
        iterate(enemies, {
            interp.variables.set("dt", _dt);
            interp.variables.set("vel", vel);
            interp.variables.set("spr", spr);
            interp.variables.set("pos", pos);
            interp.variables.set("pPos", pPos);
            interp.variables.set("directionTo", directionTo);
            interp.variables.set("NM", NitroMath);

            // // Yanrishatum explained that expr should prevent context recreation. 
            // // If issues arise, see if using Execute fixes them. Maybe something is carrying over?
            // interp.execute(program);
            interp.expr(program);
        });
    }
}