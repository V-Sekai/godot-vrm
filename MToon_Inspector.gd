tool
extends ShaderMaterial

var shader_float_to_int : Dictionary = {
	'_DebugMode': true,
}
var shader_int_to_bool : Dictionary = {
}
var shader_float_to_bool : Dictionary = {
	'_EnableAlphaCutout': true,
	'_OutlineColorMode': true,
}
var shader_refresh_properties : Dictionary = {
	'_Color': true,
	'_Color_VALUE': true,
	'_ShadeColor': true,
	'_ShadeColor_VALUE': true,
	'_RimColor': true,
	'_RimColor_VALUE': true,
	'_EmissionColor': true,
	'_EmissionColor_VALUE': true,
	'_OutlineColor': true,
	'_OutlineColor_VALUE': true,
}
var shader_fake_params : Dictionary = {
}
var shader_vec3_to_color : Dictionary = {
}
var shader_vec4_to_color : Dictionary = {
	'_Color': true,
	'_Color_VALUE': true,
	'_ShadeColor': true,
	'_ShadeColor_VALUE': true,
	'_RimColor': true,
	'_RimColor_VALUE': true,
	'_EmissionColor': true,
	'_EmissionColor_VALUE': true,
	'_OutlineColor': true,
	'_OutlineColor_VALUE': true,
}


func to_linear(c: Color) -> Color:
	return Color(
		c.r * (1.0 / 12.92) if c.r < 0.04045 else pow((c.r + 0.055) * (1.0 / (1 + 0.055)), 2.4),
		c.g * (1.0 / 12.92) if c.g < 0.04045 else pow((c.g + 0.055) * (1.0 / (1 + 0.055)), 2.4),
		c.b * (1.0 / 12.92) if c.b < 0.04045 else pow((c.b + 0.055) * (1.0 / (1 + 0.055)), 2.4),
		c.a)

func to_srgb(c: Color) -> Color:
	return Color(
		12.92 * c.r if c.r < 0.0031308 else (1.0 + 0.055) * pow(c.r, 1.0 / 2.4) - 0.055,
		12.92 * c.g if c.g < 0.0031308 else (1.0 + 0.055) * pow(c.g, 1.0 / 2.4) - 0.055,
		12.92 * c.b if c.b < 0.0031308 else (1.0 + 0.055) * pow(c.b, 1.0 / 2.4) - 0.055,
		c.a)

func _get(property):
	if shader_fake_params.has(property):
		# return null if ret == false else 0
		return null
	var raw_value = false
	if property.ends_with('_VALUE') and (shader_vec3_to_color.has(property) or shader_vec4_to_color.has(property)):
		raw_value = true
		property = property.substr(0, property.length() - 6)
	if shader.has_param(property):
		var ret = get_shader_param(property)
		if shader_float_to_int.has(property):
			if typeof(ret) != typeof(1.234):
				print("property " + str(property) + " type " + str(typeof(ret)) + " ret " + str(ret))
			ret = int(ret)
		if shader_float_to_bool.has(property):
			ret = false if ret == 0.0 else true
		if shader_int_to_bool.has(property):
			ret = false if ret == 0 else true
		if not raw_value and shader_vec3_to_color.has(property):
			ret = to_srgb(Color(ret.x, ret.y, ret.z))
		if not raw_value and shader_vec4_to_color.has(property):
			ret = to_srgb(Color(ret.normal.x, ret.normal.y, ret.normal.z, ret.d))
		return ret

func _set(property, value):
	if shader_fake_params.has(property):
		# value = false if (value == null) else true
		return true
	var raw_value = false
	if property.ends_with('_VALUE') and (shader_vec3_to_color.has(property) or shader_vec4_to_color.has(property)):
		raw_value = true
		property = property.substr(0, property.length() - 6)
	print("Set " + property + " to " + str(typeof(value)) + "," + str(value))
	if shader.has_param(property):
		if shader_float_to_int.has(property):
			value = float(value)
		if shader_float_to_bool.has(property):
			value = 1.0 if value else 0.0
		if shader_int_to_bool.has(property):
			value = 1 if value else 0
		if not raw_value and shader_vec3_to_color.has(property):
			value = to_linear(value)
			value = Vector3(value.r, value.g, value.b)
		if not raw_value and shader_vec4_to_color.has(property):
			value = to_linear(value)
			value = Plane(value.r, value.g, value.b, value.a)
		set_shader_param(property, value) # One can implement custom setter logic here
		if shader_refresh_properties.has(property):
			property_list_changed_notify()
		return true


func _get_property_list():
	var props: Array = []
	props.push_back({
		'type': TYPE_BOOL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_EnableAlphaCutout',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_Cutoff',
		'hint_string': '0,1',
	})
	props.push_back({
		'type': TYPE_COLOR,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_Color',
	})
	props.push_back({
		'type': TYPE_PLANE,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_Color_VALUE',
	})
	props.push_back({
		'type': TYPE_COLOR,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_ShadeColor',
	})
	props.push_back({
		'type': TYPE_PLANE,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_ShadeColor_VALUE',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_MainTex',
	})
	props.push_back({
		'type': TYPE_PLANE,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_MainTex_ST',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_ShadeTexture',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_BumpScale',
		'hint_string': '-16,16',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_BumpMap',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_ReceiveShadowTexture',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_ReceiveShadowRate',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_ShadingGradeTexture',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_ShadingGradeRate',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_ShadeShift',
		'hint_string': '-1.0, 1.0',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_ShadeToony',
		'hint_string': '0.0, 1.0',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_LightColorAttenuation',
		'hint_string': '0.0, 1.0',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_IndirectLightIntensity',
		'hint_string': '0.0, 1.0',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_RimTexture',
	})
	props.push_back({
		'type': TYPE_COLOR,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_RimColor',
	})
	props.push_back({
		'type': TYPE_PLANE,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_RimColor_VALUE',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_RimLightingMix',
		'hint_string': '0.0, 1.0',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_RimFresnelPower',
		'hint_string': '0.0, 100.0',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_RimLift',
		'hint_string': '0.0, 1.0',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_SphereAdd',
	})
	props.push_back({
		'type': TYPE_COLOR,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_EmissionColor',
	})
	props.push_back({
		'type': TYPE_PLANE,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_EmissionColor_VALUE',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_EmissionMap',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_OutlineWidthTexture',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_OutlineWidth',
		'hint_string': '0.01, 1.0',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_OutlineScaledMaxDistance',
		'hint_string': '1,10',
	})
	props.push_back({
		'type': TYPE_BOOL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_OutlineColorMode',
	})
	props.push_back({
		'type': TYPE_COLOR,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_OutlineColor',
	})
	props.push_back({
		'type': TYPE_PLANE,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_OutlineColor_VALUE',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_OutlineLightingMix',
		'hint_string': '0,1',
	})
	props.push_back({
		'type': TYPE_OBJECT,
		'hint': PROPERTY_HINT_RESOURCE_TYPE,
		'usage': PROPERTY_USAGE_EDITOR,
		'hint_string': 'Texture',
		'name': '_UvAnimMaskTexture',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_UvAnimScrollX',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_UvAnimRotation',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_UvAnimScrollY',
	})
	props.push_back({
		'type': TYPE_INT,
		'hint': PROPERTY_HINT_RANGE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_DebugMode',
		'hint_string': '0,3,1',
	})
	props.push_back({
		'type': TYPE_REAL,
		'hint': PROPERTY_HINT_NONE,
		'usage': PROPERTY_USAGE_EDITOR,
		'name': '_MToonVersion',
	})
	return props
