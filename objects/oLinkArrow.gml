#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-6,-1,6,1)

damageType="PIERCE"
weaponTag=1
atkLv=global.stLink_Arrow[0]
var tCrossbow;
tCrossbow=1
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]=36 //Equipment: Crossbow
  {
    tCrossbow=1.5
    break;
  }
}
atkPower=round((50+(round(global.stLink_Arrow[0]*1.5)+global.skillTree[9]))*tCrossbow)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stLink_Arrow[2]+=1
stunTime=5

if oPlayer1.image_xscale=1
{
  bDir=0
  arrowProg=0
}
else
  bDir=1

bulletSpeed=0
_speed=0
_direction=0
bCollide=0
lingerFrame=0
arrowTick=0 //60fps change (added): the arrow's own 30fps tick count, so it turns once per tick (see the Step event)
//alarm[0]=1
alarm[0]=round(1/gDeltaTime) //60fps change: the speed is set one 30fps tick after creation, as at 30fps. Alarms count frames, so with 1 the arrow started moving after half/a quarter of a tick, having turned 2 degrees once instead of twice, and the whole arc flew ~2 degrees higher (over Army Eye)
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//var bodge
//if gDeltaTime == 1
//{
//  bodge = 0
//}
//else
//{
//  bodge = global.arrowSpeedBodge
//}
//bulletSpeed=12+(attackCharge/5)+bodge
bulletSpeed=12+(attackCharge/5) //60fps change: no speed bodge needed now that the arrow turns once per 30fps tick (the +0.75 made arrows fly 20+px further than at 30fps)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //var bodge
  //if gDeltaTime == 1
  //{
  //  bodge = 0
  //}
  //else
  //{
  //  bodge = global.arrowRotateBodge
  //}
  if lingerFrame=0
  {
    _speed=bulletSpeed
    image_angle=_direction
    //60fps change (added): turn 2 degrees once per 30fps tick (on the first frame of each of this arrow's ticks) and move every frame,
    //so every tick moves exactly like 30fps (turning a bit every frame left the arrow lagging upward, so the arc went too high)
    arrowTick+=gDeltaTime
    if frac(arrowTick-gDeltaTime)=0
    {
    if bDir=0
    {
      if arrowProg=0
      {
        //_direction-=2*gDeltaTime+bodge
        _direction-=2; if _direction<0 {_direction+=360} //60fps change: wraps like GM's built-in direction did, so "_direction>180" below works (without it right-facing arrows never reached the 300 limit and kept curving into loops)
        if _direction>180 {arrowProg=1}
      }
      else if arrowProg=1
      {
        //if _direction>300 {_direction-=2*gDeltaTime+bodge}
        if _direction>300 {_direction-=2} //60fps change: once per tick (see above)
      }
    }
    else
    {
      //if _direction<240 {_direction+=2*gDeltaTime+bodge}
      if _direction<240 {_direction+=2} //60fps change: once per tick (see above)
    }
    }

    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if isCollisionLeft(1) {bCollide=1}
    if isCollisionRight(1) {bCollide=1}
    if isCollisionBottom(1) {bCollide=1}
    if isCollisionTop(1) {bCollide=1}
    if y>room_height+16 {instance_destroy()}

    if global.optWeaponTrail=1 and gDeltaDoTicks {instance_create(x,y,oEfWeaponTrail)} //once per 30fps tick

    if bCollide=1
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_ArrowHit,0,1,1)}
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.5; tExpLight.image_yscale=0.5
      arrEffect=instance_create(x,y,oWepEf_Arrow)
      arrEffect.image_xscale=image_xscale
      arrEffect.image_angle=image_angle
      for(i=0;i<6;i+=1)
      {
        var tFFScl,tEffect;
        tFFScl=random(0.15)
        tEffect=instance_create(x,y,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.5; tEffect.image_xscale=0.05+tFFScl; tEffect.image_yscale=0.05+tFFScl
        if image_xscale=1 {tEffect.direction=random_range(135,225)}
        else {tEffect.direction=random_range(-45,45)}
        tEffect.speed=random(1)+0.5; tEffect.friction=random(0.03)+0.02; tEffect.fadeSpd=0.03; tEffect.image_blend=c_silver
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
      lingerFrame=1; _speed=0; visible=0
    }
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {_speed=0}
correctSpeedDirection(self)
