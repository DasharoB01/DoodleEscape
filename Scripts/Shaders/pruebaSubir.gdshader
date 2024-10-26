shader_type canvas_item;

uniform vec2 player_position; // Posición del jugador en coordenadas de pantalla
uniform float exclude_radius = 0.05; // Tamaño del área a excluir alrededor del personaje

void fragment() {
    vec2 uv = SCREEN_UV;
    float dist = distance(uv, player_position);

    if (dist < exclude_radius) {
        // Área alrededor del personaje no se oscurece
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
        // El resto de la pantalla se oscurece
        COLOR = vec4(0.0, 0.0, 0.0, 0.8); // Ajusta la opacidad para el oscurecimiento
    }
}
