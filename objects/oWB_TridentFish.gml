#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-11,-11,11,11)
image_speed=0.15

//Enemy base statistics
eName="Trident Fish"
eLevel=15
maxLife=390
life=maxLife
pointWorth=15
atkPower=5
resType[2]=4
resType[3]=2
baseItemChance=70
baseDropIndex=90
moneyWorth=5
dieEffect=0
runAcc=1.75
weight=90
inactiveDist*=1.25

shotTime=60
shotDelay=90

deathAnim=0
yDeath=0

jeremyText="Remember the Aquatic Demon from the Water Palace? These are just like them, except they throw spears a bit faster than the demons spit acid. These also can't leave the water so that's a good thing."
chaoText="These are so cute... Most of the Wonder Boy monsters are cute. Look at him with his cute little fins, and his stubby little legs. I just wanna squeeze him!"
devText="For DT1, I don't feel I made the enemies well suited for their environments. This is something I wanted to fix for this game. That mixed in with the better AI has, so far, proved to be working better than my approach for DT1."
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
    if x<oPlayer1.x
      image_xscale=1
    else
      image_xscale=-1

    if isCollisionWaterTop(-11) //-------------------- In Water --------------------
    {
      dir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      moveTo((runAcc)*cos(degtorad(dir)),-(runAcc)*sin(degtorad(dir)))
    }
    else //-------------------- On Land --------------------
    {
      xVel=0
      yVel+=0.3
      if isCollisionBottom(1)
        yVel=0
      if isCollisionLeft(1)
        xVel=runAcc
      if isCollisionRight(1)
        xVel=-runAcc
      if isCollisionTop(1)
        yVel=1

      moveTo(xVel,yVel)
      if isCollisionSolid()
        y-=2

      if y>room_height+24
      {
        if questType>0
          enemyQuest(questType)
        instance_destroy()
      }
    }

    //---------- Throw Spear ----------
    if findTargetX<224 or shotTime>=shotDelay
      shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime>=shotDelay and shotTime<=shotDelay+4 //change anim
      {
        image_speed=0
        image_index=0
        sprite_index=sWB_TridentFish_Stab
      }
      else if shotTime=shotDelay+13 //spit acid
      {
        image_index=1
        var tNewAttack;
        tNewAttack=instance_create(x+(4*image_xscale),y+1,oGravityBullet)
        tNewAttack.sprite_index=sTridentFishSpear; tNewAttack.image_xscale=image_xscale
        tNewAttack.atkPower=atkPower; tNewAttack.xVel=6*image_xscale; tNewAttack.yVel=-2
      }
      else if shotTime=shotDelay+20 //end attack
      {
        sprite_index=sWB_TridentFish_Swim
        image_speed=0.15
        shotTime=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sWB_TridentFish_Die
      yDeath=-6
    }
    else if deathAnim>=2
    {
      y+=yDeath
      if yDeath<12 {yDeath+=0.3}
      if y>room_height+24 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
