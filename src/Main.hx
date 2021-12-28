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
        defaultParent = s2d;
        defaultDebugFont = hxd.res.DefaultFont.get();
        initController(); 

        Workflow.addSystem(new Player());
        Workflow.addSystem(new Enemy());
        Workflow.addSystem(new Movement());
        Workflow.addSystem(new Render());

        player(200, 200);
        enemy(300, 300);
    }

    override function update(dt:Float) {
        s2d.ysort(0);
        Workflow.update(dt);
    }

    static function main() {
        new Main();
    }
} 