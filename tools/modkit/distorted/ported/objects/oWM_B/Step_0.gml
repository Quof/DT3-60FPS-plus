if global.gamePaused=false
{
  if warmasterCheck=6
  {
    global.currentBoss=""
    global.newMapX=624; global.newMapY=272; room_goto(rCCity_SGrove)
  }
  //sceneTime+=1
  sceneTime+=1*gDeltaTime //60fps change: per frame
  if sceneProgress=0
  {
    var fourM;
    fourM=instance_create(240,288,oCHAOS_Warmaster_Fixed)
    fourM=instance_create(480,288,oCHAOS_Warmaster_Fixed)
    sceneTime=0; sceneProgress+=1
  }
  else if sceneProgress=1 and warmasterCheck=2
  {
    oPlayer1.dashRecovery+=6
    with oTrapBase {instance_destroy()}
    with oEProjectileBase {instance_destroy()}
    with oAttackBase {instance_destroy()}
    with oWarmasterB_MoltenRock {instance_destroy()}
    var fourM;
    fourM=delaySpawn(112,288,oCHAOS_Warmaster_Fixed,0,0,1,0.33)
    fourM=delaySpawn(608,288,oCHAOS_Warmaster_Fixed,0,0,1,0.33)
    sceneTime=0; sceneProgress+=1
  }
  else if sceneProgress=2 and warmasterCheck=4
  {
    oPlayer1.dashRecovery+=6
    with oTrapBase {instance_destroy()}
    with oEProjectileBase {instance_destroy()}
    with oAttackBase {instance_destroy()}
    with oWarmasterB_MoltenRock {instance_destroy()}
    var fourM;
    fourM=delaySpawn(200,288,oCHAOS_Warmaster_Fixed,0,0,1,0.33)
    fourM=delaySpawn(500,288,oCHAOS_Warmaster_Fixed,0,0,1,0.33)
    sceneTime=0; sceneProgress+=1
  }
  /*else if sceneProgress=3 and warmasterCheck=6
  {
    oPlayer1.dashRecovery+=6
    with oTrapBase {instance_destroy()}
    with oEProjectileBase {instance_destroy()}
    with oAttackBase {instance_destroy()}
    with oWarmasterB_MoltenRock {instance_destroy()}
    var fourM;
    fourM=delaySpawn(240,288,oCHAOS_Warmaster_Fixed,0,0,1,0.33)
    fourM=delaySpawn(608,288,oCHAOS_Warmaster_Fixed,0,0,1,0.33)
    sceneTime=0; sceneProgress+=1
  }*/
}
