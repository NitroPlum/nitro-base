import systems.Rooms.project;
import Layers.groundLayer;
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
import systems.Camera;
import Const.UNIVERSE;
import Controller.initController;
import ecs.Universe;

class Main extends hxd.App {
    override function init() {
        trace('GAME START');
        hxd.Res.initEmbed();
        initLayers(s2d);
        
        defaultParent = Layers.defaultLayer;
        defaultDebugFont = hxd.res.DefaultFont.get();
        initController();

        UNIVERSE = new Universe(Const.MAX_ENTITIES);
        UNIVERSE.setSystems(
            Player,
            Enemy,
            Rooms,
            Movement,
            Render,
            Camera
        );

        player(0, 0, project.all_levels.Level_0);

        initCamera(s2d);
        #if (hl)
        initEditor();
        #end
        
        Window.getInstance().vsync = true;
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
        //letterbox();

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