#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II's title card (CHAOS WARMASTER II), like oWarmasterTitlecard's: it shrinks in from double size with a
//trail of copies, flashes, holds, then fades. type 0: the card, 1: a trail copy, 2: the flash
type=0
displayTime=0
image_xscale=2
image_yscale=2
image_alpha=0
image_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tPrev,tC;
tPrev=displayTime
displayTime+=1*gDeltaTime
if type=0
{
  if displayTime<=40
  {
    image_xscale-=0.025*gDeltaTime; image_yscale-=0.025*gDeltaTime
    image_alpha+=0.025*gDeltaTime
    if floor(displayTime/2)!=floor(tPrev/2) //a trail copy every other tick
    {
      tC=instance_create(x,y,oWM2_Titlecard); tC.type=1
      tC.image_xscale=image_xscale; tC.image_yscale=image_yscale; tC.image_alpha=0.2
    }
  }
  else if tPrev<41 and displayTime>=41
  {
    image_xscale=1; image_yscale=1; image_alpha=1
    tC=instance_create(x,y,oWM2_Titlecard); tC.type=2
    tC.image_xscale=1; tC.image_yscale=1; tC.image_alpha=1
    playSound(global.snd_HardHit1,0,0.9,1)
  }
  else if displayTime>=100
  {
    image_alpha-=0.08*gDeltaTime
    if image_alpha<=0 {instance_destroy()}
  }
}
else if type=1
{
  image_xscale+=0.025*gDeltaTime; image_yscale+=0.025*gDeltaTime
  image_alpha-=0.02*gDeltaTime
  if image_alpha<=0 or displayTime>=10 {instance_destroy()}
}
else if type=2
{
  image_xscale+=0.01*gDeltaTime; image_yscale+=0.01*gDeltaTime
  image_alpha-=0.06*gDeltaTime
  if image_alpha<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=2
{
  draw_set_blend_mode(bm_add)
  draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,image_alpha)
  draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,image_alpha)
  draw_set_blend_mode(bm_normal)
}
else {draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,image_alpha)}
