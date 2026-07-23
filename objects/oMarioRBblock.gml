#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(0,0,sprite_width,sprite_height)
moveAnim=0
reHitTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveAnim>=1 and moveAnim<=4
{
  moveAnim+=1
  if moveAnim=2
    y-=2
  else if moveAnim=4
    y+=2
}

if global.gamePaused=false
{
  if reHitTime>0
    reHitTime-=1
  if isCollisionCharacterBottom(1,0) and reHitTime=0
  {
    if global.hasAbilToken[0]>=2 {instance_create(x,y-8,oAtkBumpBlock)}
    playSound(global.snd_RBSwitch,0,1,1)
    if global.rbSwitchBlueOn=false
      global.rbSwitchBlueOn=true
    else
      global.rbSwitchBlueOn=false
    with oMarioRBblock
      reHitTime=10
    moveAnim=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,global.rbSwitchBlueOn,x,y)
