#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
bShowHealthBar=false
bShowDamage=false
image_speed=0.5

//Enemy base statistics
eName="Elpizo Shield"
maxLife=300
life=maxLife
affiliation=4
bNoBonus=true
bIsBoss=true

decayTime=oElpizo.portalDecay
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    decayTime-=1
    if decayTime<=0 {instance_destroy()}
  }
  else
  {
    image_xscale-=0.1; image_yscale-=0.1
    if image_xscale<=0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0
{
  if oElpizo.timeMod=1 {oElpizo.specTime+=90}
  else {oElpizo.specTime+=60}
}
