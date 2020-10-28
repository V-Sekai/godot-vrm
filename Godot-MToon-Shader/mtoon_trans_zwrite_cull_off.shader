shader_type spatial;
//render_mode specular_disabled,ambient_light_disabled;

// VARIANTS:
// DEFAULT_MODE:
const float isOutline = 0.0;

// OUTLINE:
// // Comment `const float isOutline = 0.0;`
// render_mode cull_front;
// const float isOutline = 1.0;
// // Uncomment `ALPHA = alpha;` and comment `if (alpha < _Cutoff) { discard; }` at end of fragment()

// TRANSPARENT:
// // Uncomment `ALPHA = alpha;` and comment `if (alpha < _Cutoff) { discard; }` at end of fragment()

// TRANSPARENT_WITH_ZWRITE:
//render_mode depth_draw_always;
// // Uncomment `ALPHA = alpha;` and comment `if (alpha < _Cutoff) { discard; }` at end of fragment()

// CULL_OFF:
// render_mode cull_disabled;

// TRANSPARENT_CULL_OFF:
// render_mode cull_disabled;
// // Uncomment `ALPHA = alpha;` and comment `if (alpha < _Cutoff) { discard; }` at end of fragment()

// TRANSPARENT_WITH_ZWRITE_CULL_OFF:
render_mode cull_disabled,depth_draw_always;
// Uncomment `ALPHA = alpha;` and comment `if (alpha < _Cutoff) { discard; }` at end of fragment()


const bool CALCULATE_LIGHTING_IN_FRAGMENT = true;


uniform float _EnableAlphaCutout : hint_range(0,1,1) = 0.0;
uniform float _Cutoff : hint_range(0,1) = 0.5;
uniform vec4 _Color /*: hint_color*/ = vec4(1.0,1.0,1.0,1.0); // "Lit Texture + Alpha"
uniform vec4 _ShadeColor /*: hint_color*/ = vec4(0.97, 0.81, 0.86, 1); // "Shade Color"
uniform sampler2D _MainTex : hint_albedo;
uniform vec4 _MainTex_ST = vec4(1.0,1.0,0.0,0.0);
uniform sampler2D _ShadeTexture : hint_albedo;
uniform float _BumpScale : hint_range(-16,16) = 1.0; // "Normal Scale"
uniform sampler2D _BumpMap : hint_normal; // "Normal Texture"
uniform sampler2D _ReceiveShadowTexture : hint_white;
uniform float _ReceiveShadowRate = 1.0; // "Receive Shadow"
uniform sampler2D _ShadingGradeTexture : hint_white;
uniform float _ShadingGradeRate = 1.0; // "Shading Grade"
uniform float _ShadeShift : hint_range(-1.0, 1.0) = 0.0;
uniform float _ShadeToony : hint_range(0.0, 1.0) = 0.9;
uniform float _LightColorAttenuation : hint_range(0.0, 1.0) = 0.0;
uniform float _IndirectLightIntensity : hint_range(0.0, 1.0) = 0.1;
uniform sampler2D _RimTexture : hint_albedo;
uniform vec4 _RimColor /*: hint_color*/ = vec4(0,0,0,1);
uniform float _RimLightingMix : hint_range(0.0, 1.0) = 0.0;
uniform float _RimFresnelPower : hint_range(0.0, 100.0) = 1.0;
uniform float _RimLift : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D _SphereAdd : hint_black_albedo; // "Sphere Texture(Add)"
uniform vec4 _EmissionColor /*: hint_color*/ = vec4(0,0,0,1); // "Color"
uniform sampler2D _EmissionMap : hint_albedo;
// Not implemented:
// uniform float _OutlineWidthScreenCoordinates : hint_range(0,1,1);
uniform sampler2D _OutlineWidthTexture : hint_white;
uniform float _OutlineWidth : hint_range(0.01, 1.0) = 0.5;
uniform float _OutlineScaledMaxDistance : hint_range(1,10) = 1;
uniform float _OutlineColorMode : hint_range(0,1,1);
uniform vec4 _OutlineColor /*: hint_color*/ = vec4(0,0,0,1);
uniform float _OutlineLightingMix : hint_range(0,1) = 0;
uniform sampler2D _UvAnimMaskTexture : hint_white;
uniform float _UvAnimScrollX = 0;
uniform float _UvAnimRotation = 0;
uniform float _UvAnimScrollY = 0;
uniform float _DebugMode : hint_range(0,3,1) = 0.0;

