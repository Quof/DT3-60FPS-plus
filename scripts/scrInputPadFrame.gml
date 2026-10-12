/*
input text change (added): the sKeyPressPad frame for an input (scrInputCode's codes) with the gamepad in use: the icon of
the button it's set to (scrPadIcon); the left stick for [Arrow Keys], the d-pad for [WASD].
argument0: input code
*/
var c;
c=argument0
if c>=201 {c-=200}
else if c>=101 and c<=104 {c-=100}
if c=117 {return scrPadIcon(17)}
if c=118 {return scrPadIcon(13)}
return scrPadIcon(global.gpBind[c])
