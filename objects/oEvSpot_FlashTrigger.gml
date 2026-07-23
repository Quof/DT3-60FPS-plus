#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=2
image_yscale=4

colR=255
colG=255
colB=255

cR_Seq=0
cG_Seq=0
cB_Seq=0
barColor=c_black
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Red -----
if cR_Seq=0
{
  colR-=2
  if colR<=2 {cR_Seq=1}
}
else
{
  colR+=2
  if colR>=253 {cR_Seq=0}
}
//----- Green -----
if cG_Seq=0
{
  colG-=4
  if colG<=4 {cG_Seq=1}
}
else
{
  colG+=4
  if colG>=251 {cG_Seq=0}
}
//----- Blue -----
if cB_Seq=0
{
  colB-=7
  if colB<=7 {cB_Seq=1}
}
else
{
  colB+=7
  if colB>=248 {cB_Seq=0}
}
barColor=make_color_rgb(colR,colG,colB)
draw_set_color(barColor)
//draw_set_blend_mode_ext(bm_src_alpha_sat,bm_inv_src_color)
draw_set_alpha(0.4)
draw_rectangle(x,y,x+image_xscale*16,y+image_yscale*16,0)
//draw_set_blend_mode(bm_normal)
