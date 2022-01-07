package components;

import hxd.Res;
import hxd.res.Loader;
import aseprite.Aseprite;
import aseprite.AseAnim;

// Todo - Move Resource to a shared location. I think every entity will have it's own clone of the Resource atm.

class Sprite {
    public var resource: Aseprite;
    public var anim: AseAnim;
    public function new (_resource: Aseprite, _anim: AseAnim) {
        resource = _resource;
        anim = _anim;
    }

    public function play(tag: String, loop: Bool = true) {
        trace("PLAY : " + tag);
        anim.play(resource.getTag(tag));
        anim.loop = loop;
    }
}

function loadAnim(aseResource: aseprite.res.Aseprite, startTag: String, parent: h2d.Object) {
    var resource = aseResource.toAseprite();
    var anim = new AseAnim(resource.getTag(startTag), parent);
    anim.loop = true;
    return new Sprite(resource, anim);
}

function play(sprite: Sprite, tag: String, loop: Bool = true) {
    trace("PLAY : " + tag);
    sprite.anim.play(sprite.resource.getTag(tag));
    sprite.anim.loop = loop;
}