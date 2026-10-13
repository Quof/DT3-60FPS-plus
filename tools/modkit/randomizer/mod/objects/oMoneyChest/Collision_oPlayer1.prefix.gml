//Randomizer: in a randomizer game, opening the chest gives its location's item (on any difficulty: a chest is a location
//like any other). Otherwise as the game's own
if global.rndActive=1
{
  if oKeyCodes.kCodePressed[3]=1 and indexCheck="0" and global.gamePaused=false and variable_local_exists("rndLoc")
  {
    if image_yscale>=1
    {
      playSound(global.snd_ChestOpen,0,1,1)
      rndCollect(rndLoc)
      indexCheck="1"
      image_index=1
      specialChest=0
      //----- SPECIAL MAP SCENARIOS -----
      if room=rMain_25ExtA {(GID(210894)).spinning=1}
    }
    else if image_yscale=-1 //Forest Temple upside-down chest
    {
      msgCreate(170,100,"","You can't open a chest that is upside-down... which is weird.",6,1,oMessagePerson,1)
      newMessage.fadingTime=80
    }
  }
  exit
}
