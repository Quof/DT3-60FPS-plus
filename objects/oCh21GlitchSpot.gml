#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if instance_exists(oEvPttT)
  {
    if collision_rectangle(x,y,x+(image_xscale*32),y+(image_yscale*32),oPlayer1,0,1) or collision_rectangle(x,y,x+(image_xscale*32),y+(image_yscale*32),oPlayerIdle,0,1)
    {
      oEvPttT.changeToGlitch=3
    }
  }
}

if oGame.time mod 3=0
{
  var tEffect;
  tEffect=instance_create(x+random(image_xscale*32),y+random(image_yscale*32),oEffect)
  tEffect.sprite_index=sBelmontWepEffect; tEffect.newBlend=-1; tEffect.followID=-1
  tEffect.decay=15; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.1+random(0.1); tEffect.image_alpha=0.33+random(0.33)
}

/*Notes
Tile layers
1000000 - Always visible
999999 - Starts visible - Not visible when on glitch spot
999998 - Only visible when on glitch spot
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.02)
draw_set_color(c_white)
draw_rectangle(x,y,x+(image_xscale*32),y+(image_yscale*32),0)
