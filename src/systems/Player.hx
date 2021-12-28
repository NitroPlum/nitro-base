package systems;

import hxmath.math.Vector2;
import Const.defaultParent;
import components.Sprite.loadAnim;
import components.Sprite.play;
import components.Position;
import components.Velocity;
import components.Sprite.Sprite;
import components.FSM;
import echoes.Entity;
import Controller;

enum PlayerState {
    IDLE;
    RUN;
    SWORD;
    ROLL;
}

function player(x: Int, y: Int) {
    new Entity().add(
        new FSM<PlayerState>(PlayerState.IDLE),
        new Position(x, y),
        new Velocity(0., 0.),
        loadAnim(hxd.Res.Link, "IDLE", defaultParent)
    );
}

class Player extends echoes.System {
    @u function update(fsm: FSM<PlayerState>, spr:Sprite, pos:Position, vel: Velocity) {
        fsm.updateState();
        var stick: Vector2 = new Vector2(ctrl.getAnalogValue(MoveX), ctrl.getAnalogValue(MoveY)); 

        switch (fsm.state) {
            case PlayerState.IDLE:
                if(fsm.stateChanged) play(spr, "IDLE");

                if(!Vector2.equals(stick, Vector2.zero)) {
                    fsm.changeState(PlayerState.RUN);
                    trace('HOR INPUT : ' + ctrl.getAnalogValue(MoveX));
                }

                vel.copy(Vector2.zero);

            case PlayerState.RUN:
                if(fsm.stateChanged) play(spr, "RUN");

                if(Vector2.equals(stick, Vector2.zero)) {
                    fsm.changeState(PlayerState.IDLE);
                }

                vel.copy(stick * 30.);
            case _: 
        }
    }
}