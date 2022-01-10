package systems;

import components.Script;
import systems.Interactions;
import systems.Interactions.Interactable;
import systems.Hitboxes;
import h2d.col.Point;
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
import components.Facing;
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
    var fsm = new FSM<PlayerState>(PlayerState.IDLE);
    var roomState = new RoomState(level.uid);
    UNIVERSE.setComponents(player,
        fsm,
        new Position(x, y),
        new Velocity(0., 0.),
        loadAnim(hxd.Res.Link, "IDLE", defaultParent),
        roomState,
        new systems.Hitboxes.Hitbox(x, y, true),
        new systems.Hitboxes.Hurtbox(x, y),
        new systems.Hitboxes.Blockbox(x, y),
        new Facing()
    );
}

class Player extends ecs.System {
    @:fastFamily var players : { fsm: FSM<PlayerState>, spr:Sprite, pos:Position, vel: Velocity, hit: Hitbox, hurt: Hurtbox, block: Blockbox, facing: Facing};
    @:fastFamily var interactions : { interact: Interactable, interaction: Script };

    override function update(_dt: Float) {

        iterate(players, {
            function runInteraction() {
                iterate(interactions, {
                    if(interact.canInteract == true) {
                        runScript(interaction);
                    }
                });
            }

            fsm.updateState();
            var stick: Point = new Point(ctrl.getAnalogValue(MoveX), ctrl.getAnalogValue(MoveY)); 
            hit.enabled = false;
            hurt.enabled = false;
            block.enabled = false;

            switch (fsm.state) {
                case PlayerState.IDLE:
                    if(fsm.stateChanged) play(spr, "IDLE");

                    if(ctrl.isPressed(Attack)) {
                        fsm.changeState(PlayerState.SWORD);
                        return;
                    }

                    else if(ctrl.isPressed(Interact)) {
                        runInteraction();
                        return;
                    }

                    else if(!Vector2.equals(stick, Vector2.zero)) {
                        fsm.changeState(PlayerState.RUN);
                        return;
                    }
                    vel.set();

                case PlayerState.RUN:
                    if(fsm.stateChanged) play(spr, "RUN");

                    if(ctrl.isPressed(Attack)) {
                        fsm.changeState(PlayerState.SWORD);
                        return;
                    }

                    else if(ctrl.isPressed(Interact)) {
                        runInteraction();
                        return;
                    }

                    if(Vector2.equals(stick, Vector2.zero)) {
                        fsm.changeState(PlayerState.IDLE);
                        return;
                    }

                    vel.setDir(stick, 4 * _dt);
                    facing.dir = updateFacing(stick);

                case PlayerState.SWORD:
                    // ON ENTER
                    if(fsm.stateChanged) {
                        vel.set();
                        Audio.sounds.LA_Sword_Slash.drawAndPlay();
                        play(spr, "ATTACK");

                        spr.anim.onAnimEnd = () -> {
                            if(!Vector2.equals(stick, Vector2.zero)) {
                                fsm.changeState(PlayerState.RUN);
                            } else {
                                fsm.changeState(PlayerState.IDLE);
                            }
                        };
                    };

                    // UPDATE
                    hit.enabled = true;
                    hit.offsetX = -16;
                    
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