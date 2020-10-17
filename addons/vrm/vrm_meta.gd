extends Resource
class_name VRMMeta
# Declare member variables here. Examples:
# Meta schema:
export var title: String
export var version: String
export var author: String
export var contactInformation: String
export var reference: String
export var texture: Texture
export(String,"OnlyAuthor","ExplicitlyLicensedPerson","Everyone") var allowedUserName: String
export(String,"Disallow","Allow") var violentUsage: String
export(String,"Disallow","Allow") var sexualUsage: String
export(String,"Disallow","Allow") var commercialUsage: String
export var otherPermissionUrl: String
export(String,"Redistribution_Prohibited","CC0","CC_BY","CC_BY_NC","CC_BY_SA","CC_BY_NC_SA","CC_BY_ND","CC_BY_NC_ND","Other") var licenseName: String
export var otherLicenseUrl: String

export var skeleton: NodePath
export var animplayer: NodePath

export var humanoid_bone_mapping: Dictionary # VRM boneName -> bone idx (within skeleton)

export var eye_offset: Vector3
export var mouth_offset: Vector3 # Inferred

# Toplevel schema:
export var exporterVersion: String
export var specVersion: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
