package systems;

import Const.defaultParent;
import components.Sprite.loadAnim;
import components.Position;
import components.Velocity;
import components.Sprite.Sprite;
import components.FSM;
import echoes.Entity;

enum EnemyState {
    IDLE;
    RUN;
    SWORD;
    ROLL;
}

function enemy(x: Int, y: Int) {
    new Entity().add(
        new FSM<EnemyState>(EnemyState.IDLE),
        new Position(x, y),
        new Velocity(0., 0.),
        loadAnim(hxd.Res.Link, "IDLE", defaultParent)
    );
}

class Enemy extends echoes.System {
    @u function update(fsm: FSM<EnemyState>, spr:Sprite, pos:Position, vel: Velocity) {
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