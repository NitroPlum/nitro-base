package systems;

import ecs.System;

// Circular area we can use to test
class CheckArea {
    public var x: Int;
    public var y: Int;
    public var radius: Float;
    public var enabled: Bool = false;
    public var sinceEnabled: Int; // How long since first enabled? We can use this to check for parry timing
}

typedef Hitbox = CheckArea;
typedef Hurtbox = CheckArea;
typedef Blockbox = CheckArea;

function touches(a: CheckArea, b: CheckArea) {
    var maxDistance = a.radius + b.radius;
    var distanceSquared = (b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y);
    return distanceSquared <= maxDistance * maxDistance;
}

class Hitboxes extends System {
    // Everything has a hit/hurt/block box. Just disable/enable them as needed;
    // tick sinceEnabled timers on each box, then resolve
}