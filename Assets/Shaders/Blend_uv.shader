// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Dong/Blend_uv"
{
	Properties
	{
		[HDR]_Color0("Color 0", Color) = (1,1,1,1)
		_Tex01("Tex01", 2D) = "white" {}
		_TEX01_U("TEX01_U", Float) = 0
		_TEX01_V("TEX01_V", Float) = 0
		_Tex02("Tex02", 2D) = "white" {}
		_TEX02_U("TEX02_U", Float) = 0
		_TEX02_V("TEX02_V", Float) = 0
		_mask("mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
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

		uniform sampler2D _mask;
		uniform float4 _mask_ST;
		uniform sampler2D _Tex01;
		uniform float _TEX01_U;
		uniform float _TEX01_V;
		uniform float4 _Tex01_ST;
		uniform sampler2D _Tex02;
		uniform float _TEX02_U;
		uniform float _TEX02_V;
		uniform float4 _Tex02_ST;
		uniform float4 _Color0;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_mask = i.uv_texcoord * _mask_ST.xy + _mask_ST.zw;
			float4 tex2DNode69 = tex2D( _mask, uv_mask );
			float2 appendResult60 = (float2(_TEX01_U , _TEX01_V));
			float2 uv0_Tex01 = i.uv_texcoord * _Tex01_ST.xy + _Tex01_ST.zw;
			float2 panner64 = ( 0.1 * _Time.y * appendResult60 + uv0_Tex01);
			float4 tex2DNode65 = tex2D( _Tex01, panner64 );
			float2 appendResult59 = (float2(_TEX02_U , _TEX02_V));
			float2 uv0_Tex02 = i.uv_texcoord * _Tex02_ST.xy + _Tex02_ST.zw;
			float2 panner63 = ( 0.1 * _Time.y * appendResult59 + uv0_Tex02);
			float4 tex2DNode66 = tex2D( _Tex02, panner63 );
			c.rgb = ( tex2DNode65 * tex2DNode66 * tex2DNode65.a * tex2DNode66.a * i.vertexColor * _Color0 * _Color0.a * i.vertexColor.a ).rgb;
			c.a = tex2DNode69.r;
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
248;211;2040;992;955.5087;-1107.144;1.061884;True;True
Node;AmplifyShaderEditor.RangedFloatNode;55;-1111.331,1278.293;Float;False;Property;_TEX01_U;TEX01_U;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1112.45,1376.74;Float;False;Property;_TEX01_V;TEX01_V;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1116.365,1533.362;Float;False;Property;_TEX02_U;TEX02_U;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1117.485,1631.81;Float;False;Property;_TEX02_V;TEX02_V;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-834.897,1762.841;Float;False;0;66;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;61;-863.805,1041.091;Float;False;0;65;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;59;-842.377,1549.945;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;60;-822.628,1276.688;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;64;-589.5015,1241.578;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;63;-472.4183,1535.089;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;68;87.94134,1015.392;Float;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;67;-59.93715,1653.823;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;65;-160.7311,1205.721;Float;True;Property;_Tex01;Tex01;2;0;Create;True;0;0;False;0;36be8d528a4fa024faa4680d7658642c;9746862462a3c184c9d57a481570e035;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;66;-162.8668,1435.648;Float;True;Property;_Tex02;Tex02;5;0;Create;True;0;0;False;0;61c0b9c0523734e0e91bc6043c72a490;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;69;6.79028,1919.018;Float;True;Property;_mask;mask;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;405.0874,1289.214;Float;True;8;8;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;564.0474,1669.412;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1176.414,1447.24;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Dong/Blend_uv;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;59;0;57;0
WireConnection;59;1;58;0
WireConnection;60;0;55;0
WireConnection;60;1;56;0
WireConnection;64;0;61;0
WireConnection;64;2;60;0
WireConnection;63;0;62;0
WireConnection;63;2;59;0
WireConnection;65;1;64;0
WireConnection;66;1;63;0
WireConnection;70;0;65;0
WireConnection;70;1;66;0
WireConnection;70;2;65;4
WireConnection;70;3;66;4
WireConnection;70;4;67;0
WireConnection;70;5;68;0
WireConnection;70;6;68;4
WireConnection;70;7;67;4
WireConnection;71;0;65;1
WireConnection;71;1;66;1
WireConnection;71;2;69;1
WireConnection;71;3;67;4
WireConnection;0;9;69;1
WireConnection;0;13;70;0
ASEEND*/
//CHKSM=D9E75C3575F63E8AB7015E34F294F9BC918E5B0A