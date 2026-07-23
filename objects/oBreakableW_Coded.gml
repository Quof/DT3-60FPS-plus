#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
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
draw_background_part(bwBack,bwLeft,bwTop,bwWidth,bwHeight,x,y)
