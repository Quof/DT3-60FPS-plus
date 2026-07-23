#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.2
  if isCollisionBottom(1)
    yVel=0
  if yVel>12
    yVel=12
  if y>room_height+24
    instance_destroy()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="NORMAL" and other.weaponTag<100
{
  awardAwesome(10)
  for(i=0;i<4;i+=1)
  {
    newEffect=instance_create(x+8,y+8,oEfMarioBlock)
    newEffect.type=i
  }
  if variable_local_exists("altItem")
  {
    if altItem=1 //Chicken
    {
      var tHeart;
      tHeart=instance_create(x+8,y+8,oHealthPickup)
      tHeart.sprite_index=sCVChicken
    }
  }
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
  draw_background_part(tileCastlevaniaA,64,48,16,16,x,y)
else if type=2
  draw_background_part(tileCastlevaniaA,0,96,16,16,x,y)
