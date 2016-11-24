sampler2D _PositionBuffer;
sampler2D _VelocityBuffer;
half3 _Color;

struct Input
{
    half alpha;
    half3 emission;
};

void vert(inout appdata_full v, out Input data)
{
    UNITY_INITIALIZE_OUTPUT(Input, data);

    float2 uv = v.vertex.xy;

    float3 pos = tex2Dlod(_PositionBuffer, float4(uv, 0, 0));
    float3 vel = tex2Dlod(_VelocityBuffer, float4(uv, 0, 0));

    v.vertex.xyz = pos;

    data.alpha = saturate((1 - uv.y) * length(vel) * 0.8);
    data.emission = lerp(half3(1.04, 0.04, 0.0), half3(3.4, 2.0, 1), length(vel) * 0.95);
}

void surf(Input IN, inout SurfaceOutputStandard o)
{
    o.Alpha = IN.alpha * 0.5;
    o.Albedo = 0;
    o.Smoothness = 0;
    o.Metallic = 0;
    o.Emission = IN.emission;
}
