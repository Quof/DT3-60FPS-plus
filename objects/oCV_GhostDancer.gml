#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-10,-50,10,-1)
image_speed=0.3

//Enemy base statistics
eName="Ghost Dancer"
eLevel=15
maxLife=270
life=maxLife
pointWorth=16
atkPower=4
resType[2]=2
resType[3]=1
resType[4]=4
stunResist=4
baseItemChance=55
affiliation=3
dieEffect=0

runAcc=3.25
atkTime=20
atkDelay=40

deathAnim=0

jeremyText="Oh man, these things are hilarious. That flying leap hug attack thing just cracks me up every time."
chaoText="These always creeped me out. Watch out for that leap, when you try to go under them, they'll track you a little bit."
devText="When I was replaying 'Symphony of the Night', my roommates would sometimes watch. On two different occasions, each of them saw this enemy and the first thing both of them said was 'You should put that in your game!', so... I did."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=1; myShadow.maxShadowDist=192
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    //---------- Movement ----------
    if atkTime<atkDelay
    {
      if x<oPlayer1.x
      {
        xVel=runAcc
        image_xscale=1
      }
      else
      {
        xVel=-runAcc
        image_xscale=-1
      }
    }

    //---------- Flying Hug ----------
    atkTime+=1
    if atkTime=atkDelay
    {
      if point_distance(x,0,oPlayer1.x,0)<192
      {
        image_speed=0
        xVel=0
        atkTime=atkDelay+100
      }
      else
        atkTime=atkDelay-3
    }
    else if atkTime=atkDelay+105
    {
      sprite_index=sCV_GhostDancer_FlyingHug
      if image_xscale=1
        xVel=7.5
      else
        xVel=-7.5
      y-=4
      yVel=-8
    }

    if sprite_index=sCV_GhostDancer_FlyingHug
    {
      if image_xscale=1
      {
        if image_angle>-60
          image_angle-=3
      }
      else if image_xscale=-1
      {
        if image_angle<60
          image_angle+=3
      }

      if xVel>1 and oPlayer1.x<x
      {
        if point_distance(x,0,oPlayer1.x,0)<48
          xVel-=1
        else
          xVel-=0.25
      }
      else if xVel<-1 and oPlayer1.x>x
      {
        if point_distance(x,0,oPlayer1.x,0)<48
          xVel+=1
        else
          xVel+=0.25
      }
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      yVel=0
      if sprite_index=sCV_GhostDancer_FlyingHug
      {
        sprite_index=sCV_GhostDancer_Run
        image_angle=0
        image_speed=0.3
        atkTime=0
      }
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)

    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-10,10),y-1-random(50),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
