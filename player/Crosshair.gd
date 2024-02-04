@tool
extends Control


func _draw():
    draw_circle(Vector2.ZERO, 4, Color.DIM_GRAY)
    draw_circle(Vector2.ZERO, 3, Color.WHITE)

    # X axis
    draw_line(Vector2(16, 0), Vector2(24, 0), Color.DIM_GRAY, 1)
    draw_line(Vector2(-16, 0), Vector2(-24, 0), Color.DIM_GRAY, 1)

    # y axis
    draw_line(Vector2(0, 16), Vector2(0, 24), Color.DIM_GRAY, 1)
    draw_line(Vector2(0, -16), Vector2(0, -24), Color.DIM_GRAY, 1)