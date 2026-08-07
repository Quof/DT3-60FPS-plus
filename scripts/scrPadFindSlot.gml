///scrPadFindSlot()
var i;
for(i=0;i<=3;i+=1)
{
  if joystick_exists(i) {return i}
}
return 0
