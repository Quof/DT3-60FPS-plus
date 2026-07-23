#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type,moveType
event_inherited()
makeActive()
setCollisionBounds(-8,-32,8,-1)
image_speed=0

//Enemy base statistics
eName="Warship Mech Shooter"
eLevel=39
maxLife=18000
life=maxLife
pointWorth=120
atkPower=14
moneyWorth=0
affiliation=7

runAcc=3
shotTime=30
shotDelay=50

deathAnim=0

jeremyText="Too busy blowing things up to give any info."
chaoText="There's about 3 of these mechs here which all have the same movement behavior. Their differences are in their offensive outputs. Don't trust the names of them, they're somewhat misleading. Like the rocket one that doesn't fire rockets. They also have two different movement types, but they can't switch them at any time. Each seems to be preset with one. They also have a death bullet."
devText="No Dev Commentary at this time."

alarm[0]=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewAttack,tDir;
tDir=point_direction(x+(8*image_xscale),y-18,oPlayer1.x,oPlayer1.y-27)-5
for(i=0;i<3;i+=1)
{
  tNewAttack=instance_create(x+(8*image_xscale),y-18,oWS_QuadBullet)
  tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5; tNewAttack.decayTime=70
  tNewAttack.direction=tDir
  tDir+=5
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 //Quad
{
  setCollisionBounds(-18,-32,18,-1)
  sprite_index=sWS_QuadShooter
  eName="Warship Spider Shooter"
  runAcc=5
}
else if type=2 //Rocket
{
  setCollisionBounds(-7,-24,7,-1)
  sprite_index=sWS_RocketShooter
  eName="Warship Rocket Shooter"
  runAcc=3
}
else if type=3 //Spread
{
  setCollisionBounds(-11,-42,11,-1)
  sprite_index=sWS_SpreadShooter
  eName="Warship Spread Shooter"
  runAcc=4
}

if moveType=1
{
  image_speed=0
  image_index=2
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
  if bActive=true and life>0
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    if moveType=0 //On ground
    {
      if point_distance(x,y,oPlayer1.x,oPlayer1.y)<144 //Stand
      {
        image_speed=0; image_index=0
        xVel=0
      }
      else //Walk
      {
        if shotTime<shotDelay-5
        {
          image_speed=0.25
          xVel=runAcc*image_xscale
        }
        else
        {
          image_speed=0
          xVel=0
        }
      }
    }
    else if moveType=1 //Flying
    {
      if point_distance(x,0,oPlayer1.x,0)>144 {x+=(runAcc*0.75)*image_xscale}
      else if point_distance(x,0,oPlayer1.x,0)<112 {x-=(runAcc*0.75)*image_xscale}

      if y-(sprite_height/2)<oPlayer1.y-27-4 {y+=(runAcc*0.5)}
      else if y-(sprite_height/2)>oPlayer1.y-27+4 {y-=(runAcc*0.5)}
    }

    shotTime+=1
    if shotTime=shotDelay-15 //Warn
    {
      var tEffect;
      tEffect=instance_create(x,y-(sprite_height/2),oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
      tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
    }
    if shotTime>=shotDelay //Shoot
    {
      if type=1 //---------- Quad ----------
      {
        if shotTime>=shotDelay and shotTime<=shotDelay+16 and shotTime mod 2=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x+(17*image_xscale),y-26,oWS_QuadBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7; tNewAttack.decayTime=70
          if image_xscale=1 {tNewAttack.direction=0}
          else {tNewAttack.direction=180}
        }
        else if shotTime>=shotDelay+17 {shotTime=0}
      }
      else if type=2 //---------- Rocket ----------
      {
        if shotTime>=shotDelay and shotTime<=shotDelay+16 and shotTime mod 4=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x+(8*image_xscale),y-18,oWS_QuadBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5; tNewAttack.decayTime=70
          tNewAttack.direction=point_direction(x+(16*image_xscale),y-32,oPlayer1.x,oPlayer1.y-27)
        }
        else if shotTime>=shotDelay+17 {shotTime=0}
      }
      else if type=3 //---------- Spread ----------
      {
        if shotTime>=shotDelay and shotTime<=shotDelay+16 and shotTime mod 8=0
        {
          var tNewAttack,tDir;
          tDir=0
          for(i=0;i<8;i+=1)
          {
            tNewAttack=instance_create(x+(19*image_xscale),y-34,oWS_QuadBullet)
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6; tNewAttack.decayTime=70; tNewAttack.direction=tDir
            tDir+=360/8
          }
        }
        else if shotTime>=shotDelay+17 {shotTime=0}
      }
    }

    if moveType=0
    {
      yVel+=0.3
      if isCollisionBottom(1)
      {
        yVel=0
        bJumpReady=1
      }
      if isCollisionLeft(1)
      {
        if xVel!=0 {xVel=runAcc}
      }
      if isCollisionRight(1)
      {
        if xVel!=0 {xVel=-runAcc}
      }
      if isCollisionSolid()
        y-=2

      moveTo(xVel,yVel)
      if y>room_height+24 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
