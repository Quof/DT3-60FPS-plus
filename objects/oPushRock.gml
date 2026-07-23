#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
maxThres=12
spriteUse=0
if variable_local_exists("spriteChange")
{
  if spriteChange=1
    sprite_index=sPushBlock
  else if spriteChange=2
    sprite_index=sG6_EarthBlock
  else if spriteChange=3
    sprite_index=sHPF_Block
}

setCollisionBounds(2,0,sprite_width-2,sprite_height-1)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if !isCollisionWaterBottom(-4) {maxThres=12}
  else {maxThres=6}

  if yVel>maxThres {yVel=maxThres}

  if y>room_height+24 {instance_destroy()}
}
