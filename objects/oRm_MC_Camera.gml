#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
view_object[0]=id
timeCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if progress=0 //Decimator 10000
{
  x=oPlayer1.x
  y=oPlayer1.y
  if x>400 {x=400}
}
else if progress=1 //Between phase 1 and 2
{
  x=oPlayer1.x
  y=oPlayer1.y
}
else if progress=2 //Decimator 20000
{
  x=oPlayer1.x
  y=oPlayer1.y
  if x<816 {x=816}
}
else if progress=3 //Go to Deci20000
{
  oPlayer1.x=832; oPlayer1.y=320
  x=oPlayer1.x
  y=oPlayer1.y
  progress=2
}
