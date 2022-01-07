import Game.newGame;
import systems.Camera.initCamera;
import systems.Camera.letterbox;
import editor.Editor.initEditor;
import editor.Editor.editorResize;
import Layers.initLayers;
import hxd.Window;
import hxd.App;
import h2d.Layers;

import Controller.initController;

class Main extends hxd.App {
    override function init() {
        hxd.Res.initEmbed();
        initLayers(s2d);
        initCamera(s2d);
        systems.Hitboxes.initHitboxDebug(s2d);
        
        defaultParent = Layers.defaultLayer;
        loadFonts();
        initController();

        #if (hl)
        initEditor();
        #end
        
        Window.getInstance().vsync = true;
        Window.getInstance().resize(Const.REF_WIDTH * 4, Const.REF_HEIGHT * 4);
        Window.getInstance().title = Const.GAME_NAME;

        initGame();
    }

    function initGame() {
        var testing = Std.parseInt(haxe.macro.Compiler.getDefine("nitro"));
        if(testing == 1) {
            //Try to load from a save file.
            // Game.changeScreen(Game.GameScreen.Game, SOME SAVE FILE);
            // else
            Game.changeScreen(Game.GameScreen.Game);
        }
        else
            Game.changeScreen(Game.GameScreen.Splash);
    }
    
    override function update(dt:Float) {    
        Layers.defaultLayer.ysort(0);
        Game.update(dt);

        // #if (hl)
        // editorUpdate(dt);
        // #end
    }

    override function onResize() {
        letterbox();

        #if (hl)
        editorResize(s2d.width, s2d.height);
        #end
    }
    
    static function main() {
        new Main();
    }
} 