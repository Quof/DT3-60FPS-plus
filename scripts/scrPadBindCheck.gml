///scrPadBindCheck(argument0)
var b,dz,pov;
b=global.padBind[argument0]
if b=-1 {return 0}
if !joystick_exists(global.padSlot) {return 0}
if b<=31 {return joystick_check_button(global.padSlot,b)}
if b>=101 and b<=104
{
  pov=joystick_pov(global.padSlot)
  if pov<0 {return 0}
  if b=101 {return (pov>=315 or pov<=45)}
  if b=102 {return (pov>=45 and pov<=135)}
  if b=103 {return (pov>=135 and pov<=225)}
  return (pov>=225 and pov<=315)
}
dz=global.optStickDeadZone
if b=111 {return joystick_xpos(global.padSlot)<-dz}
if b=112 {return joystick_xpos(global.padSlot)>dz}
if b=113 {return joystick_ypos(global.padSlot)<-dz}
if b=114 {return joystick_ypos(global.padSlot)>dz}
if b=115 {return joystick_upos(global.padSlot)>0.2}
return joystick_vpos(global.padSlot)>0.2
