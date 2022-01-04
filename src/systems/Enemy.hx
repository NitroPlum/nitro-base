package systems;

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
    //vel = directionTo(pos.x, pos.y, pPos.x, pPos.y);
";

function spawnEnemy(x: Int, y: Int, roomId:Int) {
    final entity = UNIVERSE.createEntity();
    UNIVERSE.setComponents( entity,
        new FSM<EnemyState>(EnemyState.IDLE),
        new Position(x, y),
        new Velocity(0., 0.),
        loadAnim(hxd.Res.Link, "IDLE", defaultParent),
        new RoomState(roomId)
    );
}

class Enemy extends System {
    @:fastFamily var player : { playerFSM: FSM<PlayerState>, playerSpr:Sprite, playerPos:Position, playerVel: Velocity };
    @:fastFamily var enemies : { fsm: FSM<EnemyState>, spr:Sprite, pos:Position, vel: Velocity };

    var parser = new hscript.Parser();
    var interp = new hscript.Interp();
    
    override function onAdded() {
        // interp.variables.set("move", moveEnemy);
        
    }
    
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

            // // Yanrishatum explained that expr should prevent context recreation. 
            // // If issues arise, see if using Execute fixes them. Maybe something is carrying over?
            // interp.execute(program);
            //interp.expr(program);
            // var temp = directionTo(pos.x, pos.y, pPos.x, pPos.y);
            // trace("");
            //vel.copy(temp);
        });
        //});

        // var stick: Vector2 = new Vector2(ctrl.getAnalogValue(MoveX), ctrl.getAnalogValue(MoveY)); 

        // switch (fsm.state) {
        //     case PlayerState.IDLE:
        //         if(fsm.stateChanged) play(spr, "IDLE");

        //         if(stick != Vector2.zero) {
        //             fsm.state = PlayerState.RUN;
        //             trace('HOR INPUT : ' + ctrl.getAnalogValue(MoveX));
        //         }

        //         vel.copy(Vector2.zero);

        //     case PlayerState.RUN:
        //         if(fsm.stateChanged) play(spr, "RUN");

        //         if(stick == Vector2.zero) {
        //             fsm.state = PlayerState.IDLE;
        //         }

        //         vel.copy(stick * 30.);
        //     case _: 
        // }
    }
}