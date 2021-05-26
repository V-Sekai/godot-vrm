This GDNative addon is compiled from the sources at:

https://github.com/V-Sekai/godot-gltf-module/tree/gdnative

I have included Windows binaries. OSX and Linux are planned but not ready yet.
This module is only required for editor import. It is not required at runtime.


To build the GDNative module, run the following commands:

git clone --recursive -b gdnative https://github.com/V-Sekai/godot-gltf-module
cd godot-gltf-module
cd godot-cpp
scons target=release platform=windows generate_bindings=yes -j8
cd ..
scons target=release_debug platform=windows -j8

Then, copy the *.dll and *.pdb binaries from bin/release_debug/ into the project at addons/godot_gltf.


NOTE: Both the C++ and GDScript code assume the module is installed into res://addons/godot_gltf
If the GDNative addon is installed anywhere else, IT WILL CRASH!
