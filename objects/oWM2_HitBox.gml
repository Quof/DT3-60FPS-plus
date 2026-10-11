#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Warmaster II: an invisible damaging box (scrWM2_Hit). The 1x1 sprite is scaled to the box's size; x,y is its top left.
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2        //shields don't break it
hitTime=1     //ticks till it goes
owner=noone   //moves with this instance (Warmaster II moves it after his own move, so it never lags behind)
relX=0
relY=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if owner!=noone
  {
    if !instance_exists(owner) {instance_destroy(); exit}
  }
  hitTime-=1*gDeltaTime
  if hitTime<=0 {instance_destroy()}
}
