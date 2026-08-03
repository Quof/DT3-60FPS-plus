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

_speed=0
_direction=0
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
    bulletSpeed-=0.5*gDeltaTime
    if bulletSpeed=0 {atkProg+=1}
  }
  else if atkProg>=1
  {
    atkProg+=1*gDeltaTime
    if atkProg=29
    {
      if checkScreenArea(x,y,112)=1
      {
        playSound(global.snd_Magic,0,0.94,27000)
        playSound(global.snd_ChargeStrike,0,0.89,27000)
      }
      bulletSpeed=9
      _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
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

  //speed=bulletSpeed
  _speed=bulletSpeed
  image_angle+=15*gDeltaTime
  x += cos(degtorad(_direction)) * _speed * gDeltaTime
  y -= sin(degtorad(_direction)) * _speed * gDeltaTime

  decayTime-=1*gDeltaTime
  if decayTime<=0 {instance_destroy()}
}
else {_speed=0}
correctSpeedDirection(self)
