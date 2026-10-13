//Randomizer: in a randomizer game each key opens its own door (global.rndKeyOwn: the doors whose keys the player has
//found), so none is used up on another door; without its key the door says so, once a visit. Otherwise as the game's own
if global.rndActive=1
{
  if distance_to_object(oPlayer1)<12 and indexCheck="0"
  {
    if string_char_at(global.rndKeyOwn,objectNum)="1"
    {
      awardAwesome(200)
      global.pKeys=max(0,global.pKeys-1)
      playSound(global.snd_DoorUnlock,0,1,1)
      global.lockedDoor=rndSetChar(global.lockedDoor,objectNum,"1")
      indexCheck="1"
    }
    else if !variable_local_exists("rndTold")
    {
      rndTold=1
      rndMsg("Locked. This door's key is somewhere else.",1)
    }
  }
  if indexCheck="1" {instance_destroy()}
  exit
}
