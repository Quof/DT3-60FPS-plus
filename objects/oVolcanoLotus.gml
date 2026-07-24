#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-14,15,-1)
image_speed=0

//Enemy base statistics
eName="Volcano Lotus"
eLevel=4
maxLife=140
life=maxLife
pointWorth=9
atkPower=3
resType[2]=4
resType[5]=4
baseItemChance=50
affiliation=1

annoyTime=65
annoyDelay=90

jeremyText="In case you somehow didn't play Super Mario World, which if you didn't, you should be ashamed of yourself, these guys can't move. However, when you see it start to flash, it's going to annoyingly spew out 4 fire particles, which will slowly fall and will most likely annoy the living hell out of you."
chaoText="So gross and always so annoying in Super Mario World! They were always in the most inconvenient places for me! Even my brother can't stand these!"
devText="I'm not gonna lie, I put these things in simply to have them in situations that made the playing space limited. They work incredibly well for things like that."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks != 1 { exit; }
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    //---------- Annoyance loop ----------
    annoyTime+=1
    if annoyTime<annoyDelay //Idle anim
    {
      if oGame.time mod 6=0
      {
        if image_index=0
          image_index=1
        else
          image_index=0
      }
    }
    else if annoyTime>=annoyDelay and annoyTime<=annoyDelay+20 //Ready to be annoying
    {
      if image_index=1
        image_index=2
      else
        image_index=1
    }
    else if annoyTime=annoyDelay+21 //Spew annoying shit at the player
    {
      image_index=0
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_Flame1,0,0.91,38000)}
      var tNewFire;
      for(i=0;i<4;i+=1)
      {
        tNewFire=instance_create(x,y-8,oVLFire)
        tNewFire.atkPower=atkPower
        if i=0
        {
          tNewFire.xVel=-1
          tNewFire.yVel=-4
          tNewFire.grav=0.1
        }
        else if i=1
        {
          tNewFire.xVel=1
          tNewFire.yVel=-4
          tNewFire.grav=0.1
        }
        else if i=2
        {
          tNewFire.xVel=-2.5
          tNewFire.yVel=-3
          tNewFire.grav=0.09
        }
        else if i=3
        {
          tNewFire.xVel=2.5
          tNewFire.yVel=-3
          tNewFire.grav=0.09
        }
      }
    }
    else if annoyTime>=annoyDelay+42 //Revert to being less annoying for a bit
      annoyTime=0

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
