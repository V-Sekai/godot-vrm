extends Resource

# Bone name references are only valid within the given Skeleton.
# If the node was not a skeleton, bone is "" and contains a path to the node.
export var skeleton_or_node: NodePath

# The bone within the skeleton with the collider, or "" if not a bone.
export var bone: String

# Note that Plane is commonly used in Godot in place of a Vector4.
# The "normal" property of Plane holds a Vector3 of data.
# There is a comment saying it "must be normalized".
# However, this is not enforced and regularly violated in the core engine itself.

# Plane.normal = The local coordinate from the node of the collider group in *left-handed* Y-up coordinate.
# Plane.d = The radius of the collider.
export (Array, Plane) var sphere_colliders: Array # DO NOT INITIALIZE HERE
