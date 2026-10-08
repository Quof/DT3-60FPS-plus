/*
controls change (added): 1 when two actions (kCode numbers, as in scrController) can't be on the same gamepad button,
because both would act at once: two of the game's actions (1-10, 13, 14) or Pause/Cutscene Skip (11, 12); Confirm and
Cancel (15, 16); or Confirm/Cancel and Pause/Cutscene Skip. Confirm/Cancel can share a button with a game action (by
default Confirm is A, like Jump, and Cancel is B, like Action C): menus don't run the game's actions.
argument0, argument1: the two actions
*/
var tMenuA,tMenuB;
tMenuA=(argument0=15 or argument0=16)
tMenuB=(argument1=15 or argument1=16)
if tMenuA and tMenuB {return 1}
if !tMenuA and !tMenuB {return 1}
if tMenuA and (argument1=11 or argument1=12) {return 1}
if tMenuB and (argument0=11 or argument0=12) {return 1}
return 0
