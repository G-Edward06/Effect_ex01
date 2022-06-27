// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Dong/Add_uv"
{
	Properties
	{
		[HDR]_Color("Color", Color) = (1,1,1,1)
		_TEX01("TEX01", 2D) = "white" {}
		_TEX01_U("TEX01_U", Float) = 0
		_TEX01_V("TEX01_V", Float) = 0
		_TEX02("TEX02", 2D) = "white" {}
		_TEX02_U("TEX02_U", Float) = 0
		_TEX02_V("TEX02_V", Float) = 0
		_mask("mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		ZWrite Off
		Blend One One
		
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _TEX01;
		uniform float _TEX01_U;
		uniform float _TEX01_V;
		uniform float4 _TEX01_ST;
		uniform sampler2D _TEX02;
		uniform float _TEX02_U;
		uniform float _TEX02_V;
		uniform float4 _TEX02_ST;
		uniform float4 _Color;
		uniform sampler2D _mask;
		uniform float4 _mask_ST;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 appendResult37 = (float2(_TEX01_U , _TEX01_V));
			float2 uv0_TEX01 = i.uv_texcoord * _TEX01_ST.xy + _TEX01_ST.zw;
			float2 panner34 = ( 0.1 * _Time.y * appendResult37 + uv0_TEX01);
			float4 tex2DNode26 = tex2D( _TEX01, panner34 );
			float2 appendResult42 = (float2(_TEX02_U , _TEX02_V));
			float2 uv0_TEX02 = i.uv_texcoord * _TEX02_ST.xy + _TEX02_ST.zw;
			float2 panner45 = ( 0.1 * _Time.y * appendResult42 + uv0_TEX02);
			float4 tex2DNode40 = tex2D( _TEX02, panner45 );
			float2 uv_mask = i.uv_texcoord * _mask_ST.xy + _mask_ST.zw;
			c.rgb = ( tex2DNode26 * tex2DNode40 * tex2DNode26.a * tex2DNode40.a * i.vertexColor * _Color * _Color.a * i.vertexColor.a * tex2D( _mask, uv_mask ).r ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16600
596;238;1906;977;1018.279;157.7361;1.118724;True;True
Node;AmplifyShaderEditor.RangedFloatNode;51;-1362.846,36.92175;Float;False;Property;_TEX01_U;TEX01_U;3;0;Create;True;0;0;False;0;0;12.26;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1363.965,135.3695;Float;False;Property;_TEX01_V;TEX01_V;4;0;Create;True;0;0;False;0;0;10.62;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-1367.88,291.9908;Float;False;Property;_TEX02_U;TEX02_U;6;0;Create;True;0;0;False;0;0;4.69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1369,390.4386;Float;False;Property;_TEX02_V;TEX02_V;7;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-1093.892,308.5737;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1074.143,35.31714;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1115.32,-200.2794;Float;False;0;26;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-1086.412,521.4704;Float;False;0;40;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;45;-723.9332,293.7183;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;34;-841.0164,0.2066369;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;26;-412.246,-35.65032;Float;True;Property;_TEX01;TEX01;2;0;Create;True;0;0;False;0;36be8d528a4fa024faa4680d7658642c;8220f8a18a1276e4697583c8cd1f6242;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;40;-414.3817,194.2773;Float;True;Property;_TEX02;TEX02;5;0;Create;True;0;0;False;0;61c0b9c0523734e0e91bc6043c72a490;9ed625769015139418983100416b36d1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;48;-311.4521,412.4522;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;59;-163.5736,-225.9784;Float;False;Property;_Color;Color;0;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-333.9229,626.6772;Float;True;Property;_mask;mask;8;0;Create;True;0;0;False;0;None;1c1c87a0784e09c4485e641b7d8bdfa5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;153.5725,47.84287;Float;True;9;9;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;539.5536,88.05875;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Dong/Add_uv;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;42;0;54;0
WireConnection;42;1;55;0
WireConnection;37;0;51;0
WireConnection;37;1;53;0
WireConnection;45;0;47;0
WireConnection;45;2;42;0
WireConnection;34;0;28;0
WireConnection;34;2;37;0
WireConnection;26;1;34;0
WireConnection;40;1;45;0
WireConnection;41;0;26;0
WireConnection;41;1;40;0
WireConnection;41;2;26;4
WireConnection;41;3;40;4
WireConnection;41;4;48;0
WireConnection;41;5;59;0
WireConnection;41;6;59;4
WireConnection;41;7;48;4
WireConnection;41;8;50;1
WireConnection;0;13;41;0
ASEEND*/
//CHKSM=2F0E41CC201D70E9FB621DE3A0ED9A88B4B8109F