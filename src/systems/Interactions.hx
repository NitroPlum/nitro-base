package systems;

import Layers.uiLayer;
import components.Facing;
import components.Facing.offsetByFacing;
import h2d.col.Point;
import systems.Player.PlayerState;
import components.FSM;
import components.Sprite;
import components.Position;
import components.Script;
import components.CurrentRoom;

class Interactable {
    // Some items we require
    public var needs: Array<Int>;
    public var canInteract : Bool = false;
    public function new(){}
}

function createInteractable(x: Int, y:Int, script: String, roomId: Int) {
    final interact = UNIVERSE.createEntity();
    UNIVERSE.setComponents(interact,
        new Interactable(),
        new Script(script),
        new Position(x, y),
        loadAnim(hxd.Res.Link, "IDLE", defaultParent),
        new RoomState(roomId)
    );
}

class Interactions extends ecs.System {
    @:fastFamily var interactions : { interact: Interactable, spr:Sprite, pos:Position };
    @:fastFamily var players : { fsm: FSM<PlayerState>, pSpr:Sprite, pPos:Position, face: Facing };

    public function new(_universe : ecs.Universe) {
        super(_universe);
    }

    function removeFromScene(entity) {
        setup(interactions, {
            table(Sprite).get(entity).anim.remove();
        });
    }

    override function onEnabled() {
        interactions.onEntityRemoved.subscribe(removeFromScene);
    }

    override function update(_dt: Float) {
        var facingOffset: Point;
        iterate(players, {
            facingOffset = offsetByFacing(face, pPos.tileX, pPos.tileY);

            iterate(interactions, {
                if(pos.tileX == facingOffset.x && pos.tileY == facingOffset.y) {
                    interact.canInteract = true;
                    // Check for the requirement if the player tries to interact.
                    // This lets us give better feedback showing the player the issue
                } else {
                    interact.canInteract = false;
                }
            });
        });
    }
}