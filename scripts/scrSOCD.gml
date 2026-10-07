/*
socd change (added): SOCD handling, last input priority (dipswitch socdLastInput, in Customize Remastered Changes).
SOCD = two opposite directions held at once (left and right, or up and down). With the dipswitch on, only the one
pressed last counts; the other takes over again if it's still held when that one is let go. If both were pressed at the
same time (between two checks), right wins, or up for up/down (global.socdTie). With it off, both count, as in the
original.
It works on the directions as the game sees them (scrDirHeld: keyboard and gamepad together), and only within a pair:
left/right never affects up/down.
Called by scrController for 1-4, on every check, so the press order stays up to date even with the dipswitch off. A
second check in the same frame finds nothing new.
argument0: 1 left, 2 right, 3 up, 4 down
returns 1 if that direction counts as held
*/
var tA,tB,tAxis,tHeldA,tHeldB,tNewA,tNewB;
if argument0<=2 {tA=1; tB=2; tAxis=0} //left/right
else {tA=3; tB=4; tAxis=1} //up/down
tHeldA=scrDirHeld(tA)
tHeldB=scrDirHeld(tB)

//a direction that wasn't held at the last check and is now has just been pressed
tNewA=(tHeldA and !global.socdHeld[tA])
tNewB=(tHeldB and !global.socdHeld[tB])
if tNewA and tNewB {global.socdLast[tAxis]=global.socdTie[tAxis]}
else if tNewA {global.socdLast[tAxis]=tA}
else if tNewB {global.socdLast[tAxis]=tB}
global.socdHeld[tA]=tHeldA
global.socdHeld[tB]=tHeldB

if global.socdLastInput=1 and tHeldA and tHeldB {return (argument0=global.socdLast[tAxis])}
if argument0=tA {return tHeldA}
return tHeldB
