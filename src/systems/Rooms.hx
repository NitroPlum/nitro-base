package systems;
import systems.Enemy.EnemyState;
import components.CurrentRoom;
import systems.Player.PlayerState;
import components.FSM;
import ecs.System;
import components.Position;
import Layers.groundLayer;

final project = new LdtkProject();
var currentRoom: LdtkProject_Level;
var previousRoom: LdtkProject_Level;
var levelStarted: Bool = false;

function changeRoom(roomState: RoomState, ?level: LdtkProject_Level) {
    groundLayer.removeChildren();
    loadRoom(level);

    roomState.last = roomState.current;
    roomState.current = level.uid;
    
    // Load all adjacent rooms
    for (lvl in level.neighbours) {
        loadRoom(project.getLevel(lvl.levelUid));
    }
}

function updateCurrentRoom(roomState: RoomState, x: Int, y: Int) {
    var room = project.getLevelAt(x, y);
    if(room == null) return;

    if(roomState.current != room.uid) {
        changeRoom(roomState, room);
    }
}

function loadRoom (level: LdtkProject_Level) {
    // Render the room
    var layerRender = level.l_GROUND.render();
    layerRender.setPosition(level.worldX, level.worldY);
    groundLayer.addChild(layerRender);

    if(!levelStarted) {
        levelStarted = true;
        // Player Start
        var pStart: Entity_PlayerStart = null;
        if(level.l_Entities.all_PlayerStart.length > 0)
            pStart = level.l_Entities.all_PlayerStart[0];
        if(pStart != null) 
            systems.Player.player(pStart.pixelX, pStart.pixelY, level);
    }

    // Spawn Enemies
    for(enemy in level.l_Entities.all_EnemySpawn) {
        Enemy.spawnEnemy(enemy.pixelX, enemy.pixelY, level.uid);
    }
}

function getRoom(uid: Int) {
    return project.getLevel(uid);
}

class Rooms extends System {
    @:fastFamily var player : { fsm: FSM<PlayerState>, pos : Position, roomState: RoomState};
    @:fastFamily var enemies: { enemyFSM: FSM<EnemyState>, enemyPos : Position, enemyRoomState: RoomState};
    override function update(_dt: Float) {
        iterate(player, {
            updateCurrentRoom(roomState, Std.int(pos.x), Std.int(pos.y));

            iterate(enemies, enemy -> {
                if (enemyRoomState.current != roomState.current) {
                    UNIVERSE.deleteEntity(enemy);
                }
            });
        });
    }
}