#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

//Enemy base statistics
eName="Magical Bee"
eLevel=10
maxLife=280
life=maxLife
pointWorth=11
atkPower=4
resType[3]=2
resType[4]=5
resType[5]=5
stunResist=1
baseItemChance=60
baseDropIndex=95
runAcc=1.25

chargeProg=0
chargeTime=65
chargeDelay=100

jeremyText="Basically it's just a really annoying tracking enemy. When you see it stop and aim its stinger at you, it's going to charge toward that point, stinger ready, at high speeds."
chaoText="This is from Mickey's Magical Quest. I like all the pretty colors in that game. Sooo colorful!"
devText="There are several large maps that circle around Central City that are set up as a huge connecting field that then branch off to their respective areas."
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
    chargeTime+=1
    if chargeProg=0 //Normal behavior
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      direction=player_sprite_center()
      speed=runAcc

      if chargeTime>=chargeDelay
      {
        findTargetX=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        if findTargetX<160
        {
          speed=0
          image_xscale=1
          image_angle=direction-225
          chargeTime=0
          chargeProg+=1
        }
      }
    }
    else if chargeProg=1 //Wait time
    {
      if chargeTime>=15
      {
        chargeTime=0
        chargeProg+=1
      }
    }
    else if chargeProg=2 //Charge sting
    {
      speed=runAcc*7.5
      if chargeTime>=25
      {
        image_angle=0
        chargeTime=0
        chargeProg=0
      }
    }
  }
  else {speed=0}
  enemyStepEvent()
}
else {speed=0}
