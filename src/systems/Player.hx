package systems;

import systems.Rooms.changeRoom;
import editor.Editor.status;
import components.CurrentRoom;
import hxmath.math.Vector2;
import Const.defaultParent;
import Const.UNIVERSE;
import components.Sprite.loadAnim;
import components.Sprite.play;
import components.Position;
import components.Velocity;
import components.Sprite.Sprite;
import components.FSM;
import Controller;

enum PlayerState {
    IDLE;
    RUN;
    SWORD;
    ROLL;
}

function player(x: Int, y: Int, level: LdtkProject_Level) {
    final player = UNIVERSE.createEntity();
    var roomState = new RoomState(-1);
    UNIVERSE.setComponents(player,
        new FSM<PlayerState>(PlayerState.IDLE),
        new Position(x, y),
        new Velocity(0., 0.),
        loadAnim(hxd.Res.Link, "IDLE", defaultParent),
        roomState
    );
    changeRoom(roomState, level);
}

class Player extends ecs.System {
    @:fastFamily var players : { fsm: FSM<PlayerState>, spr:Sprite, pos:Position, vel: Velocity };
    override function update(_dt: Float) {
        iterate(players, {
            

            fsm.updateState();
            var stick: Vector2 = new Vector2(ctrl.getAnalogValue(MoveX), ctrl.getAnalogValue(MoveY)); 

            switch (fsm.state) {
                case PlayerState.IDLE:
                    if(fsm.stateChanged) play(spr, "IDLE");

                    if(!Vector2.equals(stick, Vector2.zero)) {
                        fsm.changeState(PlayerState.RUN);
                    }

                    vel.copy(Vector2.zero);

                case PlayerState.RUN:
                    if(fsm.stateChanged) play(spr, "RUN");

                    if(Vector2.equals(stick, Vector2.zero)) {
                        fsm.changeState(PlayerState.IDLE);
                    }

                    vel.copy(stick * 4 * _dt);
                case _: 
            }

            status = [
                "X : " + pos.x,
                "Y : " + pos.y,
                "Tile X : " + pos.tileX,
                "Tile Y : " + pos.tileY,
                "X Ratio : " + pos.xRatio,
                "Y Ratio : " + pos.yRatio,
            ];
        });
    }
}