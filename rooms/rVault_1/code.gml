locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15} //Allow teleport after Vault chapter is done

if global.gameProgress<=2240 {charSwitcher(1)} //Force to Claire before Jerry is awake
else {instance_create(224,288,oHealingPost)}
global.partySplit=1

gameScene=instance_create(0,0,oEvCh10MainA)
mapScene=instance_create(0,0,oEvCh10SideA)
instance_create(0,0,oVaultVisualControl)

if global.gameProgress=2235 {global.gameProgress=2240} //Coming back after getting Megaphone

if global.gameProgress>=2550 //Spawn warp gates after Vault chapter is done
{
  var newExit;
  newExit=instance_create(248,80,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=240; newExit.newMapY=4016; newExit.toRoom=rVault_6

  newExit=instance_create(320,80,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=608; newExit.newMapY=304; newExit.toRoom=rVault_13

  newExit=instance_create(392,80,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false; newExit.exitType=0
  newExit.newMapX=160; newExit.newMapY=256; newExit.toRoom=rVault_16
}

if global.gameProgress>=2170 //After first cutscene
{
  if global.gameProgress>=2240 and global.gameProgress<=2400
  {
    oIdentifier.bCanScan=0; oIdentifier.deactivate=1
  }
  else if global.gameProgress<=2230
  {
    oIdentifier.followTarget=oPlayerIdle; oIdentifier.willFollowMouse=0; oIdentifier.bCanScan=0
    oIdentifier.x=oPlayerIdle.x+16; oIdentifier.y=oPlayerIdle.y-32
  }
  var tempMplay;
  tempMplay=findMusic(11)
  playMusic(tempMplay,0,0)
}
