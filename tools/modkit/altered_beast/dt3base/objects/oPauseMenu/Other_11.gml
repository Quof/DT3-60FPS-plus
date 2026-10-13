///CONFIRMATION MENU
//Confirmation menu for 'Reverting to previous save' and 'Return to title screen'
if confirmationMenu>0
{
  if oKeyCodes.kCodePressed[3]=1
  {
    if confirmMenuPos=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=0
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    if confirmMenuPos=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=1
    }
  }

  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    if confirmMenuPos=0
    {
      if confirmationMenu=1 //Load
      {
        global.gamePaused=false
        initGameVars()
        loadSaveData()
        global.resetMusic=true
        room_goto(roomToPlace)
      }
      else if confirmationMenu=2 //Title Screen
      {
        playSound(global.snd_MenuCancel,0,1,1)
        room_goto(rTitle)
      }
    }
    else if confirmMenuPos=1
    {
      confirmMenuPos=0
      confirmationMenu=0
      io_clear()
      scrKeyCarryClear() //key carry change (added): the left/right keys carried through a screen transition are cleared too
      resetKeyCodes()
    }
  }
  //else if oKeyCodes.kCodePressed[6]=1
  else if oKeyCodes.kCodePressed[16]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    confirmMenuPos=0
    confirmationMenu=0
    io_clear()
    scrKeyCarryClear() //key carry change (added): the left/right keys carried through a screen transition are cleared too
    resetKeyCodes()
  }
}
