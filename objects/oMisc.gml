#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=2 //Scene Player Character
{
  //Check animation
  if animCheck>0
  {
    if image_index>=lastFrame
    {
      sprite_index=spriteEnd
      image_index=frameEnd
      image_speed=animEnd
      animCheck=0
    }
  }
}
else if type=3 //Pulled into Vault
{
  image_alpha-=0.001*gDeltaTime
  image_angle+=turnSpd*gDeltaTime
  //moves with GM's built-in speed (set by oEvCh9MainA), which is applied in full every frame: take back the excess above 30fps
  x+=hspeed*(gDeltaTime-1); y+=vspeed*(gDeltaTime-1)
}
else if type=4 //Float up and down
{
  moveStep+=0.05*gDeltaTime
  y+=sin(moveStep)*gDeltaTime
}
