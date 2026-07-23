#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: staticTime
playSound(global.snd_Static,0,0.95,1)
background_index[6]=backStatic
background_visible[6]=true
background_foreground[6]=true
background_hspeed[6]=31
background_vspeed[6]=21
background_alpha[6]=image_alpha
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
background_alpha[6]=image_alpha
staticTime-=1
if staticTime<=0
{
  background_visible[6]=false
  instance_destroy()
}
