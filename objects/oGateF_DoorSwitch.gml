#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
activated=0
flashColor=0
myDoor=instance_create(x+32,y,oDummyPlat)
myDoor.sprite_index=sGateF_SteelDoor; myDoor.depth=11
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activated=1 //Door goes up
  {
    myDoor.yVel=-4
    if myDoor.y<=myDoor.ystart-64
    {
      flashColor=0
      myDoor.yVel=0; activated=10
    }
  }
  else if activated=11 //Door goes down
  {
    myDoor.yVel=4
    if myDoor.y>=myDoor.ystart
    {
      flashColor=0
      myDoor.yVel=0; activated=0
    }
  }

  if flashColor>=1 and flashColor<=8 //Flash light
  {
    flashColor+=1
    if flashColor mod 2=0
    {
      if image_blend=c_white {image_blend=c_green}
      else {image_blend=c_white}
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (activated=0 or activated=10) and other.bCanHitSwitch=1 and other.weaponTag<100
{
  playSound(global.snd_SwitchHit,0,0.85,34000)
  flashColor=1
  activated+=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,image_index,x,y)
draw_sprite_part_ext(sprite_index,image_index,2,7,10,9,x+2,y+7,1,1,image_blend,1)
