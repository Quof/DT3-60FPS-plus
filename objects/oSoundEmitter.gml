#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*Requires: emSnd_File,emSnd_Freq,emSnd_Range,emSnd_VolMin,emSnd_VolMax,emSnd_loopFrm
--Defaults--
emSnd_File=noone
emSnd_Freq=22050
emSnd_Range=256
emSnd_VolMin=8200
emSnd_VolMax=9200
emSnd_loopFrm=6
*/
loopTracking=0
brianChk=0
soundVolChk=0
soundAA=0
soundBB=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  loopTracking+=1
  if loopTracking>=emSnd_loopFrm
  {
    var tDistCheck;
    tDistCheck=point_distance(x,y,oPlayer1.x,returnPlayerYCenter())
    if tDistCheck<=emSnd_Range
    {
      var tVolToPlayAt,tAA,tBB;
      tAA=((emSnd_Range-tDistCheck)/emSnd_Range)+0.5
      tBB=mean(emSnd_VolMin,emSnd_VolMax)
      //tBB=emSnd_VolMax-(emSnd_VolMin/2)
      tVolToPlayAt=(tAA*tBB)/10000
      if tVolToPlayAt*10000>emSnd_VolMax {tVolToPlayAt=emSnd_VolMax/10000}
      else if tVolToPlayAt*10000<emSnd_VolMin {tVolToPlayAt=emSnd_VolMin/10000}

      soundVolChk=tVolToPlayAt //Delete later
      soundAA=tAA //Delete later
      soundBB=tBB //Delete later

      playSound(emSnd_File,0,tVolToPlayAt,emSnd_Freq)
    }
    loopTracking=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

draw_set_color(c_black)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_center)
draw_text(x,y-40,SS_GetSoundVol(emSnd_File))
draw_text(x,y-24,emSnd_File)

draw_text(x,y+24,string("AA: ") +string(soundAA))
draw_text(x,y+40,string("BB: ") +string(soundBB))
draw_text(x,y+56,string("Vol: ") +string(soundVolChk))
