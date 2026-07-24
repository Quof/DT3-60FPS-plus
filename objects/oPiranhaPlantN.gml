#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
bCanTakeDamage=0
bCanDealDamage=0
image_speed=0.15
y+=32
hidingY=y

//Enemy base statistics
eName="Piranha Plant"
eLevel=3
maxLife=140
life=maxLife
pointWorth=5
atkPower=4
resType[0]=4
resType[2]=5
resType[3]=1
baseItemChance=50
affiliation=1

atkProg=0

jeremyText="These damn things... There are different types of Piranha Plants, this is the most basic of them. It only goes into and out of pipes. That's all there is to say about this thing."
chaoText="Petey Piranha was such a cool Piranha Plant. I wish he would show up. Oh! If he does, do you think he'll be on our side?!"
devText="The first map of Gate 1 was set up to only resemble elements of Mario 1-1. Not that I felt it was silly to do yet another replica of that level, but I just wanted to put my own ideas into it. There's a spot where you can chain jump for a good portion of the map."
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
    if y>=hidingY
    {
      bCanTakeDamage=0
      bCanDealDamage=0
    }
    else
    {
      bCanTakeDamage=1
      bCanDealDamage=1
    }

    if atkProg<=66 {atkProg+=1*gDeltaTime}
    else
    {
      findTargetX=point_distance(oPlayer1.x,0,x,0)
      if findTargetX>=36 {atkProg+=1*gDeltaTime}
    }

    if atkProg>=11 and atkProg<=26 {y-=2*gDeltaTime}
    else if atkProg>=51 and atkProg<=66 {y+=2*gDeltaTime}
    else if atkProg=115 {atkProg=0}
  }
  enemyStepEvent()
}
