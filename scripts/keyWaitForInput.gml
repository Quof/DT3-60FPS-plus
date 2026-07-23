/*
-- keyWaitForInput() :No arguments needed
-- This makes the script wait for the next input command.
*/
if (oKeyCodes.kCodePressed[5]=1 or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) and bWaitForInput=true
{
  io_clear()
  resetKeyCodes()
  bWaitForInput=false
  with oMessageCutscene {instance_destroy()}
  sceneProgress+=1
}
