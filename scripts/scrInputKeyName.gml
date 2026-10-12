/*
input text change (added): the keyboard name of an input (scrInputCode's codes): the key it's set to in Options > Control
(J, Space...), the arrow key's name for [Left]/[Right]/[Up]/[Down], or the text itself for [Arrow Keys]/[WASD].
argument0: input code
*/
var c,k;
c=argument0
if c=1 {return "Left"}
if c=2 {return "Right"}
if c=3 {return "Up"}
if c=4 {return "Down"}
if c=117 {return "Arrow Keys"}
if c=118 {return "WASD"}
k=""
if c=5 {k=global.ctrlJump}
else if c=6 {k=global.ctrlActA}
else if c=7 {k=global.ctrlActB}
else if c=8 {k=global.ctrlActC}
else if c=9 {k=global.ctrlCharSwap}
else if c=10 {k=global.ctrlAbilSwap}
else if c=11 {k=global.ctrlSkip}
else if c=12 {k=global.ctrlPause}
else if c=13 {k=global.ctrlDashLeft}
else if c=14 {k=global.ctrlDashRight}
else if c=15 {k=global.ctrlConfirm}
else if c=16 {k=global.ctrlCancel}
else if c=101 {k=global.ctrlLeft}
else if c=102 {k=global.ctrlRight}
else if c=103 {k=global.ctrlUp}
else if c=104 {k=global.ctrlDown}
k=string_upper(string(k))
if k=" " {k="Space"}
return k
