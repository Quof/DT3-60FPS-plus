#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
atkPower=4
damageType="ELEMENTAL"
bWarn=0

image_xscale=1.5
image_yscale=1.5
if room=rExtGateA_5
{
  image_xscale=2
  image_yscale=2
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks
{
  if bWarn=0
  {
    warnTime-=1
    if warnTime<=0
    {
      if type=0
      {
        playSound(global.snd_Bobomb,0,1,1)
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.18
        tFlash.fadeSpeed=0.03
      }
      depth=25
      sprite_index=sCackLightning
      image_xscale=1
      image_yscale=1.75
      bCanDealDamage=true
      bWarn=1
    }
  }
  else
  {
    if oGame.time mod 3=0
    {
      if image_blend=c_white
        image_blend=c_blue
      else
        image_blend=c_white
    }

    decay-=1
    if decay<=0
      instance_destroy()
  }
}
