#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2
image_xscale=0.1; image_yscale=0.1
bCanDealDamage=0; bCanTakeDamage=0

//Enemy base statistics
eName="Rinka"
eLevel=23
maxLife=50
life=maxLife
atkPower=7
damageType="ELEMENTAL"
resType[0]=2
resType[1]=2
baseItemChance=70
pickupDropMod=70
moneyWorth=0
affiliation=5
bGenEnemy=1
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

initTime=0

jeremyText="You can see these grow from the generators. From there, it'll set its trajectory to your current point. Very simple."
chaoText="These are a security system for Mother Brain and will endlessly spawn as long as Mother Brain is active.##Their use seems to have a sort of stigma in Mario hacks."
devText="It was when I was coding these, that I finally got around to fixing up some bugs with the enemy drop mechanics and adding a new way for me to better control what an enemy will drop."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true
  {
    speed=3
  }
  else
  {
    initTime+=1
    if initTime>=1 and initTime<=9 {image_xscale+=0.1; image_yscale+=0.1}
    if initTime>=20
    {
      direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      bCanDealDamage=1; bCanTakeDamage=1
      bActive=true
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
