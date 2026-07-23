#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var myAtkTrap;
myAtkTrap=instance_create(x,y,oCh19AtkTraps)
myAtkTrap.damageType="PIERCE"
myAtkTrap.sprite_index=sprite_index
myAtkTrap.type=1
myAtkTrap.image_xscale=image_xscale
myAtkTrap.myTrap=id
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<image_xscale;i+=1)
{
  draw_sprite(sprite_index,0,x+(i*16),y)
}