uniform float _MToonVersion = 33;

// const
const float PI_2 = 6.28318530718;
const float EPS_COL = 0.00001;


varying vec4 posWorld; // : TEXCOORD0;
varying vec3 tspace0; // : TEXCOORD1;
varying vec3 tspace1; // : TEXCOORD2;
varying vec3 tspace2; // : TEXCOORD3;


void vertex() {
	UV=UV*_MainTex_ST.xy+_MainTex_ST.zw;
	COLOR=COLOR;

	if (isOutline == 1.0) {
	    float outlineTex = textureLod(_OutlineWidthTexture, UV, 0).r;
	    vec3 worldNormalLength = vec3(1.0/length(mat3(transpose(WORLD_MATRIX)) * NORMAL));
	    vec3 outlineOffset = 0.01 * _OutlineWidth * outlineTex * worldNormalLength * NORMAL;
	    VERTEX += outlineOffset;
	}
	/*
#elif defined(MTOON_OUTLINE_WIDTH_SCREEN)
    vec4 nearUpperRight = (xINV_PROJECTION_MATRIX * vec4(1, 1, 0, 1));
    float aspect = abs(nearUpperRight.y / nearUpperRight.x);
    vec3 viewNormal = mat3(xINV_CAMERA_MATRIX) * mat3(xWORLD_MATRIX) * normal.xyz;
    vec3 clipNormal = TransformViewToProjection(viewNormal.xyz);
    vec2 projectedNormal = normalize(clipNormal.xy);
    projectedNormal *= min(vertex.w, _OutlineScaledMaxDistance);
    projectedNormal.x *= aspect;
    vertex.xy += 0.01 * _OutlineWidth * outlineTex * projectedNormal.xy * saturate(1 - abs(normalize(viewNormal).z)); // ignore offset when normal toward camera
#else
    float4 vertex = UnityObjectToClipPos(v.vertex);
#endif
	*/

	posWorld = (MODELVIEW_MATRIX*vec4(VERTEX.xyz, 1.0));
    vec3 worldNormal = mat3(MODELVIEW_MATRIX)*NORMAL;
    vec3 worldTangent = mat3(MODELVIEW_MATRIX)*TANGENT;
    vec3 worldBitangent = mat3(MODELVIEW_MATRIX)*BINORMAL;
    tspace0 = vec3(worldTangent.x, worldBitangent.x, worldNormal.x);
    tspace1 = vec3(worldTangent.y, worldBitangent.y, worldNormal.y);
    tspace2 = vec3(worldTangent.z, worldBitangent.z, worldNormal.z);
}

vec3 UnpackScaleNormal(vec4 normalmap, float scale) {
	normalmap.xy = scale * (normalmap.xy * 2.0 - 1.0);
	normalmap.z = sqrt(max(0.0, 1.0 - dot(normalmap.xy, normalmap.xy))); //always ignore Z, as it can be RG packed, Z may be pos/neg, etc.
	return normalmap.xyz;
}

vec3 calculateLighting(vec2 mainUv, float dotNL, float lightAttenuation, vec4 shade, vec4 lit, vec3 lightColor, out vec3 col, out float lightIntensity) {
    // Decide albedo color rate from Direct Light
    float shadingGrade = 1.0 - _ShadingGradeRate * (1.0 - texture(_ShadingGradeTexture, mainUv).r);
    lightIntensity = dotNL; // [-1, +1]
    lightIntensity = lightIntensity * 0.5 + 0.5; // from [-1, +1] to [0, 1]
    lightIntensity = lightIntensity * lightAttenuation; // receive shadow
    lightIntensity = lightIntensity * shadingGrade; // darker
    lightIntensity = lightIntensity * 2.0 - 1.0; // from [0, 1] to [-1, +1]
    // tooned. mapping from [minIntensityThreshold, maxIntensityThreshold] to [0, 1]
    float maxIntensityThreshold = mix(1, _ShadeShift, _ShadeToony);
    float minIntensityThreshold = _ShadeShift;
    lightIntensity = clamp((lightIntensity - minIntensityThreshold) / max(EPS_COL, (maxIntensityThreshold - minIntensityThreshold)),0.0,1.0);

    col = mix(shade.rgb, lit.rgb, lightIntensity);
    //DEBUG_OVERRIDE = vec4(vec3(shade.rgb),1.0);
    //DEBUG_OVERRIDE = vec4(vec3(col.rgb),1.0);
    // Direct Light
    vec3 lighting = lightColor / 3.14159;
    lighting = mix(lighting, max(vec3(EPS_COL), max(lighting.x, max(lighting.y, lighting.z))), _LightColorAttenuation); // color atten
	return lighting;
}

