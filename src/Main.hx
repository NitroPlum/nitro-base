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
import Const.defaultParent;
import Const.defaultDebugFont;
import Controller.initController;
import echoes.Workflow;

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

        Workflow.addSystem(new Player());
        Workflow.addSystem(new Enemy());
        Workflow.addSystem(new Movement());
        Workflow.addSystem(new Render());

        player(200, 200);
        enemy(300, 300);

        Window.getInstance().vsync = true;
        scaleToFit();
    }

    override function update(dt:Float) {    
        Layers.defaultLayer.ysort(0);
        Workflow.update(dt);

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
        defaultLayer.setScale( dn.heaps.Scaler.bestFit_f(Const.referenceWidth, Const.referenceHeight));
    }
    
    static function main() {
        new Main();
    }
} 