#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-30,7,-1)
image_speed=0.25

//Enemy base statistics
eName="Hammer Thrower"
eLevel=9
maxLife=310
life=maxLife
pointWorth=12
atkPower=4
resType[1]=2
resType[4]=4
resType[5]=1
stunResist=4
baseItemChance=55
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

runAcc=0.5
moveTime=irandom(5)
xVel=runAcc
if random(10)>5
  xVel*=-1

throwTime=7
throwDelay=8
throwCycle=0

detectDistX=320
jeremyText="These guys will constantly throw hammers... kind of like Hammer Bros, but even worse. There is periodically an opening though, watch for it. Try sliding for some extra speed between hammers."
chaoText="Luckily your swing is much bigger than Link's was in Zelda 2, otherwise that little hop they have would be annoying."
devText="When I initially started seeing that DT1 was gaining more players than I thought it would, I began to think about how I should present myself or what kind of persona I should use. At one point, I thought it might be cool if it seemed as if the game wasn't created by anyone, and that it just exists. I couldn't come up with any clever way to do that and realized if there was no voice or face behind the game, it would lose something."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    //---------- Movement ----------
    moveTime+=1
    if moveTime>=45
    {
      xVel*=-1
      moveTime=irandom(5)
    }

    if throwTime<throwDelay
    {
      if x>oPlayer1.x
        image_xscale=-1
      else
        image_xscale=1
    }

    //---------- Throw hammer ----------
    throwTime+=1
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //change anim
        sprite_index=sHammerThrowerThrow
      else if throwTime=throwDelay+6 //Throw hammer
      {
        var tNewAttack;
        tNewAttack=instance_create(x-(4*image_xscale),y-24,oGravityBullet)
        tNewAttack.sprite_index=sHammerThrowerHammer
        if image_xscale=-1
          tNewAttack.image_xscale=-1
        tNewAttack.atkPower=atkPower
        tNewAttack.xVel=random_range(3,4)*image_xscale
        tNewAttack.yVel=-random_range(5,6)
        throwCycle+=1
        if throwCycle=6
        {
          if random(10)>3
          {
            y-=2
            yVel=-2.5
          }
          throwDelay=16
          throwCycle=0
        }
        else
          throwDelay=8
        sprite_index=sHammerThrowerWalk
        throwTime=0
      }
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
