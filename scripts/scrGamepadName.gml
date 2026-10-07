/*
argument0: a gamepad code (see scrGamepadInit)
returns the name shown for it in the GAMEPAD list. Xbox letters for the face buttons, unless the pad is a PlayStation one.
*/
var c;
c=argument0
if c<=0 {return "-"}
if c<=4
{
  if global.gpPlayStation
  {
    if c=1 {return "CROSS"}
    if c=2 {return "CIRCLE"}
    if c=3 {return "SQUARE"}
    return "TRIANGLE"
  }
  if c=1 {return "A"}
  if c=2 {return "B"}
  if c=3 {return "X"}
  return "Y"
}
if c=5 {return "L1"}
if c=6 {return "R1"}
if c=7 {return "L2"}
if c=8 {return "R2"}
if c=9
{
  if global.gpPlayStation
  {
    if global.gpPS5 {return "CREATE"}
    return "SHARE"
  }
  return "BACK"
}
if c=10
{
  if global.gpPlayStation {return "OPTIONS"}
  return "START"
}
if c=11 {return "L3"}
if c=12 {return "R3"}
if c=13 {return "D-UP"}
if c=14 {return "D-DOWN"}
if c=15 {return "D-LEFT"}
if c=16 {return "D-RIGHT"}
if c=17 {return "LS-UP"}
if c=18 {return "LS-DOWN"}
if c=19 {return "LS-LEFT"}
if c=20 {return "LS-RIGHT"}
if c=21 {return "RS-UP"}
if c=22 {return "RS-DOWN"}
if c=23 {return "RS-LEFT"}
if c=24 {return "RS-RIGHT"}
if c>=100 and c<200 {return "B" +string(c-100)} //raw button
if c>=200 and c<232 //raw axis
{
  if (c mod 2)=0 {return "AXIS" +string((c-200) div 2) +"+"}
  return "AXIS" +string((c-200) div 2) +"-"
}
return "?"
