package screens;

import Game.newGame;
import hxd.System;
import hxd.Event;
import Game.GameScreen;
import Game.changeScreen;
import systems.Camera.camW;
import systems.Camera.camH;
import h2d.Text;
import h2d.Flow;
import h2d.Object;

inline function textButton(_text: String, parent: Object, onClick: Event->Void) {
    var text = new Text(Const.menuFont, parent);
    text.text = _text;
    var button = new h2d.Interactive(text.textWidth, text.textHeight, text);
    button.backgroundColor = 0xFFFFFF;
    button.onFocus = event -> {
        trace("FOCUS");
    }
    button.onOver = event -> {
        text.textColor = 0x00FF00;
    }
    button.onOut = event -> {
        text.textColor = 0xFFFFFF;
    }
    button.onClick = event -> {
        text.textColor = 0xB721EE;
        onClick(event);
    }

    return button;
}

class StartScreen extends BaseScreen {
    var title: Flow;
    var buttons: Flow;

    public function new(?parent: Object) {
        super(defaultParent);
        title = new Flow(this);
        title.setPosition(0 - camW, 0 - camH / 2);
        buttons = new Flow(this);
        buttons.setPosition(0 - camW, 0);
        setup();
    }

    function setup() {
        title.layout = Vertical;
        title.horizontalAlign = Middle;
        title.colWidth = Const.REF_WIDTH;
        var titleText = new Text(Const.menuFont, title);
        titleText.text = Const.GAME_NAME;
        titleText.textColor = 0xB721EE;
        titleText.setPosition(0, 0);

        //buttons.debug = true;
        buttons.layout = Vertical;
        buttons.horizontalAlign = Middle;
        buttons.colWidth = Const.REF_WIDTH;
        var newGame = textButton("New Game", buttons,  e -> {
            changeScreen(GameScreen.Game);
        });
        
        var continueGame = textButton("Continue", buttons, e -> {

        });
        var settings = textButton("Settings", buttons, e -> {

        });
        var exit = textButton("Exit", buttons, e -> {
            System.exit();
        });
    }

    override function update(_dt: Float) {
        buttons.setPosition(0 - camW, 0);
    }
}