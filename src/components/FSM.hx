package components;

class FSM<T> {
    public var state: T;
    public var lastState: T;
    public var stateChanged = false;
    public function new (initialState: T) {
        state = initialState;
        stateChanged = true;
        lastState = initialState;
    }
    public function changeState(newState: T) {
        lastState = state;
        state = newState;
        stateChanged = true;
    }
    public function updateState() {
        if(state == lastState) {
            stateChanged = false;
            return;
        }
        stateChanged = true;
        lastState = state;
    }
}