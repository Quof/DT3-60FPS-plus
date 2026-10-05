#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Sword Projectile Wave
event_inherited()
image_speed=0
image_yscale=1.5

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  var tA;
  if warTarget.DIFFICULTY=1 {tA=-0.1} else {tA=-0.2}
  if gDeltaTime!=1 {moveSpd=scrTickAcc(moveSpd,tA,0)} //moves (copies the speed) first, then changes it: above 30fps the tick's change is spread before the move (scrTickAcc, scrTickAccBPre)
  _speed=moveSpd+scrTickAccBPre(0)
  if gDeltaTime==1 {moveSpd+=tA}
  image_alpha-=0.075*gDeltaTime
  if image_alpha<=0.3 {bCanDealDamage=0}
  if image_alpha<=0 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
