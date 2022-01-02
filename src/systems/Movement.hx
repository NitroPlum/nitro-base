package systems;

import components.Tiles.hasTag;
import ecs.System;
import components.Position;
import components.Velocity;

class Movement extends System {
    @:fastFamily var movables : { pos : Position, vel : Velocity };
    override function update(_dt: Float) {
        iterate(movables, {
            // This should work fine unless we are moving at extreme speeds?
            // Might need to move in multiple passes for some games?
            // Maybe step X 1 cell, then y 1 cell, then iterate for num of cells?
            
            // Move on X
            pos.xRatio += vel.x;
            // Check Right
            
            if(pos.xRatio >= 0.7 && hasTag(pos.tileX + 1, pos.tileY, Enum_TileEnum.COLLIDE)) {
                pos.xRatio = 0.7;
                vel.x = 0;
            }

            // Check Left
            if(pos.xRatio <= 0.3 && hasTag(pos.tileX -1, pos.tileY, Enum_TileEnum.COLLIDE)) {
                pos.xRatio = 0.3;
                vel.x = 0;
            }
            
            // Convert large X ratios into new tile positions;
            while(pos.xRatio > 1) {pos.tileX++; pos.xRatio--;}
            while(pos.xRatio < 0) {pos.tileX--; pos.xRatio++;}

            // Move on Y
            pos.yRatio += vel.y;
            
            // Check Bottom
            if(pos.yRatio >= 1.0 && hasTag(pos.tileX, pos.tileY + 1, Enum_TileEnum.COLLIDE)) {
                pos.yRatio = 1.0;
                vel.y = 0;
            }

            // Check Top
            if(pos.yRatio <= 0.5 &&  hasTag(pos.tileX, pos.tileY - 1, Enum_TileEnum.COLLIDE)) {
                pos.yRatio = 0.5;
                vel.y = 0;
            }

            // Convert large Y ratios into new tile positions;
            while(pos.yRatio > 1) {pos.tileY++; pos.yRatio--;}
            while(pos.yRatio < 0) {pos.tileY--; pos.yRatio++;}

            // Finally : Update the world position
            pos.x = Std.int((pos.tileX + pos.xRatio) * TILE_SIZE);
            pos.y = Std.int((pos.tileY + pos.yRatio) * TILE_SIZE);
        });
    }
}