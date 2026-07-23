#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: patrolProg,maxRange,lastAction
event_inherited()
makeActive()
setCollisionBounds(-24,-24,24,-1)
baseColor=c_black
image_blend=baseColor
image_speed=0
hoverAlpha=-1
bActive=true

//Enemy base statistics
eName="Stalker"
maxLife=10000
life=maxLife
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=100
affiliation=7

patrolSpd=2
chaseSpd=11
xCenter=x
patrolTime=0
lineOfSight=0

jeremyText="N/A"
chaoText="N/A"
devText="N/A"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and stunnedTime=0
  {
    patrolTime+=1
    if patrolProg=0 //Idle
    {
      if patrolTime>=90
      {
        patrolTime=0
        if lastAction=1 {patrolProg=2}
        else if lastAction=2 {patrolProg=1}
      }
    }
    else if patrolProg=1 //Left
    {
      if patrolTime=1
      {
        image_speed=0.15
        image_index=0
        image_xscale=-1
      }

      xVel=-patrolSpd
      if x<=xCenter-maxRoute
      {
        xVel=0
        image_speed=0
        lastAction=patrolProg
        patrolTime=0; patrolProg=0
      }
    }
    else if patrolProg=2 //Right
    {
      if patrolTime=1
      {
        image_speed=0.15
        image_index=0
        image_xscale=1
      }

      xVel=patrolSpd
      if x>=xCenter+maxRoute
      {
        xVel=0
        image_speed=0
        lastAction=patrolProg
        patrolTime=0; patrolProg=0
      }
    }
    else if patrolProg=3 //Chase player
    {
      if patrolTime>=10 and patrolTime<=9999 //Run
      {
        image_speed=0.5
        if x<oPlayer1.x {xVel=chaseSpd; image_xscale=1}
        else {xVel=-chaseSpd; image_xscale=-1}
        if (x<=xCenter-maxChase) or (x>=xCenter+maxChase) {patrolTime=10000}
      }
      if patrolTime>=30 and patrolTime<=9999 //Line of sight
      {
        if collision_line(x,y-26,oPlayer1.x,oPlayer1.y-26,oSolid,1,1) {lineOfSight+=1}
        else {lineOfSight=0}

        if lineOfSight>=25 {patrolTime=10000}
      }
      if patrolTime>=95 and patrolTime<=9999 {patrolTime=10000} //Time

      if patrolTime=10001 //Stop
      {
        xVel=0
        image_speed=0
      }
      else if patrolTime>=10030 //Go back to patrol
      {
        patrolTime=0
        if x<=xCenter {patrolProg=2}
        else {patrolProg=1}
      }
    }

    if patrolProg>=0 and patrolProg<=2 //Detect player
    {
      if point_distance(x,0,oPlayer1.x,0)<208 and point_distance(0,y-32,0,oPlayer1.y-32)<80
      {
        if (image_xscale=1 and x<oPlayer1.x) or (image_xscale=-1 and x>oPlayer1.x)
        {
          if !collision_line(x,y-26,oPlayer1.x,oPlayer1.y-26,oSolid,1,1)
          {
            if collision_rectangle(oPlayer1.x-6,oPlayer1.y-1,oPlayer1.x+6,oPlayer1.y-oPlayer1.sprite_height-2,oLC_Spotlights,1,1)
            {
              playSound(global.snd_MonsterA,0,1,1)
              xVel=0
              image_speed=0
              patrolTime=0
              patrolProg=3
            }
          }
        }
      }
    }

    yVel+=0.3
    if isCollisionBottom(1)
      yVel=0

    moveTo(xVel,yVel)
    if isCollisionSolid() {y-=2}
    if y>room_height+24
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oneHitKill()
