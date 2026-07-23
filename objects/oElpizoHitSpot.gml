#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Elipzo"
eLevel=20
maxLife=5800
life=maxLife
atkPower=6
resType[0]=2
resType[1]=2
stunResist=50
bIsBoss=true
bNoBonus=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_xscale=oElpizo.image_xscale
  x=oElpizo.x
  y=oElpizo.y
  enemyStepEvent()
}
