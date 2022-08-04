extends Resource

# VRM extension is for 3d humanoid avatars (and models) in VR applications.
# Meta schema:

# Title of VRM model
@export var title: String

# Version of VRM model
@export var version: String

# Author of VRM model
@export var author: String

# Contact Information of VRM model author
@export var contact_information: String

# Reference of VRM model
@export var reference_information: String

# Thumbnail of VRM model
@export var texture: Texture

# A person who can perform with this avatar
@export var allowed_user_name: String
 # (String,"","OnlyAuthor","ExplicitlyLicensedPerson","Everyone")
# Permission to perform violent acts with this avatar
@export var violent_usage: String
 # (String,"","Disallow","Allow")
# Permission to perform sexual acts with this avatar
@export var sexual_usage: String
 # (String,"","Disallow","Allow")
# For commercial use
@export var commercial_usage: String
 # (String,"","Disallow","Allow")
# If there are any conditions not mentioned above, put the URL link of the license document here.
@export var other_permission_url: String

# License type
@export var license_name: String
 # (String,"","Redistribution_Prohibited","CC0","CC_BY","CC_BY_NC","CC_BY_SA","CC_BY_NC_SA","CC_BY_ND","CC_BY_NC_ND","Other")
# If "Other" is selected, put the URL link of the license document here.
@export var other_license_url: String


# Human bone name -> Reference node index
# NOTE: We are currently discarding all Unity-specific data.
# We may need to store it somewhere in case we wish to re-export.
@export var humanoid_bone_mapping: BoneMap # VRM boneName -> bone name (within skeleton)

@export var humanoid_skeleton_path: NodePath = NodePath()

# firstPersonBoneOffset:
# The target position of the VR headset in first-person view.
# It is assumed that an offset from the head bone to the VR headset is added.
@export var eye_offset: Vector3
# NOTE: Mouth offset is not stored in any model metadata.
# As an alternative, we could get the centroid of vertices moved by viseme blend shapes.
# But for now, users should assume same as eyeOffset with y=0 (relative to head)


# Toplevel schema, belongs in vrm_meta:
# Version of exporter that vrm created. UniVRM-0.46
@export var exporter_version: String

# Version of VRM specification. 0.0
@export var spec_version: String
