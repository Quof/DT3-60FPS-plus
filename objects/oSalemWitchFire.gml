#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=0.65
image_yscale=0.65
atkProg=0
bulletSpeed=7.5
decayTime=120
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    bulletSpeed-=0.5
    if bulletSpeed=0 {atkProg+=1}
  }
  else if atkProg>=1
  {
    atkProg+=1
    if atkProg=29
    {
      if checkScreenArea(x,y,112)=1
      {
        playSound(global.snd_Magic,0,0.94,27000)
        playSound(global.snd_ChargeStrike,0,0.89,27000)
      }
      bulletSpeed=9
      direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    }
    else if atkProg>=30
    {
      if atkProg mod 3=0
      {
        var tExplode;
        tExplode=instance_create(x,y,oDamageExplosion)
        tExplode.sprite_index=sWitchFire; tExplode.atkPower=atkPower; tExplode.decayTime=-100
      }
    }
  }

  speed=bulletSpeed
  image_angle+=15

  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
else {speed=0}