vec3 calculateAddLighting(vec2 mainUv, float dotNL, float dotNV, float shadowAttenuation, vec3 lighting, vec3 col) {
//    UNITY_LIGHT_ATTENUATION(shadowAttenuation, i, posWorld.xyz);
//#ifdef _ALPHABLEND_ON
//    lighting *= step(0, dotNL); // darken if transparent. Because Unity's transparent material can't receive shadowAttenuation.
//#endif
    lighting *= 0.5; // darken if additional light.
    lighting *= min(0.0, dotNL) + 1.0; // darken dotNL < 0 area by using float lambert
    lighting *= shadowAttenuation; // darken if receiving shadow
    col *= lighting;

    // parametric rim lighting
    vec3 staticRimLighting = vec3(0.0);
    vec3 mixedRimLighting = lighting;

    vec3 rimLighting = mix(staticRimLighting, mixedRimLighting, _RimLightingMix);
    vec3 rim = pow(clamp(1.0 - dotNV + _RimLift, 0.0, 1.0), _RimFresnelPower) * _RimColor.rgb * texture(_RimTexture, mainUv).rgb;
    col += mix(rim * rimLighting, vec3(0.0), isOutline);
	return col;
}

vec4 LinearToGammaSpace (vec4 linRGB)
{
    linRGB.rgb = max(linRGB.rgb, vec3(0.0, 0.0, 0.0));
    // An almost-perfect approximation from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
    return vec4(max(1.055 * pow(linRGB.rgb, vec3(0.416666667)) - 0.055, 0.0), linRGB.a);
}

