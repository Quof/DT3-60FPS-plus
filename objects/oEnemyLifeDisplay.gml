#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
displayAlpha=1
displayFadeTime=80
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  if displayFadeTime<=0
  {
    displayAlpha-=0.04
    if displayAlpha<=0 {instance_destroy()}
  }
  else
    displayFadeTime-=1
  if instance_exists(eID)
  {
    displayIndX=view_xview[0]+476
    displayIndY=view_yview[0]+341
    draw_set_font(fnt_EnemyName)
    draw_set_halign(fa_right)
    draw_set_alpha(displayAlpha)
    if eID.life>0 {lifeTrack=(eID.life/eID.maxLife)*50}
    else {lifeTrack=0}
    //text
    textDropShadow(eID.eName,displayIndX+1,displayIndY-14,make_color_rgb(0,255,0),c_black,1)
    draw_set_font(fnt_EnemyChat)
    textDropShadow(eID.life,displayIndX-54,displayIndY-5,make_color_rgb(0,255,0),c_black,1)
    //life bar
    draw_sprite_ext(sEnemyLifeBar,0,displayIndX-52,displayIndY-1,1,1,0,c_white,displayAlpha)
    draw_sprite_ext(sEnemyLifeTrack,1,displayIndX-50,displayIndY+1,lifeTrack,1,0,c_white,displayAlpha)
    //stun bar
    stunTrack=0
    if eID.stunnedTime>0
    {
      stunTrack=eID.stunnedTime
      if stunTrack>50 {stunTrack=50}
    }
    draw_sprite_ext(sEnemyStunTrack,1,displayIndX-50,displayIndY+7,stunTrack,1,0,c_white,displayAlpha)
  }
  else {instance_destroy()}
}
