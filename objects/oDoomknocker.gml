#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-30,7,-1)
image_speed=0.2

//Enemy base statistics
eName="Doomknocker"
eLevel=10
maxLife=390
life=maxLife
pointWorth=15
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=4
resType[4]=4
stunResist=3
baseItemChance=55
baseDropIndex=80
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

runAcc=0.5
moveTime=irandom(5)
xVel=runAcc
if random(10)>5
  xVel*=-1

throwTime=45
throwDelay=70

jeremyText="This is like the Tektites and has some Normal and Shot type resist. I highly suggest taking it out with a bomb and leaving it at that. Close range with them will be a bother especially since that hammerang attack comes back."
chaoText="Ooh, in Zelda 2, I always tried to finish them off by down stabbing without touching the ground. It's not as hard as you would think. I'm such a nerd.~ Did Jeremy ever tell you that I was the one that got him into video games?"
devText="It doesn't show up too early on, but DT3 features more variety in its AI. As with the visuals, DT1's AI variety was fairly lackluster, a problem I have addressed with this game."
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

    //---------- Throw hammerang ----------
    throwTime+=1
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay //change anim
        sprite_index=sDoomknockerThrow
      else if throwTime=throwDelay+6 //Throw hammerang
      {
        var tNewAttack;
        tNewAttack=instance_create(x-(4*image_xscale),y-24,oDoomknockerHammerang)
        tNewAttack.image_xscale=image_xscale
        tNewAttack.atkPower=atkPower
        tNewAttack.bulletSpeed=5*image_xscale
        if random(10)>5
        {
          y-=2
          yVel=-2
        }
        sprite_index=sDoomknockerWalk
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
