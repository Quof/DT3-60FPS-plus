#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animPlayerExit=0
#define Collision_oPlayerZeldaIcon
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Zelda world map exit script.
This will move the player to another room.
*/
oPlayerZeldaIcon.bCanMove=0
animPlayerExit+=1
if animPlayerExit>=5
{
  global.recAreaTrans+=1
  global.newMapX=newMapX
  global.newMapY=newMapY
  if variable_local_exists("newMapXUp") and oPlayerZeldaIcon.sprite_index=sJerryZUp
  {
    global.newMapX=newMapXUp
    global.newMapY=newMapYUp
  }
  else if variable_local_exists("newMapXDown") and oPlayerZeldaIcon.sprite_index=sJerryZDown
  {
    global.newMapX=newMapXDown
    global.newMapY=newMapYDown
  }
  else if variable_local_exists("newMapXLeft") and oPlayerZeldaIcon.sprite_index=sJerryZRight and oPlayerZeldaIcon.image_xscale=-1
  {
    global.newMapX=newMapXLeft
    global.newMapY=newMapYLeft
  }
  else if variable_local_exists("newMapXRight") and oPlayerZeldaIcon.sprite_index=sJerryZRight and oPlayerZeldaIcon.image_xscale=1
  {
    global.newMapX=newMapXRight
    global.newMapY=newMapYRight
  }

  transition_steps=15
  transition_kind=5

  if variable_local_exists("newStep")
    transition_steps=newStep
  if variable_local_exists("newTrans")
    transition_kind=newTrans
  room_goto(toRoom)
}
