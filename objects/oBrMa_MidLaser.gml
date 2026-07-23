#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: idleTime
event_inherited()
sprite_index=sNull
image_xscale=room_height
image_yscale=3
image_angle=270

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2
decayTime=0
warnTime=60
warnAlpha=1
alphaChange=0
warnToPlayer=288
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oBrainMachine.x
  if bCanDealDamage=true
  {
    image_blend=make_color_rgb(150+random(50),150+random(50),150+random(50))
    decayTime+=1
    if decayTime>=idleTime {instance_destroy()}
  }
  else
  {
    warnTime-=1
    if warnTime=0
    {
      playSound(global.snd_Shock,0,0.81,17000)
      sprite_index=sShroudLLaser
      bCanDealDamage=true
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if warnTime>0
{
  draw_sprite_ext(sWarningSymbol,-1,x,warnToPlayer,0.6,0.6,0,c_white,warnAlpha)
  alphaChange+=1
  if alphaChange=8
  {
    if warnAlpha=1 {warnAlpha=0}
    else {warnAlpha=1}
    alphaChange=0
  }
}
