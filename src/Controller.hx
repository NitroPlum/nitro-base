import hxd.Key;
import dn.heaps.input.ControllerAccess;
import dn.heaps.input.Controller;

// List of input actions to check
enum GameActions {
    MoveX;
    MoveY;
    Interact;
    Attack;
}

var controller: Controller<GameActions>;
var controllerName: String;
var ctrl: ControllerAccess<GameActions>;

function initController() {
    controller = new dn.heaps.input.Controller(GameActions);

    // Bind buttons/keys to actions
    controller.bindKeyboardAsStick(MoveX, MoveY, hxd.Key.UP, hxd.Key.LEFT, hxd.Key.DOWN, hxd.Key.RIGHT);
    controller.bindKeyboard(Attack, Key.X);
    controller.bindKeyboard(Interact, Key.SPACE);

    controller.bindPadLStick(MoveX, MoveY);
    controller.bindPad(Interact, PadButton.A);
    controller.bindPad(Attack, PadButton.X);

    // Handle controller status events
    controller.onConnect = () -> {
        controllerName = controller.pad.name;
        trace('CONNECT - ' + controllerName);
    }

    controller.onDisconnect = () -> {
        trace('DISCONNECT - ' + controllerName);
    }
    ctrl = controller.createAccess();
    
}