#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x=oPlayer1.x
y=oPlayer1.y
viewProg=0
viewOffsetX=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if viewProg=0
{
  if viewOffsetX<112 {viewOffsetX+=4}
}
else if viewProg=1
{
  viewOffsetX-=4
  if viewOffsetX<=0
  {
    view_object[0]=oPlayer1
    instance_destroy()
  }
}

x=oPlayer1.x+viewOffsetX
y=oPlayer1.y
