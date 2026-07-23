#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(0,0,sprite_width,sprite_height)
visible=0
bHit=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if isCollisionCharacterBottom(1,0) and bHit=false
{
  playSound(global.snd_ItemSprout,0,1,1)
  instance_create(x,y-2,oMario1up)
  awardAwesome(20)
  visible=1
  bHit=true
}
