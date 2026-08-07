///scrPadGetPressed()
var i,pov,dz;
if !joystick_exists(global.padSlot) {return -1}
for(i=0;i<=31;i+=1)
{
  if joystick_check_button(global.padSlot,i) {return i}
}
pov=joystick_pov(global.padSlot)
if pov>=0
{
  if pov>=315 or pov<45 {return 101}
  else if pov<135 {return 102}
  else if pov<225 {return 103}
  else {return 104}
}
dz=global.optStickDeadZone
if joystick_xpos(global.padSlot)<-dz {return 111}
if joystick_xpos(global.padSlot)>dz {return 112}
if joystick_ypos(global.padSlot)<-dz {return 113}
if joystick_ypos(global.padSlot)>dz {return 114}
if joystick_upos(global.padSlot)>0.2 {return 115}
if joystick_vpos(global.padSlot)>0.2 {return 116}
return -1
