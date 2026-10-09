#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//jukebox change (added): the music room's jukebox (rBT_MusicRoom), drawn with the vending machine's sprite. Pressing Up
//at it opens its track list (oJukeboxMenu)
showMyText=0
helpTextInner=make_color_rgb(219,192,235)
helpTextOuter=make_color_rgb(28,16,3)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33 //the vending machine's blink (0.33 a frame at 30fps), at any frame rate
if global.gamePaused=false
{
  if showMyText>0 {showMyText-=1*gDeltaTime}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMyText=2
if global.gamePaused=false and oKeyCodes.kCodePressed[3]=1
{
  resetKeyCodes()
  playSound(global.snd_MenuConfirm,0,1,1)
  instance_create(0,0,oJukeboxMenu)
  global.gamePaused=true
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if showMyText>0 and !instance_exists(oJukeboxMenu)
{
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_middle)
  textDropShadow("JUKEBOX#PRESS UP TO PICK A SONG",x,y-92,helpTextInner,helpTextOuter,4)
  draw_set_halign(fa_left)
}
