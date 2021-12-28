package components;

enum Facing {
    N;
    S;
    E;
    W;
}

function updateFacing(facing: Facing, dir: hxmath.math.Vector2) {
    var absX = Math.abs(dir.x);
    var absY = Math.abs(dir.y);

    if(absX > absY) {
        // Horizontal
        facing = dir.x >= 0 ? Facing.E : Facing.W;
    } else {
        //Vertical
        facing = dir.y >= 0 ? Facing.N : Facing.S;
    }
}