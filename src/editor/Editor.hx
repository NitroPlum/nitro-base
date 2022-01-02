package editor;

import imgui.ImGuiDrawable;
import hxd.Timer;
import hxd.Key;
import imgui.ImGui;

var showEditor = false;
var imguiDrawable:ImGuiDrawable;

var status: Array<String>;

function initEditor(){
    imguiDrawable = new ImGuiDrawable(Layers.editorLayer);
    status = new Array<String>();
}

function editorUpdate(dt: Float) {
    if(Key.isPressed(hxd.Key.QWERTY_TILDE)) {
        showEditor = !showEditor;
        Layers.editorLayer.visible = showEditor;
    } 
    if(showEditor) {
        ImGui.newFrame();
        showStatus(Std.int(Timer.fps()));
        // ImGui.showDemoWindow();
        ImGui.render();  
        ImGui.endFrame();
    }
    imguiDrawable.update(dt);
}

function editorResize(width: Int, height: Int) {
    ImGui.setDisplaySize(width, height);
}

function showStatus(fps: Int) {
    // Settings
    var window_flags = ImGuiWindowFlags.NoDecoration | ImGuiWindowFlags.AlwaysAutoResize | ImGuiWindowFlags.NoSavedSettings | ImGuiWindowFlags.NoFocusOnAppearing | ImGuiWindowFlags.NoNav;
    var position: ImVec2 = {
        x: 0,
        y: 0
    }
    var windowPivot: ImVec2 = {
        x: 0,
        y: 0
    }
    ImGui.setNextWindowPos(position,ImGuiCond.Always, windowPivot);
    window_flags |= ImGuiWindowFlags.NoMove;
    ImGui.setNextWindowBgAlpha(0.35);

    // Build Window
    if (ImGui.begin("Example: Simple overlay", showEditor, window_flags)) {
        ImGui.text("Game Status");
        ImGui.separator();
        ImGui.text("FPS : " + fps);
        ImGui.separator();
        for(msg in status) {
            ImGui.text(msg);
        }
    }
    ImGui.end();
}