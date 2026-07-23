#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

atkPower=400+(oPlayer1.hitCombo*4)
damageType="PIERCE"
weaponTag=153
global.recAtkNum+=1
bCanPierce=1
stunTime=1
weaponRehitTime=5
decayTime=75
lingerFrame=0
homingTrack=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  homingTrack+=1
  if homingTrack mod 6=0
  {
    atkPower=400+(oPlayer1.hitCombo*4)
    if instance_exists(oEnemyBase)
    {
      myTarget=instance_nearest(x,y,oEnemyBase)
      var tTargetCenterX,tTargetCenterY;
      tTargetCenterX=myTarget.bbox_left+round(sprite_width/2)
      tTargetCenterY=myTarget.bbox_top+round(sprite_height/2)
      direction=point_direction(x,y,tTargetCenterX,tTargetCenterY)+random_range(-8,8)
    }
  }
  image_angle=direction
  speed=14

  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
else {speed=0}
