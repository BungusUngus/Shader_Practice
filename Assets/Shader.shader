Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ColorA("Color A", Color) = (1,1,1,1)
        _ColorB("Color B", Color) = (0,0,0,1)
        _Scale ("Scale UV", float) = 1
        _Offset ("Offset UV", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            

            #include "UnityCG.cginc"

            #define HALF_TAU UNITY_TWO_PI * 0.5
            #define TAU UNITY_TWO_PI

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent: TANGENT;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float _Scale;
            float _Offset;
            float4 _ColorA;
            float4 _ColorB;

            v2f vert (appdata v)
            {
                v2f o;
                //v.vertex += sin(_Time.y * 0.5 + v.vertex.y);
                
                // v.vertex += cos(_Time.y * 3 + v.vertex.y) + tan(_Time.y * 3 + v.vertex.y) * 3 + 1.2;
                //v.vertex.xyz += v.tangent.xyz * 0.1;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //float t = frac(i.uv.x * 5) * 2;
                //float4 outColour = lerp(_ColorA, _ColorB, cos(_Time.y * t)); //sin(_Time.Y) * 0.5 + 0.5); saturate makes the clamp between 0 and 1

                float xOffset = cos(i.uv.x * 100) * 10;
                float t = cos(i.uv.x * 100 + xOffset + _Time.y * 5 ) * 20 + 1;
                float4 outColour = lerp (_ColorA,_ColorB, t);
                return outColour;
            }
            ENDCG
        }
    }
}
