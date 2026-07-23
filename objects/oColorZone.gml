#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if zoneColor=1
  image_blend=c_red
else if zoneColor=2
  image_blend=c_blue
else if zoneColor=3
  image_blend=c_green
else if zoneColor=4
  image_blend=c_yellow
flashTime=0
innerAlpha=0.5
sprite_index=sScaledCollision
moveTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if collision_rectangle(x,y,x+image_xscale,y+image_yscale,oPlayer1,0,1)
  {
    if instance_exists(oColorIndControl)
    {
      oColorIndControl.bColorActive[zoneColor-1]=1
      if zoneColor=oColorIndControl.currentColor
        oColorIndControl.bWillDamagePlayer=2
    }

    if flashTime=0
    {
      if innerAlpha=0.5
        innerAlpha=0.6
      else
        innerAlpha=0.5
      flashTime=3
    }
    else
      flashTime-=1
  }
  else
  {
    flashTime=0
    innerAlpha=0.5
  }

  if moveSpd>0
  {
    speed=moveSpd
    moveTime+=1
    if moveTime>=moveDelay
    {
      moveTime=0
      direction+=180
    }
  }
}
else {speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,240)=1
{
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_rectangle(x,y,x+image_xscale-1,y+image_yscale-1,0)
  draw_set_alpha(0.9)
  draw_rectangle(x,y,x+image_xscale-1,y+image_yscale-1,1)
}