vec4 GammaToLinearSpace (vec4 sRGB)
{
    // Approximate version from http://chilliant.blogspot.com.au/2012/08/srgb-approximations-for-hlsl.html?m=1
    return vec4(sRGB.rgb * (sRGB.rgb * (sRGB.rgb * 0.305306011 + 0.682171111) + 0.012522878), sRGB.a);
}
void fragment() {
	bool _NORMALMAP = textureSize(_BumpMap, 0).x > 8;
	bool MTOON_OUTLINE_COLOR_FIXED = _OutlineColorMode == 0.0;
	bool MTOON_OUTLINE_COLOR_MIXED = _OutlineColorMode == 1.0;

	ROUGHNESS = 1.0; // for now
	SPECULAR = 0.0; // for now
    // uv
    vec2 mainUv = UV; //TRANSFORM_TEX(i.uv0, _MainTex);
    
    // uv anim
    float uvAnim = texture(_UvAnimMaskTexture, mainUv).r * TIME;
    // translate uv in bottom-left origin coordinates.
    mainUv += vec2(_UvAnimScrollX, -_UvAnimScrollY) * uvAnim;
    // rotate uv counter-clockwise around (0.5, 0.5) in bottom-left origin coordinates.
    float rotateRad = _UvAnimRotation * PI_2 * uvAnim;
    const vec2 rotatePivot = vec2(0.5, 0.5);
    mainUv = mat2(vec2(cos(rotateRad), -sin(rotateRad)), vec2(-sin(rotateRad), cos(rotateRad))) * (mainUv - rotatePivot) + rotatePivot;
    
    // main tex
    vec4 mainTex = texture(_MainTex, mainUv);
    vec4 DEBUG_OVERRIDE = vec4(0.0);
    // alpha
	float alpha = _Color.a * mainTex.a;
     // Albedo color
    vec4 shade = texture(_ShadeTexture, mainUv);
    vec4 lit = mainTex;
    vec3 emission = texture(_EmissionMap, mainUv).rgb * _EmissionColor.rgb;

	vec3 tangentNormal = vec3(0.0,0.0,1.0);
	if (_NORMALMAP) {
	    tangentNormal = UnpackScaleNormal(texture(_BumpMap, mainUv), _BumpScale);
	}

	for (uint i = uint(0); i < DECAL_COUNT(CLUSTER_CELL); i++) {
		vec3 decal_emission;
		vec4 decal_albedo;
		vec4 decal_normal;
		vec4 decal_orm;
		vec3 uv_local;
		if (DECAL_PROCESS(CLUSTER_CELL, i, VERTEX, dFdx(VERTEX), dFdy(VERTEX), NORMAL, uv_local, decal_albedo, decal_normal, decal_orm, decal_emission)) {
			shade.rgb = mix(shade.rgb, decal_albedo.rgb, decal_albedo.a);
			lit.rgb = mix(lit.rgb, decal_albedo.rgb, decal_albedo.a);
			tangentNormal = normalize(mix(tangentNormal, decal_normal.rgb, decal_normal.a));
			//AO = mix(AO, decal_orm.r, decal_orm.a);
			ROUGHNESS = mix(ROUGHNESS, decal_orm.g, decal_orm.a);
			//METALLIC = mix(METALLIC, decal_orm.b, decal_orm.a);
			emission += decal_emission;
		}
	}
	shade *= GammaToLinearSpace(_ShadeColor);
	lit *= GammaToLinearSpace(_Color);

    shade = min(shade, lit); ///// Mimic look of non-PBR min() clamp we commented out below.

    // normal
    vec3 viewNormal;
	if (_NORMALMAP) {
	    viewNormal.x = dot(tspace0, tangentNormal);
	    viewNormal.y = dot(tspace1, tangentNormal);
	    viewNormal.z = dot(tspace2, tangentNormal);
	} else {
	    viewNormal = vec3(tspace0.z, tspace1.z, tspace2.z);
	}
    vec3 viewView = -VIEW;
    viewNormal *= step(0.0, dot(viewView, viewNormal)) * 2.0 - 1.0; // flip if projection matrix is flipped
    viewNormal *= mix(+1.0, -1.0, isOutline);
    viewNormal = normalize(viewNormal);

    // Unity lighting

	vec3 lightDir = vec3(1.0,0.0,0.0); // mat3(CAMERA_MATRIX) * vec3(0.5,0.86,0.0);
    float dotNL = 0.0;
	float lightAttenuation = 1.0;
	vec3 lightColor = vec3(0.0);
	float dir_light_intensity = 0.0;
	uint main_dir_light = uint(0);
	for (uint i = uint(0); i < DIRECTIONAL_LIGHT_COUNT(); i++) {
		DirectionalLightData ld = GET_DIRECTIONAL_LIGHT(i);
		if (!SHOULD_RENDER_DIR_LIGHT(ld)) {
			continue;
		}
		vec3 thisLightColor = (GET_DIR_LIGHT_COLOR_SPECULAR(ld).rgb);
		float this_intensity = max(thisLightColor.r, max(thisLightColor.g, thisLightColor.b));
		if (this_intensity <= dir_light_intensity + 0.00001) {
			continue;
		}
		dir_light_intensity = this_intensity;
		main_dir_light = i;
		lightColor = thisLightColor;
	}
	if (dir_light_intensity > 0.0) {
		DirectionalLightData ld = GET_DIRECTIONAL_LIGHT(main_dir_light);
		lightDir = normalize(GET_DIR_LIGHT_DIRECTION(ld).xyz);
		dotNL = dot(lightDir, -viewNormal);
	    //UNITY_LIGHT_ATTENUATION(shadowAttenuation, i, posWorld.xyz);
		vec3 shadow_color = vec3(1.0);
		float shadow;
		float transmittance_z = 1.0;
		DIRECTIONAL_SHADOW_PROCESS(ld, VERTEX, NORMAL, shadow_color, shadow, transmittance_z);
		//DEBUG_OVERRIDE = vec4(vec3(shadow),1.0);
		float shadowAttenuation = shadow;//1.0 - shadow;
	    lightAttenuation = shadowAttenuation * mix(1, shadowAttenuation, _ReceiveShadowRate * texture(_ReceiveShadowTexture, mainUv).r);
	}

	// Indirect Light
    vec4 reflection_accum;
    vec4 ambient_accum;
	
	vec3 env_reflection_light = vec3(0.0);
	
	vec3 up_normal = mat3(INV_CAMERA_MATRIX) * vec3(0.0,1.0,0.0);

	vec3 ambient_light_up;
	vec3 diffuse_light_up;
	vec3 specular_light_up;
	reflection_accum = vec4(0.0, 0.0, 0.0, 0.0);
	ambient_accum = vec4(0.0, 0.0, 0.0, 0.0);
	AMBIENT_PROCESS(VERTEX, up_normal, ROUGHNESS, SPECULAR, false, viewView, vec2(0.0), ambient_light_up, diffuse_light_up, specular_light_up);
    for (uint idx = uint(0); idx < REFLECTION_PROBE_COUNT(CLUSTER_CELL); idx++) {
		REFLECTION_PROCESS(CLUSTER_CELL, idx, VERTEX, up_normal, ROUGHNESS, ambient_light_up, specular_light_up, ambient_accum, reflection_accum);
    }
    if (ambient_accum.a > 0.0) {
		ambient_light_up = ambient_accum.rgb / ambient_accum.a;
    }
	vec3 ambient_light_down;
	vec3 diffuse_light_down;
	vec3 specular_light_down;
	reflection_accum = vec4(0.0, 0.0, 0.0, 0.0);
	ambient_accum = vec4(0.0, 0.0, 0.0, 0.0);
	AMBIENT_PROCESS(VERTEX, -up_normal, ROUGHNESS, SPECULAR, false, viewView, vec2(0.0), ambient_light_down, diffuse_light_down, specular_light_down);
    for (uint idx = uint(0); idx < REFLECTION_PROBE_COUNT(CLUSTER_CELL); idx++) {
		REFLECTION_PROCESS(CLUSTER_CELL, idx, VERTEX, -up_normal, ROUGHNESS, ambient_light_down, specular_light_down, ambient_accum, reflection_accum);
    }
    if (ambient_accum.a > 0.0) {
		ambient_light_down = ambient_accum.rgb / ambient_accum.a;
    }
	vec3 toonedGI = (ambient_light_up + ambient_light_down) * 0.5;

	vec3 ambient_light;
	vec3 diffuse_light;
	vec3 specular_light;
    reflection_accum = vec4(0.0, 0.0, 0.0, 0.0);
    ambient_accum = vec4(0.0, 0.0, 0.0, 0.0);
	env_reflection_light = vec3(0.0);
	AMBIENT_PROCESS(VERTEX, NORMAL, ROUGHNESS, SPECULAR, false, viewView, vec2(0.0), ambient_light, diffuse_light, specular_light);
    for (uint idx = uint(0); idx < REFLECTION_PROBE_COUNT(CLUSTER_CELL); idx++) {
		REFLECTION_PROCESS(CLUSTER_CELL, idx, VERTEX, NORMAL, ROUGHNESS, ambient_light, specular_light, ambient_accum, reflection_accum);
    }
    if (ambient_accum.a > 0.0) {
		ambient_light = ambient_accum.rgb / ambient_accum.a;
    }

    vec3 indirectLighting = mix(toonedGI, ambient_light, _IndirectLightIntensity);
    indirectLighting = mix(indirectLighting, max(vec3(EPS_COL), max(indirectLighting.x, max(indirectLighting.y, indirectLighting.z))), _LightColorAttenuation); // color atten
//#endif

	vec3 col;
	float lightIntensity;
	vec3 lighting = calculateLighting(mainUv, dotNL, lightAttenuation, shade, lit, lightColor, col, lightIntensity);

    // base light does not darken.
    col *= lighting;

    col += indirectLighting * lit.rgb;
   
    //col = min(col, lit.rgb); // comment out if you want to PBR absolutely.

    // parametric rim lighting
    vec3 staticRimLighting = vec3(1.0);
    vec3 mixedRimLighting = lighting + indirectLighting;

    vec3 rimLighting = mix(staticRimLighting, mixedRimLighting, _RimLightingMix);
    vec3 rim = pow(clamp(1.0 - dot(viewNormal, viewView) + _RimLift, 0.0, 1.0), _RimFresnelPower) * _RimColor.rgb * texture(_RimTexture, mainUv).rgb;
    col += mix(rim * rimLighting, vec3(0, 0, 0), isOutline);


    // additive matcap
    vec3 viewCameraUp = vec3(0.0,1.0,0.0);//normalize(CAMERA_MATRIX[1].xyz); // FIXME!!
    vec3 viewViewUp = normalize(viewCameraUp - viewView * dot(viewView, viewCameraUp));
    vec3 viewViewRight = normalize(cross(viewView, viewViewUp));
    vec2 matcapUv = vec2(-dot(viewViewRight, viewNormal), dot(viewViewUp, viewNormal)) * 0.5 + 0.5;
    vec3 matcapLighting = texture(_SphereAdd, matcapUv).rgb;
    col += mix(matcapLighting, vec3(0, 0, 0), isOutline);

    // Emission
    col += mix(emission, vec3(0, 0, 0), isOutline);

	//LightmapCapture lc;
	//if (GET_LIGHTMAP_SH(lc)) {
	//	GET_SH_COEF(lc, 0).w + GET_SH_COEF(lc, 1).w + GET_SH_COEF(lc, 2).w;
	//}
	vec3 vertex_ddx = dFdx(VERTEX);
	vec3 vertex_ddy = dFdy(VERTEX);

	vec3 addLightIntensity = vec3(0.0);
	ClusterData cd = CLUSTER_CELL;
	if (CALCULATE_LIGHTING_IN_FRAGMENT) {

	    for (uint idx = uint(0); idx < DIRECTIONAL_LIGHT_COUNT(); idx++) {
			if (idx == main_dir_light) {
				continue;
			}
			DirectionalLightData ld = GET_DIRECTIONAL_LIGHT(idx);
			if (!SHOULD_RENDER_DIR_LIGHT(ld)) {
				continue;
			}
			vec3 light_rel_vec = GET_DIR_LIGHT_DIRECTION(ld).xyz;
			vec3 light_color = GET_DIR_LIGHT_COLOR_SPECULAR(ld).rgb;
			
		    float transmittance_z = 0.0;
			float shadow;
			vec3 shadow_color_enabled;
			if (DIRECTIONAL_SHADOW_PROCESS(ld, VERTEX, NORMAL, shadow_color_enabled, shadow, transmittance_z)) {
				//vec3 no_shadow = OMNI_PROJECTOR_PROCESS(ld, VERTEX, vertex_ddx, vertex_ddy);
				//shadow_attenuation = mix(shadow_color_enabled.rgb, no_shadow, shadow);
			}
			float addShadowAttenuation = shadow;

			float addDotNL = dot(normalize(light_rel_vec), -viewNormal);

			vec3 addCol = vec3(0.0);
			float addTmp;
			vec3 addLighting = calculateLighting(mainUv, addDotNL, 1.0, shade, lit, light_color, addCol, addTmp);
			addLightIntensity += addLighting * addTmp;
			col += calculateAddLighting(mainUv, addDotNL, dot(viewNormal, viewView), addShadowAttenuation, addLighting, addCol);
	    }

	    for (uint idx = uint(0); idx < OMNI_LIGHT_COUNT(CLUSTER_CELL); idx++) {
			LightData ld = GET_OMNI_LIGHT(cd, idx);
			if (!SHOULD_RENDER_LIGHT(ld)) {
				continue;
			}
			vec3 light_rel_vec = GET_LIGHT_POSITION(ld).xyz - VERTEX;
			float atten = GET_OMNI_LIGHT_ATTENUATION_SIZE(ld, VERTEX).x;
			vec3 light_color = GET_LIGHT_COLOR_SPECULAR(ld).rgb;
			
		    float transmittance_z = 0.0;
			float shadow;
			vec3 shadow_color_enabled = GET_LIGHT_SHADOW_COLOR(ld).rgb;
			if (OMNI_SHADOW_PROCESS(ld, VERTEX, NORMAL, shadow, transmittance_z)) {
				//vec3 no_shadow = OMNI_PROJECTOR_PROCESS(ld, VERTEX, vertex_ddx, vertex_ddy);
				//shadow_attenuation = mix(shadow_color_enabled.rgb, no_shadow, shadow);
			}
			float addShadowAttenuation = atten * shadow;

			float addDotNL = dot(normalize(light_rel_vec), -viewNormal);

			vec3 addCol = vec3(0.0);
			float addTmp;
			vec3 addLighting = calculateLighting(mainUv, addDotNL, 1.0, shade, lit, light_color, addCol, addTmp);
			addLightIntensity += addLighting * addTmp;
			col += calculateAddLighting(mainUv, addDotNL, dot(viewNormal, viewView), addShadowAttenuation, addLighting, addCol);
	    }


	    for (uint idx = uint(0); idx < SPOT_LIGHT_COUNT(CLUSTER_CELL); idx++) {
			LightData ld = GET_SPOT_LIGHT(cd, idx);
			if (!SHOULD_RENDER_LIGHT(ld)) {
				continue;
			}
			vec3 light_rel_vec = GET_LIGHT_POSITION(ld).xyz - VERTEX;
			float atten = GET_SPOT_LIGHT_ATTENUATION_SIZE(ld, VERTEX).x;
			vec3 light_color = GET_LIGHT_COLOR_SPECULAR(ld).rgb;
			
		    float transmittance_z = 0.0;
			float shadow;
			vec3 shadow_color_enabled = GET_LIGHT_SHADOW_COLOR(ld).rgb;
			if (SPOT_SHADOW_PROCESS(ld, VERTEX, NORMAL, shadow, transmittance_z)) {
				//vec3 no_shadow = SPOT_PROJECTOR_PROCESS(ld, VERTEX, vertex_ddx, vertex_ddy);
				//shadow_attenuation = mix(shadow_color_enabled.rgb, no_shadow, shadow);
			}
			
			float addShadowAttenuation = atten * shadow;

			float addDotNL = dot(normalize(light_rel_vec), -viewNormal);

			vec3 addCol = vec3(0.0);
			float addTmp;
			vec3 addLighting = calculateLighting(mainUv, addDotNL, 1.0, shade, lit, light_color, addCol, addTmp);
			addLightIntensity += addLighting * addTmp;
			col += calculateAddLighting(mainUv, addDotNL, dot(viewNormal, viewView), addShadowAttenuation, addLighting, addCol);
	    }

	}



    // outline
	if (isOutline == 1.0) {
		if (MTOON_OUTLINE_COLOR_FIXED) {
	        col = mix(col, _OutlineColor.rgb, isOutline);
		} else if (MTOON_OUTLINE_COLOR_MIXED) {
	        col = mix(col, _OutlineColor.rgb * mix(vec3(1, 1, 1), col, _OutlineLightingMix), isOutline);
	    }
	}

    // debug
	if (_DebugMode == 1.0) { //MTOON_DEBUG_NORMAL
		col = ((mat3(CAMERA_MATRIX) * -viewNormal) * 0.5 + vec3(0.5));
	} else if (_DebugMode == 2.0) { //MTOON_DEBUG_LITSHADERATE
		col = lightIntensity * lighting;
	} else if (_DebugMode == 3.0) { // Add pass lighting
		col = addLightIntensity;
	}
    //if (!LM_SCENEDATA_BOOL(lm_macro_system_enabled_)) {
    //    col.rgb = vec3(0.5 + 0.5 * sin(TIME +UV.x+UV.y),0.0,1.0);
    //}

	AMBIENT_LIGHT = vec3(0.0);
	DIFFUSE_LIGHT = vec3(0.0);
	SPECULAR_LIGHT = vec3(0.0);

    EMISSION = mix(1.0*col.rgb, DEBUG_OVERRIDE.rgb, DEBUG_OVERRIDE.a);

	vec3 pass_to_light = vec3(0.5) - 0.5 * lightDir.xyz;
	ROUGHNESS = pass_to_light.x + 0.3*pass_to_light.y + 0.1*pass_to_light.z;

    ALBEDO = vec3(0.0);//lit.rgb;//vec3(0.0);
	SPECULAR = 1.0;
	ROUGHNESS = 0.0;
	METALLIC = 0.0;
	ALPHA = alpha;
	//if (alpha < _Cutoff) { discard; }


	//METALLIC = metallic;
	//ROUGHNESS = roughness;
	//SPECULAR = specular;
}

