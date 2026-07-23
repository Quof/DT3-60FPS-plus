#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-26,-37,26,-1)
image_speed=0

//Enemy base statistics
eName="Sidehopper"
eLevel=25
maxLife=640
life=maxLife
pointWorth=39
atkPower=8
resType[0]=2
resType[1]=2
resType[3]=2
resType[5]=4
stunResist=9
baseItemChance=80
baseDropIndex=85
moneyWorth=10
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
weight=150

jumpTime=0
jumpCycle=0

jeremyText="These cycle through 2 different hops. One is a low hanging fast hop, the other is a slower high jump. There are other things that seem to alter their jump behavior, such as being in Morph Ball mode, so watch out if you're using that to evade."
chaoText="There have been various incarnations of these gone by different names. According to 'Metroid: Other M', they are an evolutionary line that goes something like; Sidehopper -> Dessgeega -> Baristute."
devText="This, and a later variant on it are what I consider the hardest standard enemies of the Gate. An encounter with 2 of them without missiles to easily dispatch them would definitely be a challenging one..."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("bStrong")
{
  sprite_index=sMetDessgeega
  eName="Dessgeega"
  eLevel=26
  maxLife=1180
  life=maxLife
  atkPower=9
  pointWorth=47
  resType[5]=3
  jeremyText=jeremyText +string("#This variant of the Sidehopper is more powerful and should only be found in Lower Norfair. Careful, when it lands, it creates fireballs from the ground.")
  devText="Like the Geega and Gamut, this is the same object as the standard Sidehopper. With these though, I simply tag the specific enemy spawn as stronger and it spawns the Dessgeega instead of a Sidehopper. In future projects, I'd go with separate objects since that's so much easier to manage, I find."
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
    jumpTime+=1
    if jumpTime=18 {image_index=1}
    else if jumpTime=25
    {
      image_index=1
      if sprite_index=sMetDessgeega
      {
        if checkScreenArea(x,y,48)=1 {playSound(global.snd_MetEnemyMove,0,0.97,17000)}
        resType[5]=4
      }
      else {if checkScreenArea(x,y,48)=1 {playSound(global.snd_MetEnemyMove,0,0.97,23000)}}
      y-=2
      if oPlayer1.attackState=oPlayer1.ACT_MORPHBALL //Really low very fast jump
      {
        yVel=-2.8
        if x>=oPlayer1.x {xVel=-10}
        else {xVel=10}
      }
      else
      {
        if jumpCycle=0 //Low fast jump
        {
          yVel=-5
          if x>=oPlayer1.x {xVel=-8}
          else {xVel=8}
          jumpCycle=1
        }
        else if jumpCycle=1 //Hi slow jump
        {
          yVel=-10
          if x>=oPlayer1.x {xVel=-4}
          else {xVel=4}
          jumpCycle=0
        }
      }
    }

    yVel+=0.4
    if isCollisionBottom(1)
    {
      if jumpTime>26
      {
        if sprite_index=sMetDessgeega
        {
          resType[5]=3
          var tAtk;
          tAtk=instance_create(x+22,y-8,oGravBulletAlt)
          tAtk.sprite_index=sDraculaFireball; tAtk.atkPower=atkPower; tAtk.image_speed=0.5
          tAtk.xVel=3.25; tAtk.yVel=-6; tAtk.xGrav=0; tAtk.yGrav=0.3; tAtk.bExplode=0
          tAtk=instance_create(x,y-8,oGravBulletAlt)
          tAtk.sprite_index=sDraculaFireball; tAtk.atkPower=atkPower; tAtk.image_speed=0.5
          tAtk.xVel=0; tAtk.yVel=-9; tAtk.xGrav=0; tAtk.yGrav=0.3; tAtk.bExplode=0
          tAtk=instance_create(x-22,y-8,oGravBulletAlt)
          tAtk.sprite_index=sDraculaFireball; tAtk.atkPower=atkPower; tAtk.image_speed=0.5
          tAtk.xVel=-3.25; tAtk.yVel=-6; tAtk.xGrav=0; tAtk.yGrav=0.3; tAtk.bExplode=0
        }
        jumpTime=0
      }
      xVel=0; yVel=0
      image_index=0
    }
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionTop(1)
      yVel=0.1

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
redDmgHit(0)
