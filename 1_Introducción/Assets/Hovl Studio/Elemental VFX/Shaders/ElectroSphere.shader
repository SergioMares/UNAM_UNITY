Shader "ERB/Unlit/ElectroSphere"
{
	Properties
	{	
		_Maintexture("Main texture", 2D) = "white" {}
		_Noise("Noise", 2D) = "white" {}
		_Color("Color", Color) = (0,0,0,1)
		_Color2("Color2", Color) = (0,0.1724138,1,1)
		_Emission("Emission", Float) = 2
		_Noisespeed("Noise speed", Float) = 0.5
		_Sideglow("Side glow", Float) = 6
		_Glowmult("Glow mult", Float) = 0.5
		[MaterialToggle] _Usedepth ("Use depth?", Float ) = 0
        _Depthpower ("Depth power", Float ) = 1
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
					#ifdef SOFTPARTICLES_ON
					float4 projPos : TEXCOORD2;
					#endif
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
					
				};
				
				
				#if UNITY_VERSION >= 560
				UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
				#else
				uniform sampler2D_float _CameraDepthTexture;
				#endif

				//Don't delete this comment
				// uniform sampler2D_float _CameraDepthTexture;

				uniform float4 _Color;
				uniform float4 _Color2;
				uniform sampler2D _Maintexture;
				uniform float _Noisespeed;
				uniform sampler2D _Noise;
				uniform float _Sideglow;
				uniform float _Glowmult;
				uniform float _Emission;
				uniform fixed _Usedepth;
				uniform float _Depthpower;

				v2f vert ( appdata_t v  )
				{
					v2f o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
					UNITY_TRANSFER_INSTANCE_ID(v, o);
					

					v.vertex.xyz +=  float3( 0, 0, 0 ) ;
					o.vertex = UnityObjectToClipPos(v.vertex);
					#ifdef SOFTPARTICLES_ON
						o.projPos = ComputeScreenPos (o.vertex);
						COMPUTE_EYEDEPTH(o.projPos.z);
					#endif
					o.color = v.color;
					o.texcoord = v.texcoord;
					UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}

				fixed4 frag ( v2f i  ) : SV_Target
				{
					float lp = 1;
					#ifdef SOFTPARTICLES_ON
						float sceneZ = LinearEyeDepth (SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
						float partZ = i.projPos.z;
						float fade = saturate ((sceneZ-partZ) / _Depthpower);
						lp *= lerp(1, fade, _Usedepth);
						i.color.a *= lp;
					#endif

					float2 uv01 = i.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
					float2 temp_output_2_0 = (float2( -1,-1 ) + (uv01 - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 )));
					float temp_output_3_0 = length( temp_output_2_0 );
					float mulTime6 = _Time.y * _Noisespeed;
					float2 panner10 = ( 1.0 * _Time.y * float2( 1,1 ) + ( uv01 * float2( 0.5,0.5 ) ));
					float2 break23 = temp_output_2_0;
					float2 appendResult8 = (float2(( ( temp_output_3_0 * 0.1 ) + mulTime6 ) , ( ( (-1.0 + (tex2D( _Noise, panner10 ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * 0.1 ) + ( ( atan2( break23.y , break23.x ) / 6.28318548202515 ) + 0.5 ) )));
					float4 tex2DNode25 = tex2D( _Maintexture, appendResult8 );
					float cir26 = temp_output_3_0;
					float temp_output_28_0 = pow( cir26 , _Sideglow );
					float temp_output_44_0 = saturate( ( ( pow( ( tex2DNode25.g + ( tex2DNode25.r * temp_output_28_0 ) + ( temp_output_28_0 * _Glowmult ) ) , 1.5 ) + ( 1.0 - saturate( ( cir26 * 10.0 ) ) ) ) * 1.5 * ( 1.0 - floor( cir26 ) ) ) );
					float4 lerpResult47 = lerp( _Color , _Color2 , temp_output_44_0);
					float temp_output_53_0 = ( _Emission * temp_output_44_0 * i.color.a );
					float4 appendResult54 = (float4((( saturate( ( lerpResult47 * _Emission ) ) * i.color * temp_output_53_0 )).rgb , temp_output_53_0));			
					fixed4 col = appendResult54;
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
157;92;1307;941;5521.26;913.9146;5.706268;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1451.295,14.62724;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;2;-1131.831,10.44217;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1186.76,-272.044;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;23;-857.204,-112.9086;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.PannerNode;10;-1040.449,-276.1463;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ATan2OpNode;21;-547.9688,-98.59587;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;57;-512.6105,-2.789618;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-833.9715,-293.9225;Float;True;Property;_Noise;Noise;1;0;Create;True;0;0;False;0;c9b429edb5b829c46861c30a0545508c;c9b429edb5b829c46861c30a0545508c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;14;-522.202,-267.942;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;56;-408.6103,-100.2897;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;3;-890.4907,6.257156;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-924.281,125.1279;Float;False;Property;_Noisespeed;Noise speed;5;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-732.851,7.652083;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-728.1211,172.4331;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;-281.2107,-96.38966;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-322.5599,-263.84;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-142.8009,-107.8595;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-440.1197,81.53083;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;26;-726.7081,101.6644;Float;False;cir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;130.6749,274.6083;Float;False;Property;_Sideglow;Side glow;6;0;Create;True;0;0;False;0;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;109.009,192.7807;Float;False;26;cir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;36.12958,32.63084;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;39;305.4907,389.3948;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;346.6108,327.3267;Float;False;Property;_Glowmult;Glow mult;7;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;28;344.9725,208.3961;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;209.4684,4.335421;Float;True;Property;_Maintexture;Main texture;0;0;Create;True;0;0;False;0;f12b48cf77a2cf841abc23d989f76fb0;f12b48cf77a2cf841abc23d989f76fb0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;557.2027,386.2833;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;558.543,125.9898;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;561.3483,264.3205;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;37;762.3355,277.9827;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;42;302.9428,548.659;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;783.8012,68.87093;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;41;577.5883,582.4966;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;34;938.1036,67.58508;Float;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;36;939.4379,176.0529;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;43;880.8282,423.2326;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;1142.02,69.0274;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;1294.916,70.30168;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;1.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;1408.069,-350.5273;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;0,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;46;1401.772,-167.9298;Float;False;Property;_Color2;Color2;3;0;Create;True;0;0;False;0;0,0.1724138,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;44;1438.888,74.12386;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;1720.392,-26.25922;Float;False;Property;_Emission;Emission;4;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;47;1716.595,-167.9298;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;52;1677.89,263.3783;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;1964.377,-161.6332;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;50;2128.082,-153.7626;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;2061.971,214.5806;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;2327.999,-150.6145;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;55;2477.538,-158.4848;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;54;2697.916,-46.72255;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;2945.304,-47.94957;Float;False;True;2;Float;;0;7;ERB/Unlit/ElectroSphere;0b6a9f8b4f707c74ca64c0be8e590de0;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;2;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;True;2;False;-1;True;True;True;True;False;0;False;-1;False;True;2;False;-1;True;3;False;-1;False;True;4;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;False;0;False;False;False;False;False;False;False;False;False;False;True;0;0;;0;0;Standard;0;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;9;0;1;0
WireConnection;23;0;2;0
WireConnection;10;0;9;0
WireConnection;21;0;23;1
WireConnection;21;1;23;0
WireConnection;11;1;10;0
WireConnection;14;0;11;1
WireConnection;56;0;21;0
WireConnection;56;1;57;0
WireConnection;3;0;2;0
WireConnection;4;0;3;0
WireConnection;6;0;5;0
WireConnection;58;0;56;0
WireConnection;18;0;14;0
WireConnection;19;0;18;0
WireConnection;19;1;58;0
WireConnection;7;0;4;0
WireConnection;7;1;6;0
WireConnection;26;0;3;0
WireConnection;8;0;7;0
WireConnection;8;1;19;0
WireConnection;39;0;27;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;25;1;8;0
WireConnection;38;0;39;0
WireConnection;30;0;25;1
WireConnection;30;1;28;0
WireConnection;32;0;28;0
WireConnection;32;1;33;0
WireConnection;37;0;38;0
WireConnection;42;0;27;0
WireConnection;31;0;25;2
WireConnection;31;1;30;0
WireConnection;31;2;32;0
WireConnection;41;0;42;0
WireConnection;34;0;31;0
WireConnection;36;0;37;0
WireConnection;43;0;41;0
WireConnection;35;0;34;0
WireConnection;35;1;36;0
WireConnection;40;0;35;0
WireConnection;40;2;43;0
WireConnection;44;0;40;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;47;2;44;0
WireConnection;49;0;47;0
WireConnection;49;1;48;0
WireConnection;50;0;49;0
WireConnection;53;0;48;0
WireConnection;53;1;44;0
WireConnection;53;2;52;4
WireConnection;51;0;50;0
WireConnection;51;1;52;0
WireConnection;51;2;53;0
WireConnection;55;0;51;0
WireConnection;54;0;55;0
WireConnection;54;3;53;0
WireConnection;0;0;54;0
ASEEND*/
//CHKSM=FD55C15D0E461C472405F1D3DC8351A0FD8CEBD4