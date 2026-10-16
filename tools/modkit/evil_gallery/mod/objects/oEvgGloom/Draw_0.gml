//Evil Boss Gallery: the evil gallery's gloom (the build puts one in rEvgGallery): the view multiplied by a dark rose
//(bm_dest_color, bm_zero: each pixel under it times this colour), over the room and its objects (depth -50), under
//the HUD and messages
draw_set_blend_mode_ext(bm_dest_color,bm_zero)
draw_set_alpha(1)
draw_set_color(make_color_rgb(178,128,150))
draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
draw_set_blend_mode(bm_normal)
draw_set_color(c_white)
