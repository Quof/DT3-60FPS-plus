#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-18,8,-1)
image_speed=0.33

//Enemy base statistics
eName="Fire Penguin"
eLevel=34
maxLife=340
life=maxLife
pointWorth=61
atkPower=9
resType[1]=4
resType[2]=1
resType[3]=2
resType[5]=2
stunResist=5
baseItemChance=45
moneyWorth=5

runAcc=4
launchTime=10
enemyProg=0

jeremyText="He just stands there at the cannon, launching those cannonballs at you. If you get close enough, he'll just run away though, which is definitely nice."
chaoText="He doesn't have a torch or anything, I wonder how he fires off all those cannonballs."
devText="The idea here wasn't to have enemies that were too rough for the most part. They'd present some challenges that are a bit different, but overall, not as harsh as the CHAOS groups."

myCannon=0

if global.gameProgress=4940 {instance_destroy()}
else {alarm[0]=1}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.x<x {x+=64; image_xscale=-1}
if instance_exists(oPenguinCannon)
{
  myCannon=instance_nearest(x,y,oPenguinCannon)
  if point_distance(x,y,myCannon.x,myCannon.y)>80 {myCannon=0}
}
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
    if enemyProg=0 //Standard behavior
    {
      if myCannon!=0
      {
        if myCannon.bLaunch>=1
        {
          launchTime+=1
          if launchTime>=30
          {
            var targetYVel,tNewAttack,tEffect;
            targetYVel=intercept_target_arc(oPlayer1,7,0.3)

            if targetYVel>-2 {targetYVel=-2}
            else if targetYVel<-9 {targetYVel=-9}

            if x>oPlayer1.x {tDir=-1}
            else {tDir=1}
            for(i=0;i<8;i+=1)
            {
              tEffect=instance_create(myCannon.x+(7*myCannon.image_xscale),myCannon.y-23,oEffectB)
              tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
              tEffect.speed=random(0.75)+0.5; tEffect.image_speed=0.2; tEffect.direction=random(360)
              tEffect.fadeSpd=0.05; tEffect.image_blend=c_black
              tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
            }
            tNewAttack=instance_create(myCannon.x+(7*myCannon.image_xscale),myCannon.y-23,oGravityBullet)
            tNewAttack.sprite_index=sPenCannonBall; tNewAttack.atkPower=atkPower; tNewAttack.grav=0.3
            tNewAttack.xVel=7*tDir; tNewAttack.yVel=targetYVel
            launchTime=0
          }
        }
      }

      if point_distance(x,y-10,oPlayer1.x,returnPlayerYCenter())<=76
      {
        sprite_index=sFirePenguin_Run
        enemyProg=1
      }
    }
    else if enemyProg=1 //Run away from player
    {
      if x>oPlayer1.x
      {
        image_xscale=1
        xVel=runAcc
      }
      else
      {
        image_xscale=-1
        xVel=-runAcc
      }
    }

    yVel+=0.3
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
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
