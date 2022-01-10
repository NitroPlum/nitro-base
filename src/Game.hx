import screens.SplashScreen;
import screens.CreditsScreen;
import screens.BaseScreen;
import screens.StartScreen;
import systems.Rooms;
import systems.Player;
import systems.Enemy;
import systems.Sprites;
import systems.Movement;
import systems.Camera;
import systems.Hitboxes;
import systems.UI;
import systems.Interactions;
import Const.UNIVERSE;
import ecs.Universe;

enum GameScreen {
    Splash;
    Start;
    Game;
    Credits;
}

var screen = GameScreen.Splash;
var currentScreen: BaseScreen = null;

inline function changeScreen(gs: GameScreen, ?gameSave: Int) {
    if(currentScreen != null ) currentScreen.remove();
    screen = gs;
    
    switch screen {
        case GameScreen.Splash:
            currentScreen = new SplashScreen();

        case GameScreen.Start:
            currentScreen = new StartScreen();
        
        case GameScreen.Credits:
            currentScreen = new CreditsScreen();

        case GameScreen.Game: {
            if(gameSave != null)
                continueGame(gameSave);
            else {
                newGame();
            }
        }

        case _:
    }
}

inline function update(_dt: Float) {
    if(screen != Game)
        currentScreen.update(_dt);
    else
        updateGame(_dt);
}

inline function newGame() {
    // create new data and start from set location
    initGame();
    loadRoom(project.all_levels.Level_0);
    components.Tiles.cacheTiles();
}

// This is just an Int as a placeholder
inline function continueGame(gameSave: Int) {
    // load data and start from specified level
} 

inline function initGame() {
    Const.UNIVERSE = Universe.create({
        entities : 1024,
        phases   : [
            {
                name    : 'update',
                systems : [ Player,
                    Enemy,
                    Rooms,
                    Movement,
                    Hitboxes,
                    Sprites,
                    Camera,
                    UI,
                    Interactions]
            }
        ]
    });

    initCamera(s2d);
}

inline function updateGame(_dt: Float) {
    UNIVERSE.update(_dt);
}