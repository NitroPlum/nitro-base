package components;

import h2d.col.Point;

class Facing {
    public var dir: Cardinal;
    public function new () {
        dir = Cardinal.S;
    };
}

enum Cardinal {
    N;
    S;
    E;
    W;
}

// Moves a cell position in direction of facing
function offsetByFacing(facing: Facing, x:Int, y:Int) {
    var off = new h2d.col.Point(x, y);
    
    switch facing.dir {
        case N: {
            off.y--;
        }
        case S: {
            off.y++;
        }
        case E: {
            off.x++;
        }
        case W: {
            off.x--;
        }
    }

    return off;
} 

function updateFacing(dir: Point) {
    var facing = Cardinal.S;

    var absX = Math.abs(dir.x);
    var absY = Math.abs(dir.y);

    if(absX > absY) {
        // Horizontal
        facing = dir.x >= 0 ? Cardinal.E : Cardinal.W;
    } else {
        //Vertical
        facing = dir.y >= 0 ? Cardinal.S : Cardinal.N;
    }

    return facing;
}