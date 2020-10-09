Shader "ERB/Unlit/Bog"
{
	Properties
	{
		_Color ("Color", Color) = (0.5367647,0.6901116,1,1)
        _Fresnelstrench ("Fresnel strench", Float ) = 2
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _MainTex ("MainTex", 2D) = "white" {}
        _Opacity ("Opacity", Range(0, 1)) = 0.3
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Distortionstrench ("Distortion strench", Range(-2, 2)) = 0.25
	}


	Category 
	{
		SubShader
		{
			Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			GrabPass {
			"_GrabTexture"
			}
			Pass {
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 2.0
				#pragma multi_compile_particles
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				uniform float4 _LightColor0;
				sampler2D _GrabTexture;
				uniform float4 _Color;
				uniform float _Fresnelstrench;
				uniform samplerCUBE _Cubemap;
				uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
				uniform float _Opacity;
				uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
				uniform float _Distortionstrench;

				struct appdata_t 
				{
					 float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 tangent : TANGENT;
					float2 texcoord0 : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					
				};

				struct v2f 
				{
					float4 pos : SV_POSITION;
					float2 uv0 : TEXCOORD0;
					float4 posWorld : TEXCOORD1;
					float3 normalDir : TEXCOORD2;
					float3 tangentDir : TEXCOORD3;
					float3 bitangentDir : TEXCOORD4;
					float4 screenPos : TEXCOORD5;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
					
				};

				v2f vert ( appdata_t v  )
				{
					v2f o = (v2f)0;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
					UNITY_TRANSFER_INSTANCE_ID(v, o);				
					o.uv0 = v.texcoord0;
					o.normalDir = UnityObjectToWorldNormal(v.normal);
					o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
					o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
					o.posWorld = mul(unity_ObjectToWorld, v.vertex);
					float3 lightColor = _LightColor0.rgb;
					o.pos = UnityObjectToClipPos(v.vertex );
					o.screenPos = o.pos;
					return o;
				}

				fixed4 frag ( v2f i  ) : COLOR
				{
					#if UNITY_UV_STARTS_AT_TOP
                    float grabSign = -_ProjectionParams.x;
					#else
						float grabSign = _ProjectionParams.x;
					#endif
					i.normalDir = normalize(i.normalDir);
					i.screenPos = float4( i.screenPos.xy / i.screenPos.w, 0, 0 );
					i.screenPos.y *= _ProjectionParams.x;
					float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
					float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
					float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
					float3 node_6342 = (_Distortionstrench*_NormalMap_var.rgb);
					float3 normalLocal = lerp(float3(0,0,1),node_6342,0.1);
					float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
					float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
					float2 sceneUVs = float2(1,grabSign)*i.screenPos.xy*0.5+0.5 + node_6342.rg;
					float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
					float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
					float3 lightColor = _LightColor0.rgb;
					float3 halfDirection = normalize(viewDirection+lightDirection);
	////// Lighting:
					float attenuation = 1;
					float3 attenColor = attenuation * _LightColor0.xyz;
	///////// Gloss:
					float gloss = 1.0;
					float specPow = exp2( gloss * 10.0+1.0);
	////// Specular:
					float NdotL = max(0, dot( normalDirection, lightDirection ));
					float node_217 = 0.2;
					float3 specularColor = float3(node_217,node_217,node_217);
					float3 directSpecular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
					float3 specular = directSpecular;
	/////// Diffuse:
					NdotL = max(0.0,dot( normalDirection, lightDirection ));
					float3 directDiffuse = pow(max( 0.0, NdotL), 1.0) * attenColor;
					float3 indirectDiffuse = float3(0,0,0);
					indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
					float3 diffuseColor = _Color.rgb;
					float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
	////// Emissive:
					float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
					float3 emissive = saturate(((pow(1.0-max(0,dot(normalDirection, viewDirection)),0.0)*_Fresnelstrench)*texCUBE(_Cubemap,viewReflectDirection).rgb*_MainTex_var.rgb));
	/// Final Color:
					float3 finalColor = diffuse + specular + emissive;
					return fixed4(lerp(sceneColor.rgb, finalColor,_Opacity),1);
				}
				ENDCG 
			}
		}	
	}
}