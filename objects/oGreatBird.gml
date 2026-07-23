#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x=global.stCGame_C[1]
y=global.stCGame_C[2]
textColorInner=make_color_rgb(248,248,248)
textColorOuter=make_color_rgb(16,8,8)
global.recBirdsSeen+=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()

draw_set_alpha(1)
draw_set_font(fnt_NES)
draw_set_halign(fa_left)
textDropShadow(string("Press [") +string(global.ctrlActC) +string("] to summon the bird."),view_xview[0]+140,view_yview[0]+338,textColorInner,textColorOuter,4)
