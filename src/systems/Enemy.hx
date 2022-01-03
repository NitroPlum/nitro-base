package systems;

import aseprite.res.Aseprite;
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
    @:fastFamily var enemies : { fsm: FSM<EnemyState>, spr:Sprite, pos:Position, vel: Velocity };


    override function update(_dt: Float) {
        // iterate(enemies, {
        // }

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