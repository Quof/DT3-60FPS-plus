#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.3

//Enemy base statistics
eName="Winged Melon"
eLevel=30
maxLife=200
life=maxLife
pointWorth=15
atkPower=9
baseItemChance=50
stunResist=50
affiliation=1

initDir=0
runAcc=1.5

jeremyText="It's a... flying watermelon... and labelled under Mario? Oh hey, didn't Mario Sunshine have some watermelon thing? Oh geez, I don't remember."
chaoText="This sprite was made by a turnip named Rena (aka Tavi). Huh, didn't know turnips had names."
devText="No Dev Commentary at this time."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true and stunnedTime=0
  {
    if initDir=false
    {
      if x>oPlayer1.x {runAcc*=-1}
      initDir=true
    }

    if runAcc>0 {image_xscale=1}
    else {image_xscale=-1}

    x+=runAcc
  }
  enemyStepEvent()
}
