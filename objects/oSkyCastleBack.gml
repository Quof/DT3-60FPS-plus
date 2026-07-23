#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
topRepeat=0
bottomRepeat=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
topRepeat+=0.003
bottomRepeat+=0.0025
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_white)
draw_set_alpha(1)
texture_set_repeat(true)
draw_primitive_begin_texture(pr_trianglefan,background_get_texture(backCastlevaniaH))
draw_vertex_texture(view_xview[0],view_yview[0],0+topRepeat+0.3,0+topRepeat)
draw_vertex_texture(view_xview[0]+480,view_yview[0],1+topRepeat,0+topRepeat)
draw_vertex_texture(view_xview[0]+480,view_yview[0]+256,1+topRepeat,1+topRepeat)
draw_vertex_texture(view_xview[0],view_yview[0]+256,0+topRepeat,1+topRepeat+0.3)
draw_primitive_end()

draw_primitive_begin_texture(pr_trianglefan,background_get_texture(backCastlevaniaH))
draw_vertex_texture(view_xview[0],view_yview[0]+416,0+bottomRepeat,0+bottomRepeat+0.3)
draw_vertex_texture(view_xview[0],view_yview[0]+256,1+bottomRepeat+0.3,0+bottomRepeat)
draw_vertex_texture(view_xview[0]+480,view_yview[0]+256,1+bottomRepeat,1+bottomRepeat)
draw_vertex_texture(view_xview[0]+480,view_yview[0]+416,0+bottomRepeat,1+bottomRepeat)
draw_primitive_end()

/*
draw_vertex_texture(-96,-96,0+myRepeat,0+myRepeat)
draw_vertex_texture(room_width+96,-96,1+myRepeat,0+myRepeat)
draw_vertex_texture(-8,288,1+myRepeat,1+myRepeat)
draw_vertex_texture(room_width+8,288,0+myRepeat,1+myRepeat)
