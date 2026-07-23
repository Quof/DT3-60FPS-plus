#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(-8,-8,8,8)
ranSpeed=random_range(0.5,1.5)
image_xscale=0.2
image_yscale=0.2
fullSize=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if fullSize=0
  {
    image_xscale+=0.05
    image_yscale+=0.05
    if image_xscale=1 {fullSize=1}
  }
  else
  {
    fullSize+=1
    x+=sin(0.05)
    y-=ranSpeed

    if isCollisionSolid() and fullSize>=64 {instance_destroy()}
    if y<-8 or y<view_yview[0]-96 or !isCollisionWaterTop(12) {instance_destroy()}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fullSize>0
{
  global.pCurrBreath=global.pBreathMax-1
  playSound(global.snd_AirBubble,0,1,1)
  awardAwesome(20)
  for(i=0;i<16;i+=1)
  {
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sAirBubble
    tEffect.image_speed=0; tEffect.image_index=irandom_range(0,1); tEffect.speed=random(5)
    tEffect.direction=random_range(60,120); tEffect.friction=random(0.1)+0.1; tEffect.fadeSpd=0.05
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  }
  instance_destroy()
}
