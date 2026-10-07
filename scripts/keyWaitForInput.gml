/*
-- keyWaitForInput() :No arguments needed
-- This makes the script wait for the next input command.
*/
//if (oKeyCodes.kCodePressed[5]=1 or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) and bWaitForInput=true
if (oKeyCodes.kCodePressed[15]=1 or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) and bWaitForInput=true //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
{
  io_clear()
  scrKeyCarryClear() //key carry change (added): the left/right keys carried through a screen transition are cleared too
  resetKeyCodes()
  bWaitForInput=false
  with oMessageCutscene {instance_destroy()}
  sceneProgress+=1
}
