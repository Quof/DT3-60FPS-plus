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
eName="Firebird"
eLevel=9
maxLife=410
life=maxLife
pointWorth=14
atkPower=5
damageType="ELEMENTAL"
resType[1]=5
resType[2]=2
resType[4]=2
resType[5]=1
stunResist=1
baseItemChance=60
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3
bSpotted=0

runAcc=0.5
moveTime=irandom(5)
xVel=runAcc
if random(10)>5
  xVel*=-1
extraHeight=0

throwTime=12
throwDelay=13
throwCycle=0

detectDistX=320
jeremyText="This works exactly like the Hammer Throwers from earlier dungeons, except it throws fire. When this fire hits the ground, it slides a bit and lingers. It's pretty annoying."
chaoText="These are the kinds of things I wanted to avoid in the Great Palace. I had a hard time fighting everything in there. The Dread Hawks were the worst."
devText="I really wanted to have the Temple Knights, but their whole sword and shield mechanic would be lost in DT3. Obviously, they didn't make it in, however, in a few chapters (from 4), there's an enemy that makes up for their non-existence. This enemy type was initially going to show up as a miniboss in this Gate, but I didn't want the player facing it this early without dashing."
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

    //---------- Throw fire ----------
    throwTime+=1
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //change anim
        sprite_index=sFirebirdThrow
      else if throwTime=throwDelay+6 //Throw fire
      {
        var tNewAttack;
        tNewAttack=instance_create(x-(4*image_xscale),y-24,oFirebirdFire)
        if image_xscale=-1
          tNewAttack.image_xscale=-1
        tNewAttack.atkPower=atkPower
        tNewAttack.xVel=random_range(2.5,4)*image_xscale
        tNewAttack.yVel=-random_range(4,5)
        throwCycle+=1
        if throwCycle=5
        {
          throwDelay=26
          throwCycle=0
        }
        else
          throwDelay=13
        sprite_index=sFirebirdWalk
        throwTime=0
      }
    }

    yVel+=0.35
    if isCollisionBottom(1)
    {
      y-=2
      extraHeight+=1
      if extraHeight mod 4=0
        yVel=-4
      else
        yVel=-2
    }
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

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
