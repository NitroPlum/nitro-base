package components;

class Position {
    // World coordinates
    public var x: Float;
    public var y: Float;
    // Tile coordinates of position
    public var tileX: Int; 
    public var tileY: Int;
    // How far into tile are we?
    public var xRatio: Float;
    public var yRatio: Float;

    public function new(_x: Float, _y: Float) {
        x = _x;
        y = _y;
        tileX = Std.int(x / Const.TILE_SIZE);
        tileY = Std.int(y / Const.TILE_SIZE);
        xRatio = ((x - tileX * TILE_SIZE) / TILE_SIZE) - 1;
        yRatio = ((y - tileY * TILE_SIZE) / TILE_SIZE) - 1;
    }
}