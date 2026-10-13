/*
Boss Gallery Door script
*/
if oKeyCodes.kCodePressed[3]=1 and activateTime=0 and global.gamePaused=false
{
  event_user(0)
  if global.inBossChallenge
    {
        global.Cousinoer5HUBX = oPlayer1.x
        global.Cousinoer5HUBY = oPlayer1.y
        global.Cousinoer5ReturnRoom = room
    }
  global.bCanSave=0
  global.wpWaterLEntry=global.wpWaterLevel
  global.recAreaTrans+=1
  global.newMapX=newMapX; global.newMapY=newMapY
  global.gamePaused=false
  writeToPlayerGlobals()
  //normalized gallery change (added): with the gallery lever (oGalleryLever) on, the fight uses this boss's normalized
  //build (scrNormLoadout); the real one is kept aside and put back in rBossGallery's creation code
  if global.galleryNormalized=1
  {
    if global.normActive=0 {scrNormState(0)}
    global.normRoom=toRoom //the fight's room (oGame's Room Start puts the real build back anywhere else)
    scrNormApply(type)
    //dark omen change (added): with the New Dark Omen on, the normalized build's skill tree is lowered the same way
    //(scrOmenState); the build kept aside has the lowered one too, so it's what comes back after the fight
    if global.normActive=1 and global.omenActive=1 {scrOmenState(5)}
  }
  if global.bNightmareMode=0 {global.difficulty=2}
  if global.rmDeaths>=5 {global.chaoRecognition=1}
  global.rmDeaths=0; global.hitsTaken=0
  transition_steps=10
  transition_kind=21
  room_goto_fixed(toRoom)
}
