package systems;
import hl.BaseType.Enum;
import components.CurrentRoom;
import systems.Player.PlayerState;
import components.FSM;
import ecs.System;
import components.Position;
import Layers.groundLayer;

final project = new LdtkProject();
var currentRoom: LdtkProject_Level;

function initRooms() {
    changeRoom(project.all_levels.Level_0);
}

function changeRoom(?level: LdtkProject_Level) {
    groundLayer.removeChildren();
    loadRoom(level);
    currentRoom = level;
    for (lvl in level.neighbours) {
        loadRoom(project.getLevel(lvl.levelUid));
    }
}

function loadRoom (level: LdtkProject_Level) {
    var layerRender = level.l_GROUND.render();
    layerRender.setPosition(level.worldX, level.worldY);
    groundLayer.addChild(layerRender);
}

function updateCurrentRoom(x: Int, y: Int) {
    var room = project.getLevelAt(x, y);
    if(room == null) return;

    if(currentRoom.uid != room.uid) {
        changeRoom(room);
    }
}

class Rooms extends System {
    @:fastFamily var player : { fsm: FSM<PlayerState>, pos : Position };
    override function update(_dt: Float) {
        iterate(player, {
            updateCurrentRoom(Std.int(pos.x), Std.int(pos.y));
        });
    }
}