#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Ice Block
event_inherited()
image_speed=0
image_alpha=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"

moveProg=0
moveTime=0
ySpd=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ranDir=irandom_range(45,135)
x=xPlace+lengthdir_x(64,ranDir)
y=yPlace+lengthdir_y(64,ranDir)
direction=ranDir+180
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if moveProg=0 //Fade in
  {
    image_alpha+=0.1
    if image_alpha>=1 {moveProg=1}
  }
  else if moveProg=1 //Slight wait
  {
    moveTime+=1
    if moveTime>=10 {moveTime=0; moveProg=2}
  }
  else if moveProg=2 //Move to place
  {
    speed=4
    if point_distance(x,y,xPlace,yPlace)<=4
    {
      x=xPlace; y=yPlace
      speed=0
      moveProg=3
    }
  }
  else if moveProg=3 //Slight wait
  {
    moveTime+=1
    if warTarget.DIFFICULTY>=2 {moveTime+=0.5}
    if moveTime>=15 {moveTime=0; moveProg=4}
  }
  else if moveProg=4 //Fall
  {
    y+=ySpd
    if ySpd<8 {ySpd+=0.15}
    if y>=warTarget.yGround
    {
      var tEffect;
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(x+random_range(-16,16),y+random_range(-2,2),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sWarmasterC_IceShard; tEffect.newBlend=-1
        tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.direction=random_range(45,135); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
        tEffect.fadeSpd=0.025; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-12,12)
      }
      instance_destroy()
    }
  }
}
else {speed=0}
