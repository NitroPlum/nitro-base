import ase.Layer;
import h2d.Layers;

// RENDERING LAYERS
var groundLayer: h2d.Layers;
var defaultLayer: h2d.Layers;
var uiLayer: h2d.Layers;
var editorLayer: h2d.Layers;

function initLayers(root: h2d.Object) {
    groundLayer = new Layers(root);
    defaultLayer = new Layers(root);
    uiLayer = new Layers(root);
    editorLayer = new Layers(root);
}