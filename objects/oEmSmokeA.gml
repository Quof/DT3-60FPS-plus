#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: dirRangeA, dirRangeB
findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=400
efDelay=0
dirChangeTime=0
myRangeA=0
myRangeB=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myRangeA=dirRangeA
myRangeB=dirRangeB
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  dirChangeTime-=1
  if dirChangeTime=0 {dirRangeA=myRangeA; dirRangeB=myRangeB}

  efDelay+=1
  if efDelay mod 5=0
  {
    var tFFScl,tEffect;
    tFFScl=random(0.1)
    if room=rWarshipZ_EscapeD {tEffect=instance_create(x+random_range(-2,2),y+random_range(-2,2),oEffect_B_Stop)}
    else {tEffect=instance_create(x+random_range(-2,2),y+random_range(-2,2),oEffectB)}
    tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.image_speed=0.2+random(0.15)
    tEffect.image_alpha=0.6+random(0.2); tEffect.image_xscale=0.6+tFFScl; tEffect.image_yscale=0.6+tFFScl
    tEffect.direction=random_range(dirRangeA,dirRangeB); tEffect.speed=random(1.1)+1.1; tEffect.fadeSpd=0.03
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.xVel>=5
{
  dirRangeA=40; dirRangeB=60
  dirChangeTime=14
}
else if oPlayer1.xVel<=-5
{
  dirRangeA=120; dirRangeB=140
  dirChangeTime=14
}
