#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_speed=0.25

//Enemy base statistics
eName="Latch Crystal"
maxLife=10000
life=maxLife
bCanDealDamage=false
bShowHealthBar=false
bShowDamagePopout=false
stunResist=50
bIsBoss=true
bNoBonus=true
for(i=0;i<6;i+=1)
{
  resType[i]=2
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  enemyStepEvent()
  life=maxLife
}
#define Collision_oLinkSWave
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Do nothing
