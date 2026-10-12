#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bulletSpeed,decayTime
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
init=0
_speed=0
_direction=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0 {init=1}
  if decayTime!=-100
  {
    decayTime-=1*gDeltaTime
    if decayTime<=0 {instance_destroy()}
  }

  if place_meeting(x,y,oNightmareEffect) {_speed=bulletSpeed/2}
  else {_speed=bulletSpeed}
  image_angle=_direction
  //_speed=0
  //60fps change: removed the "_speed=0" above; it ran every step right before correctSpeedDirection, so red bullets never moved
}
else {_speed=0; _speed=0}
//correctSpeedDirection(self)
x+=cos(degtorad(_direction))*_speed*gDeltaTime; y-=sin(degtorad(_direction))*_speed*gDeltaTime //60fps change: the same move as
//correctSpeedDirection without the script call (Create sets both): hundreds of these can be out at once (e.g. Shadow Eura's
//blood volleys), and at 60/120fps the call's cost every frame for each of them lagged
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change (added): drawn directly. The inherited Draw (oDamagableBase) only checks findTargetX/Y, which a bullet
//never updates (always 0), then calls enemyDrawEvent to do this same draw_sprite_ext; skipping that per-bullet script call
draw_self()
