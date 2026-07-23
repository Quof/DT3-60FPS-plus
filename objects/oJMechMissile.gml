#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

atkPower=4000+(oPlayer1.hitCombo*100)
damageType="SPECIAL"
weaponTag=152
global.recAtkNum+=1
stunTime=1
decayTime=60
lingerFrame=0
homingTrack=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=110 {playSound(global.snd_BombExplode,0,0.84,13000)}
else {playSound(global.snd_BombExplode,0,0.9,19000)}
var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if lingerFrame=0
  {
    homingTrack+=1
    if homingTrack>=1 and homingTrack<=12 {speed=8}
    else if homingTrack>=13
    {
      if instance_exists(oEnemyBase)
      {
        myTarget=instance_nearest(x,y,oEnemyBase)
        var tTargetCenterX,tTargetCenterY;
        tTargetCenterX=myTarget.bbox_left+(sprite_width/2)
        tTargetCenterY=myTarget.bbox_top+(sprite_height/2)
        direction=point_direction(x,y,tTargetCenterX,tTargetCenterY)
      }
      image_angle=direction
      speed=8
      decayTime-=1
      if decayTime<=0 {instance_destroy()}
    }

    if isCollisionLeft(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionRight(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionBottom(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionTop(1) {lingerFrame=1; speed=0; visible=0}
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}
