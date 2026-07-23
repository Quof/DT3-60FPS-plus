#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animPlayerExit=0
bOnMe=0
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bOnMe=0
#define Collision_oPlayerGameIcon
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Gate 6 world map exit script.
This will move the player to another room.
*/
if oPlayerGameIcon.bOnBird=0
{
  if bIsLocation=1 {bOnMe=1}
  else
  {
    if oPlayerGameIcon.sprite_index=sClaireGUp {bOnMe=1}
  }

  if oKeyCodes.kCodePressed[5]=1 and !instance_exists(oZeldaSaveMenu) and bIsLocation=1
  {
    resetKeyCodes()
    oPlayerGameIcon.bCanMove=0

    global.recAreaTrans+=1
    global.newMapX=newMapX
    global.newMapY=newMapY

    transition_steps=15
    transition_kind=5

    if variable_local_exists("newStep")
      transition_steps=newStep
    if variable_local_exists("newTrans")
      transition_kind=newTrans
    room_goto(toRoom)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bOnMe=1
{
  draw_set_font(fnt_NES)
  if x<=96 {draw_set_halign(fa_left)}
  else {draw_set_halign(fa_middle)}
  textDropShadow(mylocation,x+8,y-16,c_white,c_black,3)
}
