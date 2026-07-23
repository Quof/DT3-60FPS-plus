#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-13,-40,13,-1)
image_speed=0.25

//Enemy base statistics
eName="Wolfos"
eLevel=8
maxLife=240
life=maxLife
pointWorth=11
atkPower=4
resType[2]=4
resType[5]=4
stunResist=3
baseItemChance=55
affiliation=2
dieEffect=3

initDir=0
runAcc=1.75

shotTime=60
shotDelay=90

jeremyText="These will stop when they get close enough to you and can fire an arrow at you. The worst part is that if you're close enough, they'll dash back when firing an arrow."
chaoText="Was there even an enemy called a Wolfos in Zelda 2?"
devText="Despite the story continuing after the other games, the difficulty does not pick up where it leaves off. I treat the difficulty at the start of DT3 as a new game. This game also doesn't have a massive difficulty spike... at least I think so."
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
    if shotTime<shotDelay //Normal
    {
      findTargetX=point_distance(oPlayer1.x,0,x,0)
      if findTargetX>112
      {
        //Check if at cliff edge and stop
        var tStop;
        tStop=0
        if aiCheckSpecial(0,3,4)=1
        {
          tStop=1
        }

        if tStop=0
        {
          sprite_index=sWolfosWalk
          if x<oPlayer1.x {xVel=runAcc}
          else {xVel=-runAcc}
        }
        else
        {
          sprite_index=sWolfosIdle
          xVel=0
        }
      }
      else
      {
        if shotTime<shotDelay-1 {shotTime+=1}
        sprite_index=sWolfosIdle
        xVel=0
      }

      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }
    else //Slow down back-dash
    {
      if shotTime>=shotDelay+1
      {
        if xVel>0 {xVel-=0.5}
        else if xVel<0 {xVel+=0.5}
      }
    }

    //---------- Fire arrow ----------
    shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime=shotDelay //change anim and step back if too close to player
      {
        xVel=0
        sprite_index=sWolfosShoot
        if findTargetX<96 //player is close
        {
          var tDash;
          tDash=1
          if aiCheckHoriz(1,4,-16,-4,4)=1
            tDash=0

          if tDash=1 //dash if able to
          {
            if image_xscale=1 {xVel=-7}
            else {xVel=7}
          }
        }
      }
      else if shotTime=shotDelay+20 //Fire shot
      {
        var tNewAttack;
        tNewAttack=instance_create(x+(14*image_xscale),y-31,oNormalBullet)
        tNewAttack.sprite_index=sLinkArrow; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7
        if image_xscale=-1 {tNewAttack.direction=180}
      }
      else if shotTime=shotDelay+30 //End attack
      {
        shotTime=0
        xVel=runAcc
        if x>oPlayer1.x {xVel*=-1}
        image_speed=0.25
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
