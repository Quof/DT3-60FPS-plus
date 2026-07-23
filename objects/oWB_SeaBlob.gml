#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-10,-22,10,-1)
image_speed=0.15

//Enemy base statistics
eName="Sea Blob"
eLevel=15
maxLife=380
life=maxLife
pointWorth=22
atkPower=5
resType[2]=4
resType[3]=2
resType[4]=2
resType[5]=4
stunResist=1
baseItemChance=65
baseDropIndex=90
moneyWorth=5
dieEffect=0

throwTime=60
throwDelay=80
throwProg=-1

deathAnim=0
yDeath=0

jeremyText="Jerry, you've come across stationary turret-like enemies before. This is nothing new."
chaoText="Eww, it has wiggly tentacle things. They're so gross!"
devText="Normally an enemy like this would be no problem for the player by this point, but the gimped movement underwater made them a bit more dangerous."
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

    //---------- Sea ball toss ----------
    throwTime+=1
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay
      {
        //Check distance to player
        var tNewAttack,tXThrow;
        tXThrow=point_distance(x,0,oPlayer1.x,0)/64
        if tXThrow>8 {tXThrow=8}
        else if tXThrow<0.75 {tXThrow=0.75}

        tXThrow+=throwProg
        //Throw Coconut
        tNewAttack=instance_create(x+(3*image_xscale),y-12,oGravityBullet)
        tNewAttack.sprite_index=sSeaBlobBall
        if tXThrow<0 {tNewAttack.image_xscale=-1}
        tNewAttack.atkPower=atkPower
        tNewAttack.xVel=tXThrow*image_xscale
        tNewAttack.yVel=-6+(throwProg/2)
        if throwProg=1
          throwTime=throwDelay+99
        else
        {
          throwProg+=1
          throwTime=throwDelay+44
        }
      }
      else if throwTime=throwDelay+50
      {
        throwTime=throwDelay-1
      }
      else if throwTime=throwDelay+100 //End attack
      {
        throwProg=-1
        throwTime=0
      }
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sWB_SeaBlob_Die
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
