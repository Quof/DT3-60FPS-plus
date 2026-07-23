#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-28,12,-1)
image_speed=0.2
gunFrame=0

//Enemy base statistics
eName="Egg Bot"
eLevel=9
maxLife=400
life=maxLife
pointWorth=12
atkPower=4
resType[1]=2
resType[3]=4
resType[4]=4
stunResist=2
baseItemChance=50
baseDropIndex=90
dieSound=2
dieEffect=2
initDir=0
turnTime=0
runAcc=1.25

shotTime=35
shotDelay=70

jeremyText="A robot with slow tracking abilities. Because of this and its inability to move while firing, it is an easy target. That's another thing, you can see it open its firing cannon before it fires, you should have no trouble with this."
chaoText="Is this from the Sonic games? Oh geez, I can't remember where this is from, it's not from Sonic. The name just threw me off."
devText="Development for DT2 started in January 2011 and ended in April 2011. I really wanted to have it done in two months, but life had me exceptionally busy during that time. I wrote the story for DT3 along with DT2, so technically all the important story points for DT3 were finished before production even started on DT2."
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
    if shotTime<shotDelay
    {
      if initDir=0
      {
        xVel=runAcc
        if x>oPlayer1.x {xVel*=-1}
        initDir=1
      }

      if xVel>0 {image_xscale=1}
      else if xVel<0 {image_xscale=-1}

      if x>oPlayer1.x and image_xscale=1
        turnTime+=1
      else if x<oPlayer1.x and image_xscale=-1
        turnTime+=1
      if turnTime>=40
      {
        xVel*=-1
        turnTime=0
      }
    }
    else {xVel=0}

    //---------- Fire gun ----------
    shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime=shotDelay //Start to open gun port
      {
        image_index=0
        image_speed=0
      }
      else if shotTime=shotDelay+3 {gunFrame=1}
      else if shotTime=shotDelay+6 {gunFrame=2}
      else if shotTime=shotDelay+9 {gunFrame=3}
      else if shotTime=shotDelay+12 {gunFrame=4}
      else if shotTime=shotDelay+20 //Fire shot
      {
        var tNewAttack,tXshift;
        if image_xscale=1 {tXshift=14}
        else {tXshift=-14}
        tNewAttack=instance_create(x+tXshift,y-9,oNormalBullet)
        tNewAttack.sprite_index=sEBShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
        if image_xscale=-1 {tNewAttack.direction=180}
      }
      else if shotTime=shotDelay+30 {gunFrame=3}
      else if shotTime=shotDelay+33 {gunFrame=2}
      else if shotTime=shotDelay+36 {gunFrame=1}
      else if shotTime=shotDelay+39 {gunFrame=0}
      else if shotTime=shotDelay+45 //End attack
      {
        turnTime=0
        shotTime=0
        xVel=runAcc
        if x>oPlayer1.x {xVel*=-1}
        image_speed=0.2
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if shotTime>=shotDelay
  draw_sprite_ext(sEggBotGun,gunFrame,x,y-12,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
