#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: maxDoor, targetDoor[]
image_speed=0
bColliding=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if collision_rectangle(x,y,x+16,y+16,oPlayer1,1,1)
  bColliding=1
else if collision_rectangle(x,y,x+16,y+16,oPlayerIdle,1,1)
  bColliding=1
else
  bColliding=0

if bColliding=1
{
  for(i=0;i<maxDoor;i+=1)
  {
    targetDoor[i].mask_index=sBarrierCRev
    targetDoor[i].image_alpha=1
  }
}
else
{
  for(i=0;i<maxDoor;i+=1)
  {
    targetDoor[i].mask_index=sNull
    targetDoor[i].image_alpha=0.25
  }
}
