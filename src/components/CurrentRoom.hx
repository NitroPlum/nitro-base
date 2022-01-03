package components;

class RoomState {
    public var current: Int = -1;
    public var last:    Int = -1;
    public var next:    Int = -1;
    
    public function new(_uid: Int) {
        current = _uid;
    }
}