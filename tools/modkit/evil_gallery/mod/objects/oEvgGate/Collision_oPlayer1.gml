//Evil Boss Gallery: Up at the gate: to the other gallery, in front of its gate (the same place there)
if oKeyCodes.kCodePressed[3]=1 and activateTime=0 and global.gamePaused=false
{
  global.evgFight=0
  global.recAreaTrans+=1
  global.newMapX=x+8; global.newMapY=y+32
  writeToPlayerGlobals()
  playSound(global.snd_PortalCreate,0,0.9,1)
  transition_steps=10
  transition_kind=21
  room_goto_fixed(toGallery)
}
