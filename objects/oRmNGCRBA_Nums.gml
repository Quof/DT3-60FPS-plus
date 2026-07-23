#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
numColor=make_color_rgb(128,96,56)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(fnt_HUDnum)
draw_set_alpha(1)
draw_set_halign(fa_center)
draw_set_color(numColor)
if room=rNGC_RB_A
{
  draw_text(886,156,"1")
  draw_text(886,412,"2")
  draw_text(886,668,"3")
}
else if room=rNGC_RB_B
{
  draw_text(166,108,"1")
  draw_text(166,460,"2")
  draw_text(166,812,"3")
  draw_text(166,1164,"4")
  draw_text(166,1516,"5")
  draw_text(166,1868,"6")
  draw_text(166,2268,"7")
}
else if room=rNGC_RB_C
{
  draw_text(454,44,"1")
  draw_text(454,300,"2")
  draw_text(454,556,"3")
}
else if room=rNGC_RB_D
{
  draw_text(358,76,"1")
  draw_text(358,940,"2")
}
