package components;

import hscript.Expr;

var parser = new hscript.Parser();
var interp = new hscript.Interp();

class Script {
    public var program: Expr;
    public function new(script: String) {
        program = parser.parseString(script);
    }
}

function runScript(script: Script) {
    interp.expr(script.program);
}