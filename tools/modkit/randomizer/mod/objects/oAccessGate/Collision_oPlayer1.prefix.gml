//Randomizer (Chip Randomizer): a portal that takes a Program Chip the player hasn't found (rndPortalChip) can't be used:
//pressing Up at it only says which chip opens it, once while that message shows. Otherwise as the game's own
if global.rndActive=1 and global.rndChipMode=1
{
  var tChip,tShow;
  tChip=rndPortalChip()
  if tChip>0
  {
    if !rndChipHas(tChip)
    {
      if oKeyCodesHighFPS.kCodePressed[3]=1 and global.gamePaused=false
      {
        tShow=1
        if variable_local_exists("rndLockMsgId") {if instance_exists(rndLockMsgId) {tShow=0}}
        if tShow=1
        {
          rndMsg("Locked. This gate opens with#Program Chip "+string(tChip)+".",2)
          if variable_local_exists("newMessage") {rndLockMsgId=newMessage}
        }
      }
      exit
    }
  }
}
