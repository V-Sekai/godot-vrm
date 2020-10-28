#!/usr/bin/env python
import sys

shader_float_to_int = {}
shader_float_to_bool = {}
shader_int_to_bool = {}
shader_vec3_to_color = {}
shader_vec4_to_color = {}
shader_refresh_properties = {}
shader_fake_params = {}

shader_props = []

def print_dictionary(decl, dic, end_decl=''):
    tabs = decl[:len(decl) - len(decl.lstrip())]
    tab = tabs[0] if tabs else '\t'
    print(decl + "{")
    for k, v in dic.items():
        if type(v) == type(()):
            print(tabs + tab + "%r: %s," % (k, v[0]))
        else:
            print(tabs + tab + "%r: %r," % (k, v))
    print(tabs + "}" + end_decl)


ifelse_last_header = None
ifelse_last_toggle = None

prop_to_add = {}
was_header = False
for xlin in sys.stdin.readlines():
    is_header = False
    xequals = xlin.strip().strip(';').strip().split("=", 1)
    xcolon = xequals[0].split(":", 1)
    x = xcolon[0].strip()
    iscolor = False
    hintstr = "" if len(xcolon) < 2 else xcolon[1].strip()
    defaultval = "" if len(xequals) < 2 else xequals[1].strip()
    xparts = x.split()
    if len(xparts) < 3:
        continue
    if not xparts[0].startswith("uniform"):
        continue
    typ = xparts[1]
    name = xparts[2]
    headername = name.split('_', 1)[-1].replace("_", " ")
    if name.startswith("HEADERELSE_"):
        shader_fake_params[headername] = ("true",)
        ifelse_last_header["name"] = ("%r if _get(%r) else %r" % (ifelse_last_header["name"], ifelse_last_toggle["name"], headername), )
        shader_props.append(("\telse:",))
        continue
    if name.startswith("HEADERALWAYS_"):
        prop_to_add["type"] = ("TYPE_NIL",)
        prop_to_add["hint"] = ("PROPERTY_HINT_NONE",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_CATEGORY",)
        prop_to_add["name"] = headername
        shader_fake_params[headername] = ("true",)
        if ifelse_last_header:
            shader_props.append((False,))
            is_header = False
            ifelse_last_header = None
            ifelse_last_toggle = None
    elif name.startswith("HEADER_"):
        newname = name[7:].replace("_", " ")
        prop_to_add["type"] = ("TYPE_NIL",)
        prop_to_add["hint"] = ("PROPERTY_HINT_NONE",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_CATEGORY",)
        prop_to_add["name"] = headername
        shader_fake_params[headername] = ("true",)
        is_header = True
        ifelse_last_header = prop_to_add
        ifelse_last_toggle = None
    elif name.startswith("ENUM_"):
        prop_to_add["type"] = ("TYPE_INT",)
        prop_to_add["hint"] = ("PROPERTY_HINT_ENUM",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_EDITOR",)
        prop_to_add["hint_string"] = ','.join(name.split("_")[1:])
        continue
    elif typ == "bool":
        prop_to_add["type"] = ("TYPE_BOOL",)
        prop_to_add["hint"] = ("PROPERTY_HINT_NONE",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_EDITOR",)
        prop_to_add.pop("hint_string", "")
        prop_to_add["name"] = name
    elif "sampler" in typ or "texture" in typ:
        prop_to_add["type"] = ("TYPE_OBJECT",)
        prop_to_add["hint"] = ("PROPERTY_HINT_RESOURCE_TYPE",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_EDITOR",)
        prop_to_add["hint_string"] = "Texture" if typ == "sampler2D" else "Object"
        prop_to_add["name"] = name
    elif typ in ("vec3", "vec4") and ("color" in name.lower() or name.lower().endswith("col")):
        iscolor = True
        prop_to_add["type"] = ("TYPE_COLOR",)
        prop_to_add["hint"] = (("PROPERTY_HINT_COLOR_NO_ALPHA" if typ == "vec3" else "PROPERTY_HINT_NONE"),)
        prop_to_add["usage"] = ("PROPERTY_USAGE_EDITOR",)
        prop_to_add.pop("hint_string", "")
        prop_to_add["name"] = name
        if typ == "vec3":
            shader_vec3_to_color[name] = ("true",)
            shader_vec3_to_color[name + "_VALUE"] = ("true",)
        else:
            shader_vec4_to_color[name] = ("true",)
            shader_vec4_to_color[name + "_VALUE"] = ("true",)
    elif typ in ("vec2", "vec3", "vec4"):
        prop_to_add["type"] = (("TYPE_VECTOR2" if typ == "vec2" else ("TYPE_VECTOR3" if typ == "vec3" else "TYPE_PLANE")),)
        prop_to_add["hint"] = ("PROPERTY_HINT_NONE",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_EDITOR",)
        prop_to_add.pop("hint_string", "")
        prop_to_add["name"] = name
    elif typ in ("mat2", "mat3", "mat4"): # or name.endswith("_ST")
        prop_to_add["type"] = (("TYPE_TRANSFORM" if typ == "mat4" else ("TYPE_BASIS" if typ == "mat3" else "TYPE_TRANSFORM2D")),)
        prop_to_add["hint"] = ("PROPERTY_HINT_NONE",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_EDITOR",)
        prop_to_add.pop("hint_string", "")
        prop_to_add["name"] = name
    elif (typ == "int" or typ == "uint" or typ == "float") and "hint_string" in prop_to_add:
        prop_to_add["name"] = name
        if typ == "float":
            shader_float_to_int[name] = ("true",)
    elif typ == "int" or typ == "uint" or typ == "float":
        prop_to_add["type"] = (("TYPE_REAL" if typ == "float" else "TYPE_INT"),)
        prop_to_add["hint"] = ("PROPERTY_HINT_NONE",)
        prop_to_add["usage"] = ("PROPERTY_USAGE_EDITOR",)
        prop_to_add["name"] = name
        if "hint_range" in hintstr:
            hint_string = hintstr.split('(')[1].split(')')[0]
            range_vals = [float(xrn) for xrn in hint_string.split(',')]
            if len(range_vals) > 2 and range_vals[2] == 1 and range_vals[1] == 1:
                if typ == "float":
                    shader_float_to_bool[name] = ("true",)
                    prop_to_add["type"] = ("TYPE_BOOL",)
                else:
                    shader_int_to_bool[name] = ("true",)
                    prop_to_add["type"] = ("TYPE_BOOL",)
            else:
                if len(range_vals) > 2 and range_vals[2] == 1 and typ == "float":
                    shader_float_to_int[name] = ("true",)
                    prop_to_add["type"] = ("TYPE_INT",)
                prop_to_add["hint"] = ("PROPERTY_HINT_RANGE",)
                prop_to_add["hint_string"] = hint_string
    if prop_to_add:
        if is_header:
            shader_props.append((False,))
        shader_props.append(prop_to_add)
        if iscolor:
            prop_to_add = dict(prop_to_add)
            shader_refresh_properties[prop_to_add["name"]] = ("true",)
            prop_to_add["name"] += "_VALUE"
            prop_to_add["type"] = (("TYPE_VECTOR3" if typ == "vec3" else "TYPE_PLANE"),)
            shader_props.append(prop_to_add)
            shader_refresh_properties[prop_to_add["name"]] = ("true",)
        if was_header and (prop_to_add["type"] == ("TYPE_BOOL",) or prop_to_add["hint"] == ("PROPERTY_HINT_ENUM",)):
            ifelse_last_toggle = prop_to_add
            shader_refresh_properties[prop_to_add["name"]] = ("true",)
            shader_props.append(("\tif _get(%r):" % prop_to_add["name"],))
        prop_to_add = {}
        was_header = False
        if is_header:
            was_header = True


print("tool")
print("extends ShaderMaterial")
print("")
print_dictionary("var shader_float_to_int : Dictionary = ", shader_float_to_int)
print_dictionary("var shader_int_to_bool : Dictionary = ", shader_int_to_bool)
print_dictionary("var shader_float_to_bool : Dictionary = ", shader_float_to_bool)
print_dictionary("var shader_refresh_properties : Dictionary = ", shader_refresh_properties)
print_dictionary("var shader_fake_params : Dictionary = ", shader_fake_params)
print_dictionary("var shader_vec3_to_color : Dictionary = ", shader_vec3_to_color)
print_dictionary("var shader_vec4_to_color : Dictionary = ", shader_vec4_to_color)

print("""

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

""")
print("func _get_property_list():")
print("\tvar props: Array = []")
indent = ''
for prop in shader_props:
    if type(prop) == type(()):
        if prop[0]:
            print(prop[0])
            indent = '\t'
        else:
            print("")
            indent = ''
    else:
        print_dictionary(indent + "\tprops.push_back(", prop, end_decl=')')
print("\treturn props")
