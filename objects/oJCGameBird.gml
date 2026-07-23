#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.15+random(0.25)

damageType="SPECIAL"
weaponTag=21
atkLv=global.stJGame_B[0]
atkPower=25+round(global.stJGame_C[1]*1.5)
atkPower=weaponDmgMod(0,atkPower)
stunTime=2
bCanHitSwitch=0
bCanPierce=1
weaponRehitTime=30

timeOnScreen=0
flySpd=10

global.recBirdsSeen+=1

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible=1
image_xscale=myDir
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if oGame.time mod 10=0 and sprite_index=sBlackCrowFly
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sBlackCrowFeather; tEffect.newBlend=-1; tEffect.image_alpha=0.5; tEffect.fadeSpd=0.04
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-5,5)
    tEffect.direction=random_range(250,290); tEffect.speed=1+random(1)
  }
  timeOnScreen+=1
  if timeOnScreen=1
  {
    direction=point_direction(xstart,ystart,xstart+pointX,ystart+pointY)
    speed=initSpd
  }
  else if timeOnScreen>=2 and timeOnScreen<=30
  {
    speed=initSpd
    if point_distance(x,y,xstart+pointX,ystart+pointY)<=initSpd
    {
      speed=0
      x=xstart+pointX; y=ystart+pointY
      timeOnScreen=31
    }
  }
  else if timeOnScreen=40
  {
    if instance_exists(oEnemyBase)
    {
      var myTarget,myDist;
      myTarget=instance_nearest(x,y,oEnemyBase)
      myDist=point_distance(x,y,myTarget.x,myTarget.y)
      if myDist<=480 {direction=point_direction(x,y,myTarget.x,myTarget.y)} //if target is found and close enough
      else {direction=random(360)} //no enemies close enough
    }
    else {direction=random(360)} //no enemies on map
  }
  else if timeOnScreen>=41
  {
    if global.optWeaponTrail=1 {instance_create(x,y,oEfWeaponTrail)}
    speed=flySpd
    if timeOnScreen>=35
    {
      if checkScreenArea(x,y,48)=0 {instance_destroy()}
    }
  }
}
else {speed=0}
