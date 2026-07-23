#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//decayTime=10
textColor=make_color_rgb(255,255,0)
var tRanWord;
tRanWord=irandom_range(1,10)

hitWord=""
if tRanWord=1 {hitWord="POW"}
else if tRanWord=2 {hitWord="BIFF"}
else if tRanWord=3 {hitWord="BAM"}
else if tRanWord=4 {hitWord="SOK"}
else if tRanWord=5 {hitWord="WAM"}
else if tRanWord=6 {hitWord="BOOM"}
else if tRanWord=7 {hitWord="SPLAT"}
else if tRanWord=8 {hitWord="CRACK"}
else if tRanWord=9 {hitWord="RIP"}
else if tRanWord=10 {hitWord="SMACK"}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//decayTime-=1
//if decayTime<=0
//{
  image_alpha-=0.05
  if image_alpha<=0 {instance_destroy()}
//}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,image_alpha)
draw_set_alpha(image_alpha)
draw_set_color(textColor)
draw_set_font(fnt_MashButtons)
draw_set_halign(fa_middle)
draw_text_transformed(x,y-11,hitWord,0.75,0.75,0)
