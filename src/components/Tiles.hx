package components;

import haxe.EnumFlags;
import systems.Rooms.project;

class Tiles {
    // Tile we are currently standing on AFTER collision resolution;    
    var on: Int;

    // Tiles we collided with but were moved from. Examples :
    // Walls we hit. Spikes we hit. Conveyors that moved us. Bouncers. Etc.
    var touchX: Null<Int>;
    var touchY: Null<Int>;
}

// TODO: Aggregate enum properties from all tiles in stacks for better support
/*
    This function makes a few assumptions to make life easier.
    - Levels are never placed at negative coordinates (this would change the math)
    - Every tileset uses the same enum
    - Each cache represents a single layer
    - Assumes all logic is on the bottom tile of the stack
*/
var tilesCache: Array<Array<EnumFlags<Enum_TileEnum>>> = new Array<Array<EnumFlags<Enum_TileEnum>>>() ;
function cacheTiles() {
    // Initialize cache size
    // tilesCache[ MAP_MAX_WIDTH ] = new Array<EnumFlags<Enum_TileEnum>>();
    // tilesCache[ MAP_MAX_WIDTH ][ MAP_MAX_HEIGHT ] = new Array<EnumFlags<Enum_TileEnum>>();
    for(x in 0...MAP_MAX_WIDTH) {
        tilesCache[x] = new Array<EnumFlags<Enum_TileEnum>>();
        for(y in 0...MAP_MAX_HEIGHT) {
            tilesCache[x][y] = new EnumFlags<Enum_TileEnum>();
        }
    }

    for(level in project.levels) {
        var layer = level.l_GROUND;
        var tileset = layer.tileset;

        // Top-level position of level represented in tiles.
        var levelPosX = Std.int(level.worldX / TILE_SIZE);
        var levelPosY = Std.int(level.worldY / TILE_SIZE);

        // Number of tiles this level is
        var cWid = layer.cWid;
        var cHei = layer.cHei;
    
        var currTileId: Int;
        // Build 1 column at a time
        for(x in 0...cWid) {
            for(y in 0...cHei) {
                // Does a Tile exist?
                if(layer.hasAnyTileAt(x, y)) {
                    // Prepare to store flags
                    var flags: EnumFlags<Enum_TileEnum> = new EnumFlags<Enum_TileEnum>();
                    // Get the tile itself
                    // TODO : Flatten values of all tiles in the stack to increase feature support
                    currTileId = layer.getTileStackAt(x, y)[0].tileId;
                    // Store all tags in a single EnumFlag
                    for(tag in tileset.getAllTags(currTileId)) {
                        flags.set(tag);
                    }
                    // Store new flags at corresponding location in the grid
                    tilesCache[levelPosX + x][levelPosY + y] = flags;
                }
            }
        }
    }
}

function hasTag(x: Int, y: Int, tag:Enum_TileEnum) {
    if(x > MAP_MAX_WIDTH || y > MAP_MAX_WIDTH || x < 0 || x < 0) {
        trace('ERROR : REQUESTED POS OUT OF BOUNDS');
        return false;
    } 

    return tilesCache[x][y].has(tag);
}
