Shader "ERB/Unlit/Bog"
{
	Properties
	{
		_Maintexture("Main texture", 2D) = "white" {}
		[HDR]_Color("Color", Color) = (0,1,0,1)
		_Mask("Mask", 2D) = "white" {}
		_SpeedUVPowZEmissionW("Speed UV Pow Z Emission W", Vector) = (0,0,1,0)
		_Alphapow("Alpha pow", Float) = 1
		_Cutoff("Cutoff", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}


	Category 
	{
		SubShader
		{
			Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			Cull Off
			Lighting Off 
			ZWrite Off
			ZTest LEqual
			
			Pass {
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 2.0
				#pragma multi_compile_particles
				#pragma multi_compile_fog
				#include "UnityShaderVariables.cginc"


				#include "UnityCG.cginc"

				struct appdata_t 
				{
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float4 texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					
				};

				struct v2f 
				{
					float4 vertex : SV_POSITION;
					fixed4 color : COLOR;
					float4 texcoord : TEXCOORD0;
					UNITY_FOG_COORDS(1)
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
					
				};
				
				uniform sampler2D _Maintexture;
				uniform float4 _SpeedUVPowZEmissionW;
				uniform float4 _Maintexture_ST;
				uniform float4 _Color;
				uniform sampler2D _Mask;
				uniform float4 _Mask_ST;
				uniform float _Cutoff;
				uniform float _Alphapow;

				v2f vert ( appdata_t v  )
				{
					v2f o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
					UNITY_TRANSFER_INSTANCE_ID(v, o);				
					v.vertex.xyz +=  float3( 0, 0, 0 ) ;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.color = v.color;
					o.texcoord = v.texcoord;
					UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}

				fixed4 frag ( v2f i  ) : SV_Target
				{
					float2 appendResult7 = (float2(_SpeedUVPowZEmissionW.x , _SpeedUVPowZEmissionW.y));
					float2 uv0_Maintexture = i.texcoord.xy * _Maintexture_ST.xy + _Maintexture_ST.zw;
					float2 panner6 = ( 1.0 * _Time.y * appendResult7 + uv0_Maintexture);
					float2 panner10 = ( 1.0 * _Time.y * ( appendResult7 * float2( -1,-0.87 ) ) + uv0_Maintexture);
					float4 temp_output_14_0 = ( tex2D( _Maintexture, panner6 ) * tex2D( _Maintexture, ( panner10 + float2( 0.63,0.55 ) ) ) );
					float w19 = _SpeedUVPowZEmissionW.w;
					float2 uv_Mask = i.texcoord.xy * _Mask_ST.xy + _Mask_ST.zw;
					float z17 = _SpeedUVPowZEmissionW.z;
					float4 temp_cast_0 = (z17).xxxx;
					float4 temp_cast_1 = (_Cutoff).xxxx;
					float4 temp_output_32_0 = saturate( ( temp_output_14_0.a * saturate( ( pow( tex2D( _Mask, uv_Mask ) , temp_cast_0 ) - temp_cast_1 ) ) * 2.0 ) );
					float4 temp_cast_2 = (_Alphapow).xxxx;
					float4 appendResult25 = (float4((( temp_output_14_0 * w19 * _Color * pow( temp_output_32_0 , temp_cast_2 ) )).rgb , temp_output_32_0.a));			
					fixed4 col = appendResult25;
					UNITY_APPLY_FOG(i.fogCoord, col);
					return col;
				}
				ENDCG 
			}
		}	
	}
}
/*ASEBEGIN
Version=16800
421;92;1307;941;2193.655;197.2466;1.016044;True;False
Node;AmplifyShaderEditor.Vector4Node;4;-2208.491,-116.4007;Float;False;Property;_SpeedUVPowZEmissionW;Speed UV Pow Z Emission W;3;0;Create;True;0;0;False;0;0,0,1,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;7;-1880.663,-102.0473;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1703.882,7.542796;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;-1,-0.87;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1991.549,-240.6538;Float;False;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;10;-1534.556,-19.77401;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-1833.982,112.57;Float;False;z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-1115.777,774.1182;Float;False;17;z;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1221.818,564.6552;Float;True;Property;_Mask;Mask;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-1348.189,-13.58078;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.63,0.55;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;6;-1535.364,-200.6938;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;13;-1480.521,116.2554;Float;True;Property;_Maintexture;Main texture;0;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-800.3813,680.8882;Float;False;Property;_Cutoff;Cutoff;5;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;-885.5334,572.502;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;12;-1179.9,-30.69508;Float;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1160.477,-227.3664;Float;True;Property;_TEXSAM1;TEX SAM 1;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;-629.3148,568.8779;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-793.5305,-24.04103;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;27;-566.0952,396.5579;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;30;-450.7318,653.4355;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-469.4236,566.9573;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-252.5648,580.8019;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-138.8752,287.2789;Float;False;Property;_Alphapow;Alpha pow;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-1848.279,214.2666;Float;False;w;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;32;-58.00794,599.5471;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;26;144.6576,308.9791;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-1068.617,166.809;Float;False;19;w;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-1081.116,255.5363;Float;False;Property;_Color;Color;1;1;[HDR];Create;True;0;0;False;0;0,1,0,1;0,1,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;352.2833,150.83;Float;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;31;572.5399,140.7041;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;33;123.7061,587.6542;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;25;845.7753,142.7903;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1061.348,180.2314;Float;False;True;2;Float;;0;7;ERB/Unlit/Bog;0b6a9f8b4f707c74ca64c0be8e590de0;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;2;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;True;2;False;-1;True;True;True;True;False;0;False;-1;False;True;2;False;-1;True;3;False;-1;False;True;4;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;False;0;False;False;False;False;False;False;False;False;False;False;True;0;0;;0;0;Standard;0;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;7;0;4;1
WireConnection;7;1;4;2
WireConnection;9;0;7;0
WireConnection;10;0;8;0
WireConnection;10;2;9;0
WireConnection;17;0;4;3
WireConnection;11;0;10;0
WireConnection;6;0;8;0
WireConnection;6;2;7;0
WireConnection;16;0;5;0
WireConnection;16;1;18;0
WireConnection;12;0;13;0
WireConnection;12;1;11;0
WireConnection;1;0;13;0
WireConnection;1;1;6;0
WireConnection;24;0;16;0
WireConnection;24;1;23;0
WireConnection;14;0;1;0
WireConnection;14;1;12;0
WireConnection;27;0;14;0
WireConnection;22;0;24;0
WireConnection;29;0;27;3
WireConnection;29;1;22;0
WireConnection;29;2;30;0
WireConnection;19;0;4;4
WireConnection;32;0;29;0
WireConnection;26;0;32;0
WireConnection;26;1;3;0
WireConnection;28;0;14;0
WireConnection;28;1;20;0
WireConnection;28;2;2;0
WireConnection;28;3;26;0
WireConnection;31;0;28;0
WireConnection;33;0;32;0
WireConnection;25;0;31;0
WireConnection;25;3;33;3
WireConnection;0;0;25;0
ASEEND*/
//CHKSM=F5CE8F3C6EDB35F15487F332ED8E4A3AFAC2CB9A