#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
enemyProg=0
image_yscale=1.25
hoverAlpha=-1

//Enemy base statistics
eName="Malignant Ooze"
eLevel=33
maxLife=2800
life=maxLife
pointWorth=90
atkPower=9
resType[0]=5
resType[2]=4
resType[4]=2
stunResist=8
baseItemChance=85
baseDropIndex=90
moneyWorth=10
affiliation=8

jeremyText=""
chaoText=""
devText=""
extraInfo=""

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  bActive=myOwner.bActive
  x=myOwner.x
  if myOwner.sprite_index=sMO_CleaveReady or myOwner.sprite_index=sMO_Cleaver {y=myOwner.y-37}
  else if myOwner.sprite_index=sMO_Scream {y=myOwner.y-36}
  else {y=myOwner.y-70}
  if lifePercent<=0.5 and enemyProg=0
  {
    baseColor=make_color_rgb(255,200,200)
    resType[0]-=1
    resType[2]-=1
    image_blend=baseColor
    enemyProg=1
  }
  enemyStepEvent()
}
