#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-10,-50,10,-1)
image_speed=0
hoverAlpha=-1

//Enemy base statistics
eName="Mimic"
eLevel=14
maxLife=330
life=maxLife
pointWorth=17
atkPower=5
resType[1]=2
resType[2]=4
resType[3]=2
resType[4]=4
resType[5]=1
stunResist=4
baseItemChance=80
baseDropIndex=50
moneyWorth=10
affiliation=3
dieSound=2
dieEffect=0

atkSpd=5
atkProg=0
atkTime=30
atkDelay=35

jeremyText="Oh wow, this is new... except not really. I don't recommend attempting to attack until it has landed from its strike. You're probably going to take a hit if you do."
chaoText="Eww, I hate mimics too. It's a lame trick to disguise themselves as treasure!"
devText="I knew this enemy would only work on the player once. It was very hard not to make the sprite the same as other chests, but I felt that would be rather unfair in certain scenarios and could get old fast. Then again, it's not like these are going to show up all that often... Watch your back in the future of this game."
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
    //---------- Flying Hug ----------
    atkTime+=1
    if atkProg=0 //Wait for player to get close
    {
      if atkTime=atkDelay
      {
        if point_distance(x,0,oPlayer1.x,0)<100
          atkProg+=1
        else
          atkTime=atkDelay-3
      }
    }
    else if atkProg=1 //Open Anim / Attack
    {
      image_index+=0.25
      if image_index>=1.7
      {
        sprite_index=sCV_Mimic_Bite
        if oPlayer1.x>x
        {
          image_xscale=1
          xVel=6
        }
        else
        {
          image_xscale=-1
          xVel=-6
        }
        y-=4
        yVel=-5
      }
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      yVel=0
      if sprite_index=sCV_Mimic_Bite
      {
        xVel=0
        sprite_index=sCV_Mimic_Idle
        image_index=0
        atkProg=0
        atkTime=0
      }
    }
    if isCollisionLeft(1)
    {
      x+=2
      xVel=0
    }
    if isCollisionRight(1)
    {
      x-=2
      xVel=0
    }
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
    playSound(global.snd_HardHit1,0,0.9,1)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMissExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