float SchlickFresnel(float u) {
	float m = 1.0 - u;
	float m2 = m * m;
	return m2 * m2 * m; // pow(m,5)
}

void light() {
    // uv
    vec2 mainUv = UV; //TRANSFORM_TEX(i.uv0, _MainTex);
    
    // uv anim
    float uvAnim = texture(_UvAnimMaskTexture, mainUv).r * TIME;
    // translate uv in bottom-left origin coordinates.
    mainUv += vec2(_UvAnimScrollX, -_UvAnimScrollY) * uvAnim;
    // rotate uv counter-clockwise around (0.5, 0.5) in bottom-left origin coordinates.
    float rotateRad = _UvAnimRotation * PI_2 * uvAnim;
    const vec2 rotatePivot = vec2(0.5, 0.5);
    mainUv = mat2(vec2(cos(rotateRad), sin(rotateRad)), vec2(-sin(rotateRad), cos(rotateRad))) * (mainUv - rotatePivot) + rotatePivot;

//	if (length(abs(vec3(0.5) + 0.5 * LIGHT.xyz) - TRANSMISSION.xyz) < 0.0001) {
	if (length(abs(vec3(0.5) + 0.5*(LIGHT.x+0.3*LIGHT.y+0.1*LIGHT.z)) - ROUGHNESS) < 0.0001) {
		// Directional Light (we store direction into TRANSMISSION, and see if it matches).
		// We already calculated this in the base pass.
		DIFFUSE_LIGHT = vec3(0.0);
	} else {
		/*
		// Default Godot BRDF.
		float NdotL = dot(NORMAL, LIGHT);
		float cNdotL = max(NdotL, 0.0); // clamped NdotL
		float NdotV = dot(NORMAL, VIEW);
		float cNdotV = max(NdotV, 0.0);

		vec3 H = normalize(VIEW + LIGHT);
		float cNdotH = max(dot(NORMAL, H), 0.0);
		float cLdotH = max(dot(LIGHT, H), 0.0);
		float diffuse_brdf_NL; // BRDF times N.L for calculating diffuse radiance
		{
			float FD90_minus_1 = 2.0 * cLdotH * cLdotH * ROUGHNESS - 0.5;
			float FdV = 1.0 + FD90_minus_1 * SchlickFresnel(cNdotV);
			float FdL = 1.0 + FD90_minus_1 * SchlickFresnel(cNdotL);
			diffuse_brdf_NL = (1.0 / 3.1415926) * FdV * FdL * cNdotL;
		}
		DIFFUSE_LIGHT += 1.0 * LIGHT_COLOR * ALBEDO * diffuse_brdf_NL * ATTENUATION;
		*/
		if (!CALCULATE_LIGHTING_IN_FRAGMENT) {
			float addDotNL = dot(NORMAL, LIGHT);
		    vec4 mainTex = texture(_MainTex, mainUv);
		    vec4 shade = _ShadeColor * texture(_ShadeTexture, mainUv);
	    	vec4 lit = _Color * mainTex;

			vec3 addCol = vec3(0.0);
			float addTmp;
			vec3 addLighting = calculateLighting(mainUv, addDotNL, 1.0, shade, lit, LIGHT_COLOR, addCol, addTmp);
			// addLighting *= step(0, addDotNL); // darken if transparent. Because Unity's transparent material can't receive shadowAttenuation.
			DIFFUSE_LIGHT += calculateAddLighting(mainUv, addDotNL, dot(NORMAL, VIEW), ATTENUATION*length(SHADOW_ATTENUATION)/length(vec3(1.0)), addLighting, addCol);
		}
	}
    SPECULAR_LIGHT = vec3(0.0);
}
