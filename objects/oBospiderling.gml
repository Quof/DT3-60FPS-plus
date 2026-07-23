#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-16,8,-1)
image_speed=0
bActive=true

//Enemy base statistics
eName="Bospiderling"
eLevel=17
maxLife=80
life=maxLife
pointWorth=5
atkPower=6
resType[1]=2
resType[2]=2
resType[5]=4
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0

atkProg=0
atkTime=0

jeremyText="Starts out being spewed down by the Bospider, then upon landing, will get up and crawl along the floor, over to the walls. These are quite the nuisance with the Bospider coming down on you. If anything, you can use the walls and protect yourself with a Gravity Well."
chaoText="Eww, why are these so creepy looking? For a mechanical spider, it just looks gross."
devText="Following along with the Maverick's weaknesses, the most optimal order would be Storm Eagle -> Gravity Beetle -> Overdrive Ostrich."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if atkProg=0 //Falling
    {
      yVel+=0.4
      if yVel>12 {yVel=12}
      if isCollisionBottom(1)
      {
        atkProg=1
        xVel=0
        yVel=0
      }
      if isCollisionLeft(1) {xVel=0}
      if isCollisionRight(1) {xVel=0}
      moveTo(xVel,yVel)
    }
    else if atkProg=1 //On ground
    {
      atkTime+=1
      if atkTime=12
      {
        image_index=1
        if moveDir=1 {xVel=7}
        else if moveDir=2 {xVel=3}
        else if moveDir=3{xVel=-7}
        else if moveDir=4 {xVel=-3}
      }
      else if atkTime>=15 and atkTime<=999
      {
        if atkTime mod abs(xVel)=0
        {
          if image_index=1 {image_index=2}
          else {image_index=1}
        }

        if xVel>0
        {
          if isCollisionRight(1)
          {
            x=oBospider.xCenter+oBospider.roomSpan
            y=oBospider.yGround-10
            image_angle=90
            atkTime=1000
          }
        }
        else if xVel<0
        {
          if isCollisionLeft(1)
          {
            x=oBospider.xCenter-oBospider.roomSpan
            y=oBospider.yGround-10
            image_angle=270
            atkTime=1000
          }
        }
      }
      if atkTime>=1000
      {
        if moveDir=1 {yVel=7}
        else if moveDir=2 {yVel=3}
        else if moveDir=3{yVel=7}
        else if moveDir=4 {yVel=3}
        atkProg=2
      }
      if atkTime<1000 {moveTo(xVel,yVel)}
    }
    else if atkProg=2 //Run up wall
    {
      atkTime+=1
      if atkTime mod abs(yVel)=0
      {
        if image_index=1 {image_index=2}
        else {image_index=1}
      }
      y-=yVel
      if y<=-16 {instance_destroy()}
    }
  }
  else
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
