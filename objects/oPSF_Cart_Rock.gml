#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=2
image_yscale=2
rockProg=0
warnTime=60

symbolBeep=1
warnSymbol=1
rockSpd=10

bumpProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if rockProg=0
  {
    symbolBeep+=1
    if symbolBeep mod 4=0
    {
      if warnSymbol=0 {warnSymbol=1}
      else {warnSymbol=0}
    }

    warnTime-=1
    if warnTime=0
    {
      warnSymbol=0
      rockProg=1
    }
  }
  else if rockProg=1
  {
    warnTime+=1
    if warnTime>=5
    {
      x-=rockSpd

      if bumpProg=0 and x<=384
      {
        playSound(global.snd_MarioCannon,0,0.94,31000)
        playSound(global.snd_LampOn,0,1,13000)
        (465774).jumpProg=1;
        bumpProg=1
      }
      else if bumpProg=1 and x<=192
      {
        playSound(global.snd_MarioCannon,0,0.94,31000)
        playSound(global.snd_LampOn,0,1,13000)
        (465773).jumpProg=1;
        bumpProg=2
      }
      if x<=-16
      {
        instance_destroy()
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sWarningSymbol,0,440,288,0.55,0.55,0,c_white,warnSymbol)

draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_white,1)
