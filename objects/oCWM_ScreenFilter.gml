#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
valueHue=255
valueSaturation=0
valueValue=255
valueAlpha=0.2
myColor=make_color_hsv(valueHue,valueSaturation,valueValue)
offSet=240

surf=surface_create(room_width,room_height)
screen_redraw()
surface_set_target(surf)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if keyboard_check(ord("1")) {valueHue-=1}
if keyboard_check(ord("2")) {valueHue+=1}
if keyboard_check(ord("3")) {valueSaturation-=1}
if keyboard_check(ord("4")) {valueSaturation+=1}
if keyboard_check(ord("5")) {valueValue-=1}
if keyboard_check(ord("6")) {valueValue+=1}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
surface_set_target(surf)
screen_redraw()
surface_reset_target()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myColor=make_color_hsv(valueHue,valueSaturation,valueValue)
draw_surface_ext(surf,128+offSet,0,1,1,0,myColor,valueAlpha)

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(view_xview[0]+16,view_yview[0]+96,valueHue)
draw_text(view_xview[0]+16,view_yview[0]+112,valueSaturation)
draw_text(view_xview[0]+16,view_yview[0]+128,valueValue)
