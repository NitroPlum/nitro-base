import components.Tiles.tilesCache;
import components.CurrentRoom;
import Layers.groundLayer;
import systems.Rooms.initRooms;
import systems.Rooms.Rooms;
import Layers.defaultLayer;
import editor.Editor.initEditor;
import editor.Editor.editorResize;
import editor.Editor.editorUpdate;
import Layers.initLayers;
import hxd.Window;
import hxd.App;
import h2d.Layers;
import systems.Player;
import systems.Enemy;
import systems.Render;
import systems.Movement;
import Const.UNIVERSE;
import Controller.initController;
import ecs.Universe;

class Main extends hxd.App {
    override function init() {
        trace('GAME START');
        hxd.Res.initEmbed();
        initLayers(s2d);
        #if (hl)
        initEditor();
        #end
        
        defaultParent = Layers.defaultLayer;
        defaultDebugFont = hxd.res.DefaultFont.get();
        initController();

        UNIVERSE = new Universe(Const.MAX_ENTITIES);
        UNIVERSE.setSystems(
            Player,
            Enemy,
            Movement,
            Rooms,
            Render
        );

        player(new CurrentRoom(-1), 70, 70);
        enemy(100, 100);

        initRooms();
        Window.getInstance().vsync = true;
        scaleToFit();
        components.Tiles.cacheTiles();
    }

    override function update(dt:Float) {    
        Layers.defaultLayer.ysort(0);
        UNIVERSE.update(dt);

        #if (hl)
        editorUpdate(dt);
        #end
    }

    override function onResize() {
        scaleToFit();

        #if (hl)
        editorResize(s2d.width, s2d.height);
        #end
    }

    function scaleToFit() {
        groundLayer.setScale( dn.heaps.Scaler.bestFit_f(Const.referenceWidth, Const.referenceHeight));
        defaultLayer.setScale( dn.heaps.Scaler.bestFit_f(Const.referenceWidth, Const.referenceHeight));
    }
    
    static function main() {
        new Main();
    }
} 