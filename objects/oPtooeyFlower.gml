#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-18,12,-1)
image_speed=0
animSpd=0.08

//Enemy base statistics
eName="Ptooey Flower"
eLevel=34
maxLife=450
life=maxLife
pointWorth=74
atkPower=10
resType[1]=1
resType[2]=4
resType[3]=2
resType[5]=2
stunResist=10
baseItemChance=60
moneyWorth=5

enemyProg=0
if x>oPlayer1.x {throwDir=-1}
else {throwDir=1}
bThrow=0
throwNum=0

jeremyText="This flower just sits there all day shooting out seeds. If you deal any damage to it, it'll fire one off at you. Dropping it below 50% HP will cause its fire rate to increase by quite a bit."
chaoText="Oooh, I get the name now! That one slipped by me at first."
devText="I like the idea of this area being more friendly looking. The tone of the game has shifted quite a bit at this point, but I wanted to have some down time from that."

if global.gameProgress=4940 {instance_destroy()}
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
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    //Fire at player
    image_index+=animSpd
    if image_index>=1 and bThrow=0
    {
      var tThrowPwr;
      if point_distance(x,0,oPlayer1.x,0)<88 {tThrowPwr=2}
      else {tThrowPwr=5}
      var tNewAttack;
      tNewAttack=instance_create(x,y-20,oGravityBullet)
      tNewAttack.sprite_index=sPtooeySeed; tNewAttack.atkPower=atkPower; tNewAttack.grav=0.3
      tNewAttack.xVel=tThrowPwr*throwDir; tNewAttack.yVel=-7
      throwDir*=-1
      throwNum+=1
      if throwNum=3
      {
        tNewAttack=instance_create(x,y-20,oGravityBullet)
        tNewAttack.sprite_index=sPtooeySeed; tNewAttack.atkPower=atkPower; tNewAttack.grav=0.3
        tNewAttack.xVel=tThrowPwr*throwDir; tNewAttack.yVel=-7
        throwNum=0
      }
      bThrow=1
    }
    else if image_index<1 and bThrow=1
    {
      bThrow=0
    }

    yVel+=0.2
    if isCollisionBottom(1)
    {
      yVel=0
    }
    moveTo(xVel,yVel)
  }
  if lifePercent<=0.5 and enemyProg=0
  {
    animSpd=0.13
    enemyProg=1
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewAttack;
tNewAttack=instance_create(x,y-15,oPassBullet)
tNewAttack.sprite_index=sPtooeySeed; tNewAttack.atkPower=atkPower
tNewAttack.bulletSpeed=4; tNewAttack.decayTime=90
tNewAttack.direction=point_direction(x,y-15,oPlayer1.x,returnPlayerYCenter())
