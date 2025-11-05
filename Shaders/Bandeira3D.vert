#version 330 core
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aNormal;
layout(location = 2) in vec2 aTexCoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float iTime;

out vec3 FragPos;
out vec3 Normal;
out vec2 TexCoord;
out vec3 WorldPos;

void main() 
{
    
    float amplitude = 0.4;     
    float frequencia_x = 4.0; 
    float frequencia_y = 3.0;  
    float velocidade = 2.0;    


    float fase_x = aPos.x * frequencia_x - iTime * velocidade;
    float onda_principal = sin(fase_x);

    float fase_y = aPos.y * frequencia_y + iTime * (velocidade * 0.7f); 
    float onda_secundaria = sin(fase_y);

    float deslocamento_z = (onda_principal + onda_secundaria) * amplitude;

    deslocamento_z *= aPos.x;


    vec3 displacedPos = aPos + vec3(0.0, 0.0, deslocamento_z);

    WorldPos = vec3(model * vec4(displacedPos, 1.0));
    FragPos = WorldPos;
    

    Normal = mat3(transpose(inverse(model))) * aNormal;
    
    TexCoord = aTexCoord;
    
    
    gl_Position = projection * view * vec4(FragPos, 1.0);
}