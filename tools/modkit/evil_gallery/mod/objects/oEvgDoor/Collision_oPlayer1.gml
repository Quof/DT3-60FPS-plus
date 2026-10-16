//Evil Boss Gallery: Up at the door: the boss's evil fight (oBossGalleryDoor's own start of a fight, to the evil room;
//global.evgFight says which, for the way back). A sealed door does nothing
if oKeyCodes.kCodePressed[3]=1 and activateTime=0 and global.gamePaused=false and evgRoom>=0
{
  event_user(0)
  global.bCanSave=0
  global.wpWaterLEntry=global.wpWaterLevel
  global.recAreaTrans+=1
  global.newMapX=newMapX; global.newMapY=newMapY
  global.gamePaused=false
  writeToPlayerGlobals()
  //(the gallery lever's normalized build, as oBossGalleryDoor has it: the fight's room is the evil one)
  if global.galleryNormalized=1
  {
    if global.normActive=0 {scrNormState(0)}
    global.normRoom=evgRoom
    scrNormApply(type)
    if global.normActive=1 and global.omenActive=1 {scrOmenState(5)}
  }
  if global.bNightmareMode=0 {global.difficulty=2}
  if global.rmDeaths>=5 {global.chaoRecognition=1}
  global.rmDeaths=0; global.hitsTaken=0
  global.evgFight=type
  transition_steps=10
  transition_kind=21
  room_goto_fixed(evgRoom)
}
