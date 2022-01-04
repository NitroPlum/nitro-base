package systems;

import systems.Rooms.getRoom;
import ldtk.Project;
import components.CurrentRoom.RoomState;
import systems.Player.PlayerState;
import components.FSM;
import components.Position;
import h2d.Scene;

var cam: h2d.Camera;
var s2d: h2d.Scene;
var camW: Int;
var camH: Int;

function initCamera(_s2d: Scene) {
    s2d = _s2d;
    cam = s2d.camera;
    cam.anchorX = 0.5;
    cam.anchorY = 0.5;

    // TODO: Support more viewport modes. I may not even need it.
    letterbox();
}

function updateCamSize() {
    camW = Std.int(cam.viewportWidth / 2);
    camH = Std.int(cam.viewportHeight / 2);
}

function letterbox() {
    s2d.scaleMode = LetterBox(Const.referenceWidth, Const.referenceHeight, true);
    updateCamSize();
}

class Camera extends ecs.System {
    @:fastFamily var player : { fsm: FSM<PlayerState>, pos : Position, room: RoomState };

    var x = 0.;
    var y = 0.;

    var vhw = 0.;
    var vhh = 0.;

    var lvl: LdtkProject_Level;
    var lvlTop = 0;
    var lvlBot = 0;
    var lvlRight = 0;
    var lvlLeft = 0;

    var camTop = 0;
    var camBot = 0;
    var camRight = 0;
    var camLeft = 0;

    var lockX = false;
    var lockY = false;

    override function update(_dt: Float) {
        iterate(player, {
            x = pos.x;
            y = pos.y;

            lockX = false;
            lockY = false;

            vhw = cam.viewportWidth / 2;
            vhh = cam.viewportHeight / 2;
            lvl = getRoom(room.current);

            lvlTop = lvl.worldY;
            lvlBot = lvl.worldY + lvl.pxHei;
            lvlRight = lvl.worldX + lvl.pxWid;
            lvlLeft = lvl.worldX;

            camTop = Std.int(y - vhh);
            camBot = Std.int(y + vhh);
            camRight = Std.int(x + vhw);
            camLeft = Std.int(x - vhw);

            if(lvl.pxWid <= cam.viewportWidth) {
                x = Std.int(lvl.worldX + lvl.pxWid / 2);
                lockX = true;
            }

            if(lvl.pxHei <= cam.viewportHeight) {
                y = Std.int(lvl.worldY + lvl.pxHei / 2);
                lockY = true;
            }

            //horizontal bounds
            if (!lockX) {
                if(camRight > lvlRight)
                    x -= camRight - lvlRight;
                else if(camLeft < lvlLeft)
                    x += lvlLeft - camLeft;
            }
           
            //vertical bounds
            if(!lockY) {
                if(camBot > lvlBot)
                    y -= camBot - lvlBot;
                else if(camTop < lvlTop)
                    y += lvlTop - camTop;
            }
                            
            cam.setPosition(x, y);
        });
    }
}