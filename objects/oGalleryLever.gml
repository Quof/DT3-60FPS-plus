#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
normalized gallery change (added): the boss gallery's lever, floating at waist height over the ledge left of the
entrance (made by rBossGallery's creation code, with the sign next to it). On (NORMALIZED mode): the boss doors put in the build one would have by that
boss (scrNormLoadout), fights are scored by hits taken (global.bossGalleryHitsN: the doors and the board show those),
and sword equipment comes off and stays off in the gallery (scrNormSwordsOff, scrNormSwordBlocked).
*/
image_speed=0
image_index=global.galleryNormalized
//image_index=1-global.galleryNormalized //normalized gallery change: handle up (frame 0) is on, down (frame 1) is off
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//oKeyCodesHighFPS: pressed for one frame at any frame rate (oKeyCodes' stays on until its next 30fps tick, so 2/4
//frames at 60/120fps, which would flip the lever back)
if oKeyCodesHighFPS.kCodePressed[3]=1 and global.gamePaused=false
{
  global.galleryNormalized=1-global.galleryNormalized
  image_index=global.galleryNormalized
  //image_index=1-global.galleryNormalized //normalized gallery change: up is on, down is off
  playSound(global.snd_RBSwitch,0,1,1)
  if global.galleryNormalized=1 {scrNormSwordsOff()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tLabelX;
draw_sprite(sprite_index,image_index,x,y)
if instance_exists(oPlayer1)
{
  //not while the sign's message is up (its box comes down over the label)
  if point_distance(x,y+8,oPlayer1.x,returnPlayerYCenter())<=64 and !instance_exists(oMessageSign)
  {
    draw_set_color(c_white)
    draw_set_alpha(1)
    draw_set_font(fnt_EnemyName)
    draw_set_halign(fa_center)
    //centered over the lever, kept on screen (the lever is near the left edge)
    tLabelX=max(x,view_xview[0]+string_width("NORMALIZED")/2+4)
    if global.galleryNormalized=1 {draw_text(tLabelX,y-30,"NORMALIZED#-ON-")}
    else {draw_text(tLabelX,y-30,"NORMALIZED#-OFF-")}
    draw_set_halign(fa_left)
  }
}
