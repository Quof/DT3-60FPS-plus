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
size=2
init=0
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

  _speed=bulletSpeed
  image_angle=_direction
}
else {_speed=0}

//correctSpeedDirection(self)
x+=cos(degtorad(_direction))*_speed*gDeltaTime; y-=sin(degtorad(_direction))*_speed*gDeltaTime //60fps change: the same move as
//correctSpeedDirection without the script call (oDamagableBase's Create sets both): Hex's desperation attack has a few
//hundred of these out at once, and at 60/120fps the call's cost every frame for each of them lagged
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
//never updates (always 0), and then does this same draw_sprite_ext
draw_self()
