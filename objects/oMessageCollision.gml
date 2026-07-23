#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
collisionTest=0
checkX=0
checkY=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if collisionTest=0 //Make sure the player is not under the text box
{
  if wSize=0
  {
    checkX=139
    checkY=28
  }
  else if wSize=1
  {
    checkX=199
    checkY=41
  }
  else if wSize=2
  {
    checkX=259
    checkY=54
  }
  else if wSize=3
  {
    checkX=319
    checkY=67
  }
  image_xscale=checkX; image_yscale=checkY
  if !collision_rectangle(x-1,y-1,x+checkX+1,y+checkY+1,oPlayer1,0,1)
  {
    sprite_index=sScaledCollision
    collisionTest=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if collisionTest=1
  showMessage(x,y,message,talker,wColor,image_alpha,wSize)
