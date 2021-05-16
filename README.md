# VRM addon for Godot.

This module fully implements an importer for models with the [VRM specification, version 0.0](https://github.com/vrm-c/vrm-specification/tree/master/specification/0.0):

IMPORT support for VRM 0.0 is fully supported. Retargeting for animation currently requires an external script.

* vrm.blendshape
  * binds / blend shapes: implemented (Animation tracks)
  * material binds: implemented (Animation tracks)
* vrm.firstperson
  * firstPersonBone: implemented (Metadata)
  * meshAnnotations / head shrinking: implemented (Animation method track `TODO_scale_bone`)
  * lookAt: implemented (Animation tracks)
* vrm.humanoid
  * humanBones: implemented (Metadata dictionary)
  * Unity HumanDescription values: **unsupported**
  * Automatic mesh retargeting: **planned**
* vrm.material
  * shader
    * VRM/MToon: fully implemented
    * VRM/UnlitTransparentZWrite: fully implemented
    * VRM_USE_GLTFSHADER with PBR: fully implemented
    * VRM_USE_GLTFSHADER with KHR_materials_unlit: fully implemented
    * legacy UniVRM shaders (VRM/Unlit*): supported
    * legacy UniGLTF shaders (UniGLTF/UniUnlit, Standard): uses GLTF material
  * renderQueue: implemented (maps to render_priority; not consistent between models)
  * floatProperties, vectorProperties, textureProperties: implemented
* vrm.meta (Metadata)
* vrm.secondaryanimation (Springbone)
  * boneGroups: fully implemented (engine optimization patch is recommended)
  * colliderGroups: (**recommended engine optimization patch is recommended)

EXPORT is completely unsupported. Support will be added using the Godot 4.x GLTF Export feature in the future

## Godot 3.x

For VRM, use this **godot3** branch.

Runtime VRM usage (springbones, metadata) works out-of-the-box with any official Godot engine 3.3 or above.

To import VRM files and use the Editor Plugin, **you must compile godot with the gltf module!**

Required modules (clone into the modules/ directory, or else use `custom_modules=` when building):
* gltf module: https://github.com/V-Sekai/godot-gltf-module

Recommended engine patches for performance:
* Springbone support: https://github.com/V-Sekai/godot branch `improve_skeleton_for_vrm_3.2`

## Godot 4.x

Please use the **master** branch for Godot 4.x support.

## How to use

Make sure to build the engine with the `godot-gltf-module` as described above. This module is not needed for runtime.

Install the vrm addon folder into addons/vrm. MUST NOT BE RENAMED: This path will be referenced by generated VRM meta scripts.

Install Godot-MToon-Shader into addons/Godot-MToon-Shader. MUST NOT BE RENAMED: This path is referenced by generated materials.

Enable the plugin in Project Settings -> Plugins -> VRM
