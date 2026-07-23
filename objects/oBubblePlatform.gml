#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
image_speed=0
bubbleFrm=0

shiftSeq=0
shiftTime=0
deathCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //Animation
  bubbleFrm+=1
  if bubbleFrm=5 {image_index=1}
  else if bubbleFrm=10 {image_index=0}
  else if bubbleFrm=15 {image_index=2}
  else if bubbleFrm=20 {image_index=0; bubbleFrm=0}

  //Movement
  if shiftSeq=0 //Blown out (right)
  {
    xVel=2
    shiftTime+=1
    if shiftTime>=shiftMax
    {
      xVel=0
      shiftTime=0
      shiftSeq+=1
    }
  }
  else if shiftSeq=1 //Rise up
  {
    yVel=-0.5
    shiftTime+=1
    if shiftTime>=120 and shiftTime mod 5=0
    {
      if image_blend=c_white {image_blend=c_red}
      else {image_blend=c_white}
    }
    if shiftTime>=160
    {
      var tFFScl,tEffect;
      for(i=0;i<8;i+=1)
      {
        tFFScl=random(0.1)
        tEffect=instance_create(x-8+random(16),y-8+random(16),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sBubBubble; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
        tEffect.direction=random_range(60,120); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
        tEffect.fadeSpd=0.035
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      }
      instance_destroy()
    }
  }
}
