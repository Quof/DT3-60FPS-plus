#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanTakeDamage=false
bCauseKnockback=false

//Enemy base statistics
eName="Hex Sapper"
maxLife=1000000
life=maxLife
atkPower=1
bIsBoss=true
bNoBonus=true

lifeDrain=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oPlayer1.x
  y=returnPlayerYCenter()
  lifeDrain+=1
  if global.difficulty=1
  {
    if lifeDrain mod 60=0 {bCanDealDamage=true}
  }
  else if global.difficulty=2
  {
    if lifeDrain mod 30=0 {bCanDealDamage=true}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true
{
  redDmgHit(0)
  bCanDealDamage=false
}
