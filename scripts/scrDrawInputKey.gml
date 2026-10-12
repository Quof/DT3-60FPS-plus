/*
input text change (added): one input on its own, centered on x: its gamepad button's icon while the gamepad is in use,
or the key it's set to, with a drop shadow (e.g. the scan window's key list).
argument0: input code (scrInputCode)
argument1: x
argument2: y
argument3: text color
argument4: shadow color
argument5: type of drop shadow (as textDropShadow)
*/
if global.gpLastUsed=1
{
  draw_sprite_ext(sKeyPressPad,scrInputPadFrame(argument0),argument1,argument2+floor(string_height("M")/2),1,1,0,c_white,draw_get_alpha())
  exit
}
textDropShadow(scrInputKeyName(argument0),argument1,argument2,argument3,argument4,argument5)
