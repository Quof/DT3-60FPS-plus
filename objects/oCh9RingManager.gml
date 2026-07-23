#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCollectedRings=0
resetTime=-1
ringColl=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck=string_char_at(global.apBoost,itemIndex)
if indexCheck="1"
{
  bCollectedRings=1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCollectedRings=0
  {
    if resetTime>-1
    {
      resetTime-=1
      if resetTime=0
      {
        ringColl=0
        oReachRing.image_index=0
        oReachRing.spinFrm=0
        oReachRing.bRunThrough=0
        oReachRing.image_blend=c_white
        resetTime=-1
      }
    }

    if ringColl=ringMax
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.1
      bCollectedRings=1
    }
  }
  else
  {
    with oReachRing {instance_destroy()}
    with doorID {instance_destroy()}
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ringColl>0
{
  draw_set_alpha(1)
  draw_set_font(fnt_HUDnum)
  draw_set_halign(fa_left)
  draw_sprite_ext(sReachRingRed,0,view_xview[0]+400,view_yview[0]+18,0.4,0.4,0,c_white,1)
  textDropShadow(string(ringColl) +string("/") +string(ringMax),view_xview[0]+410,view_yview[0]+9,c_white,c_black,1)
}
