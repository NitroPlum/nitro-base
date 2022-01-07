// SETTINGS
final GAME_NAME = "Nitro Base";
final REF_WIDTH = 160;
final REF_HEIGHT = 144;
final MAX_ENTITIES = 2048;
final TILE_SIZE = 16;
final MAP_MAX_HEIGHT = 256;
final MAP_MAX_WIDTH = 256;

// Global References
var UNIVERSE: ecs.Universe;
var defaultParent: h2d.Object;
var defaultDebugFont : h2d.Font;
var menuFont: h2d.Font;

function loadFonts() {
    defaultDebugFont = hxd.res.DefaultFont.get();
    menuFont = hxd.Res.fonts.monogram.toFont();
}
