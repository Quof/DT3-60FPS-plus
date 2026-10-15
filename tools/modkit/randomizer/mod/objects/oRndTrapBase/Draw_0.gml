//Randomizer: the screen's tint some traps set (fadeColor, fadeAlpha), as the story's event objects draw it
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
  draw_set_alpha(1)
}
