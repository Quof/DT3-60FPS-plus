/*
This script is called inside the character step event.
It is used when the player uses an ability.
argument0: Which ability is used
*/
var tSkillUse; tSkillUse=argument0

if tSkillUse=0 and attackState=0 // -------------------- LINK - SWORD --------------------
{
  var tSoundPlay; tSoundPlay=irandom(1)
  playSound(global.snd_PlayerAtk[tSoundPlay],0,1,1)
  var playerAttack;
  playerAttack=instance_create(x,y,oLinkSword)

  if global.bNightmareMode=1 and swordWaveCheck=0 and life=maxLife //Nightmare Only - Sword wave if at full health (Hold Down)
  {
    swordWaveCheck=100
    playerAttack=instance_create(x,y,oLinkSWave)
  }
  endAbilUse(ACT_ATK,atkSpdJerry,0,(4/atkSpdJerry)-0.02)
}
else if tSkillUse=1 and attackState=0 // -------------------- LINK - ARROW --------------------
{
  var playerAttack,tOffsetX,tOffsetY,tAtkDir,tAction;
  if kUp
  {
    tAction=ACT_FIRE_UP
    if image_xscale=1 {tAtkDir=40}
    else {tAtkDir=140}
    tOffsetY=-20
  }
  else if kDown
  {
    tAction=ACT_FIRE_DOWN
    if image_xscale=1 {tAtkDir=330}
    else {tAtkDir=210}
    tOffsetY=0
  }
  else
  {
    tAction=ACT_FIRE
    if image_xscale=1 {tAtkDir=10}
    else {tAtkDir=170}
    tOffsetY=0
  }
  if image_xscale=1 {tOffsetX=11}
  else {tOffsetX=-11}

  var tGoldenArrow;
  tGoldenArrow=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=30
    {
      tGoldenArrow=1
      break;
    }
  }

  playerAttack=instance_create(x+tOffsetX,y-30+tOffsetY,oLinkArrow)
  playerAttack.direction=tAtkDir
  if specAttackChargeA>=15
  {
    if specAttackChargeA>=30 {specAttackChargeA=30}
    playerAttack.attackCharge=specAttackChargeA
    playSound(global.snd_ArrowFling,0,1,22050+(specAttackChargeA*250))
  }
  else
  {
    playerAttack.attackCharge=0
    playSound(global.snd_ArrowFling,0,1,1)
  }
  if specAttackChargeA>=28 or tGoldenArrow=1 {playerAttack.bCanPierce=1}

  arrowRecharge-=10
  if busterLastShotTime<40 {arrowDelay+=2}
  busterLastShotTime=0
  global.hudLink_Arrows[0]-=1
  endAbilUse(tAction,5,1,0.5)
}
else if tSkillUse=2 and attackState=0 // -------------------- LINK - BOMB --------------------
{
  playSound(global.snd_LinkBomb,0,1,1)
  var playerAttack,tOffsetX,tOffsetY,tAtkVelY,tAction;
  if kUp
  {
    tAction=ACT_FIRE_UP
    tAtkVelY=-5.5
    tOffsetY=-22
  }
  else if kDown
  {
    tAction=ACT_FIRE_DOWN
    tAtkVelY=3.5
    tOffsetY=0
  }
  else
  {
    tAction=ACT_FIRE
    tAtkVelY=-2.5
    tOffsetY=0
  }
  if image_xscale=1 {tOffsetX=6}
  else {tOffsetX=-6}
  playerAttack=instance_create(x+tOffsetX,y-29+tOffsetY,oLinkBomb)
  playerAttack.yVel=tAtkVelY
  global.hudLink_BombEn[0]=0
  endAbilUse(tAction,5,1,-1)
}
else if tSkillUse=10 and attackState=0 // -------------------- MEGA MAN - X BUSTER --------------------
{
  busterAnimStay=15
  idleTime=0
  var playerAttack,tOffsetX,tYadjust,tBustDir;
  if bWallGrab=0
  {
    if mmState=BUSTER_STAND {tYadjust=32}
    else if mmState=BUSTER_DUCK {tYadjust=24}
    else if mmState=BUSTER_RUN {tYadjust=26}
    else if mmState=BUSTER_JUMP {tYadjust=32}
  }
  else
    tYadjust=37
  if image_xscale=1
  {
    if bWallGrab=0 {tOffsetX=12; tBustDir=0}
    else  {tOffsetX=-12; tBustDir=180}
  }
  else
  {
    if bWallGrab=0 {tOffsetX=-12; tBustDir=180}
    else {tOffsetX=12; tBustDir=0}
  }

  var tEnergyGem;
  tEnergyGem=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=29 //Equipment: Energy Gem
    {
      tEnergyGem=1
      break;
    }
  }

  if tEnergyGem=0
  {
    if global.bNightmareMode=0
    {
      if attackCharge>=0 and attackCharge<=chargeMax*0.339
      {
        if busterPCheck=1
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 1
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=1
          playerAttack.sprite_index=sMMXbuster1; playerAttack.exPwr=1
          playSound(global.snd_MMBuster[0],0,1,1)
        }
      }
      else if attackCharge>=chargeMax*0.34 and attackCharge<=chargeMax*0.99
      {
        playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 2
        playerAttack.direction=tBustDir
        if tBustDir=180 {playerAttack.image_xscale=-1}
        busterLastShotTime=0
        global.hudMega_BusterEn[0]-=2
        playerAttack.sprite_index=sMMXbuster2; playerAttack.exPwr=1.75
        playSound(global.snd_MMBuster[1],0,0.97,1)
      }
      else if attackCharge>=chargeMax
      {
        if global.hudMega_BusterEn[0]>=3
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 3
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=4
          playerAttack.sprite_index=sMMXbuster3; playerAttack.exPwr=2.85; playerAttack.bCanPierce=1
          playSound(global.snd_MMBuster[1],0,0.98,1)
        }
        else
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 2
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=2
          playerAttack.sprite_index=sMMXbuster2; playerAttack.exPwr=1.75
          playSound(global.snd_MMBuster[1],0,0.97,1)
        }
      }
    }
    else //Nightmare mode
    {
      nightmareOrb=0
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=9 //Equipment: Energy Orb
        {
          nightmareOrb=7
          break;
        }
      }

      if attackCharge>=0 and attackCharge<=19-(nightmareOrb-3)
      {
        if busterPCheck=1
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 1
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=1
          playerAttack.sprite_index=sMMXbuster1; playerAttack.exPwr=1
          playSound(global.snd_MMBuster[0],0,1,1)
          //----------------------------------------- Bullshit -----------------------------------------
          /*playSound(global.snd_MetMissile,0,1,1)
          playSound(global.snd_MorphBomb,0,1,1)
          playSound(global.snd_ArrowFling,0,1,1)
          playSound(global.snd_LinkBomb,0,1,1)
          playerAttack=instance_create(x+tOffsetX,y-30,oLinkArrow)
          playerAttack.direction=tBustDir; playerAttack.attackCharge=0
          playerAttack=instance_create(x+tOffsetX,y-29,oLinkBomb)
          playerAttack.yVel=-1-random(4)
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXshotgunIceA)
          playerAttack.direction=tBustDir
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXgravityWell)
          playerAttack.direction=tBustDir
          for(i=0;i<8;i+=1)
          {
            playerAttack=instance_create(x+(tOffsetX*image_xscale),y-tYadjust,oSamusCannon)
            playerAttack.direction=i*45; playerAttack.exPwr=1
          }
          playerAttack=instance_create(x+(tOffsetX*image_xscale),y-tYadjust,oSamusMissile)
          playerAttack.direction=tBustDir; playerAttack.sprite_index=sSamusSuperMissile; playerAttack.exPwr=2
          var playerAttack;
          playerAttack=instance_create(x,y-8,oSamusBomb)
          playerAttack.bombType=1; playerAttack.bounces=1
          playerAttack=instance_create(x,y-8,oSamusBomb)
          playerAttack.bombType=1; playerAttack.bounces=2
          playerAttack.xVel=1; playerAttack.yVel=4
          playerAttack=instance_create(x,y-8,oSamusBomb)
          playerAttack.bombType=1; playerAttack.bounces=2
          playerAttack.xVel=-1; playerAttack.yVel=4
          playerAttack=instance_create(x,y-8,oSamusBomb)
          playerAttack.bombType=1; playerAttack.bounces=3
          playerAttack.xVel=2.25; playerAttack.yVel=2
          playerAttack=instance_create(x,y-8,oSamusBomb)
          playerAttack.bombType=1; playerAttack.bounces=3
          playerAttack.xVel=-2.25; playerAttack.yVel=2*/
          //--------------------------------------------------------------------------------------------
        }
      }
      else if attackCharge>=15-(nightmareOrb-3) and attackCharge<=39-nightmareOrb
      {
        playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 2
        playerAttack.direction=tBustDir
        if tBustDir=180 {playerAttack.image_xscale=-1}
        busterLastShotTime=0
        global.hudMega_BusterEn[0]-=2
        playerAttack.sprite_index=sMMXbuster2; playerAttack.exPwr=1.75
        playSound(global.snd_MMBuster[1],0,0.97,1)
      }
      else if attackCharge>=40-nightmareOrb //and attackCharge<=64
      {
        if global.hudMega_BusterEn[0]>=3
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 3
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=4
          playerAttack.sprite_index=sMMXbuster3; playerAttack.exPwr=2.85; playerAttack.bCanPierce=1
          playSound(global.snd_MMBuster[1],0,0.98,1)
        }
        else
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 2
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=2
          playerAttack.sprite_index=sMMXbuster2; playerAttack.exPwr=1.75
          playSound(global.snd_MMBuster[1],0,0.97,1)
        }
      }
      /*else if attackCharge>=65
      {
        if global.hudMega_BusterEn[0]>=7
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 4
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=7
          playerAttack.sprite_index=sMMXbuster4; playerAttack.exPwr=4.5; playerAttack.bCanPierce=1
          playSound(global.snd_MMBuster[1],0,0.98,1)
        }
        else if global.hudMega_BusterEn[0]>=3 and global.hudMega_BusterEn[0]<=6
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 3
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=4
          playerAttack.sprite_index=sMMXbuster3; playerAttack.exPwr=2.85; playerAttack.bCanPierce=1
          playSound(global.snd_MMBuster[1],0,0.98,1)
        }
        else
        {
          playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 2
          playerAttack.direction=tBustDir
          if tBustDir=180 {playerAttack.image_xscale=-1}
          busterLastShotTime=0
          global.hudMega_BusterEn[0]-=2
          playerAttack.sprite_index=sMMXbuster2; playerAttack.exPwr=1.75
          playSound(global.snd_MMBuster[1],0,0.97,1)
        }
      }*/
      if chargeShotsStored>0 {chargeShotsStored-=1}
      attackCharge=0
    }
  }
  else //If Energy Gem is on
  {
    playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXbuster) //Level 2
    playerAttack.direction=tBustDir
    if tBustDir=180 {playerAttack.image_xscale=-1}
    busterLastShotTime=0
    global.hudMega_BusterEn[0]-=3
    playerAttack.sprite_index=sMMXbuster2; playerAttack.exPwr=1.75
    playSound(global.snd_MMBuster[1],0,0.97,1)
  }
}
else if tSkillUse=11 and attackState=0 // -------------------- MEGA MAN - SHOTGUN ICE --------------------
{
  busterAnimStay=15
  idleTime=0
  var playerAttack,tYadjust,tOffsetX,tIceDir;
  if bWallGrab=0
  {
    if mmState=BUSTER_STAND {tYadjust=32}
    else if mmState=BUSTER_DUCK {tYadjust=24}
    else if mmState=BUSTER_RUN {tYadjust=26}
    else if mmState=BUSTER_JUMP {tYadjust=32}
  }
  else
    tYadjust=37
  if image_xscale=1
  {
    if bWallGrab=0 {tOffsetX=12; tIceDir=0}
    else  {tOffsetX=-12; tIceDir=180}
  }
  else
  {
    if bWallGrab=0 {tOffsetX=-12; tIceDir=180}
    else {tOffsetX=12; tIceDir=0}
  }

  var tHeadpieceA;
  tHeadpieceA=6
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=35 //Equipment: X's Headpiece
    {
      tHeadpieceA=3
      break;
    }
  }
  
  if specAttackChargeA>=0 and specAttackChargeA<=54-(global.skillTree[6]*5)-equipValA
  {
    playSound(global.snd_IceGunShot,0,0.97,1)
    busterLastShotTime=0
    global.hudMega_ShotIceEn[0]-=2
    playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXshotgunIceA)
    playerAttack.direction=tIceDir
    if tIceDir=180 {playerAttack.image_xscale=-1}
  }
  else if specAttackChargeA>=55-(global.skillTree[6]*5)-equipValA
  {
    if global.hudMega_ShotIceEn[0]>=tHeadpieceA
    {
      playSound(global.snd_IceGunShot,0,1,16000)
      busterLastShotTime=0
      global.hudMega_ShotIceEn[0]-=tHeadpieceA
      playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXshotgunIceChargeA)
    }
    else
    {
      playSound(global.snd_IceGunShot,0,0.97,1)
      busterLastShotTime=0
      global.hudMega_ShotIceEn[0]-=2
      playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXshotgunIceA)
      playerAttack.direction=tIceDir
      if tIceDir=180 {playerAttack.image_xscale=-1}
    }
  }
}
else if tSkillUse=12 and attackState=0 // -------------------- MEGA MAN - GRAVITY WELL --------------------
{
  busterAnimStay=15
  idleTime=0
  var playerAttack,tYadjust,tOffsetX,tGrDir;
  if bWallGrab=0
  {
    if mmState=BUSTER_STAND {tYadjust=32}
    else if mmState=BUSTER_DUCK {tYadjust=24}
    else if mmState=BUSTER_RUN {tYadjust=26}
    else if mmState=BUSTER_JUMP {tYadjust=32}
  }
  else {tYadjust=37}
  
  if image_xscale=1
  {
    if bWallGrab=0 {tOffsetX=12; tGrDir=0}
    else  {tOffsetX=-12; tGrDir=180}
  }
  else
  {
    if bWallGrab=0 {tOffsetX=-12; tGrDir=180}
    else {tOffsetX=12; tGrDir=0}
  }
  
  var tGravityDisp,tButtShit;
  tGravityDisp=1; tButtShit=12
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=35 //Equipment: X's Headpiece
    {
      tButtShit=6
      break;
    }
  }
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=40 //Equipment: Gravity Displacer
    {
      tGravityDisp=1.25
      break;
    }
  }

  if specAttackChargeB>=0 and specAttackChargeB<=54-(global.skillTree[6]*5)-equipValA
  {
    playSound(global.snd_GravityShot,0,0.95,1)
    busterLastShotTime=0
    global.hudMega_GravityEn[0]-=3
    playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXgravityWell)
    playerAttack.direction=tGrDir
    if tGrDir=180 {playerAttack.image_xscale=-1}
  }
  else if specAttackChargeB>=55-(global.skillTree[6]*5)-equipValA
  {
    if global.hudMega_GravityEn[0]>=round(tButtShit*tGravityDisp)
    {
      playSound(global.snd_GravityShot,0,1,16000)
      busterLastShotTime=0
      global.hudMega_GravityEn[0]-=round(tButtShit*tGravityDisp)
      playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXgravityWellChargeA)
      playerAttack.direction=140; playerAttack.type=1
      playerAttack.xOffset=-50; playerAttack.yOffset=-60
      if tGravityDisp=1.25 {playerAttack.bAiming=1}
      else {playerAttack.bAiming=0}
    }
    else
    {
      playSound(global.snd_GravityShot,0,0.95,1)
      busterLastShotTime=0
      global.hudMega_GravityEn[0]-=3
      playerAttack=instance_create(x+tOffsetX,y-tYadjust,oMMXgravityWell)
      playerAttack.direction=tGrDir
      if tGrDir=180 {playerAttack.image_xscale=-1}
    }
  }
}
else if tSkillUse=13 and attackState=0 // -------------------- MEGA MAN - STRIKE CHAIN --------------------
{
  busterAnimStay=15
  grappleState=1
  playSound(global.snd_MMDoorOpen,0,0.97,33000)
  idleTime=0
  var playerAttack;
  playerAttack=instance_create(x,y,oMMXstrikeChain)
}
else if tSkillUse=20 and attackState=0 // -------------------- GAME - SPAM GUN --------------------
{
  playSound(global.snd_SpamShot,0,1,20000+random(4000))
  var playerAttack,tEffect;
  playerAttack=instance_create(x+(29*image_xscale),y-32,oJCGameSBullet)
  equipValA=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=21 //Equipment: Wind Orb
    {
      equipValA=1
      break;
    }
  }
  global.hudGame_WeaponEn[0]-=7-global.skillTree[8]-equipValA
  tEffect=instance_create(x+(29*image_xscale),y-32,oEffect); tEffect.image_xscale=image_xscale
  tEffect.sprite_index=sJCGameMuzzleFlash; tEffect.followID=oPlayer1; tEffect.xFollow=29*image_xscale; tEffect.yFollow=-32
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  endAbilUse(ACT_FIRE,4,1,-1)
}
else if tSkillUse=21 and attackState=0 // -------------------- GAME - BIRD SWARM --------------------
{
  playSound(global.snd_PlayerAtk[0],0,1,1)
  var playerAttack;
  playerAttack=instance_create(x,view_yview[0]+16,oJCGameBirdSwarm)
  equipValA=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=22 //Equipment: Zephyr Amulet
    {
      equipValA=32
      break;
    }
  }
  global.hudGame_WeaponEn[0]-=(96-round(96*(global.skillTree[10]*0.03)))-equipValA
  endAbilUse(ACT_BIRD_CALL,10,1,0.4)
}
else if tSkillUse=30 and attackState=0 // -------------------- BELMONT - HAIR WHIP --------------------
{
  var tSoundPlay; tSoundPlay=irandom(1)
  playSound(global.snd_PlayerAtk[tSoundPlay],0,1,1)
  var playerAttack;
  playerAttack=instance_create(x,y,oBelmontWhip)
  endAbilUse(ACT_ATK,atkSpdClaire,0,8/atkSpdClaire)
}
else if tSkillUse=31 and attackState=0 // -------------------- BELMONT - DAGGER --------------------
{
  playSound(global.snd_PlayerAtk[3],0,0.9,1)
  var tMysticDagger;
  tMysticDagger=1
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=38 //Equipment: Mystic Dagger
    {
      tMysticDagger=1.2
      break;
    }
  }
  var playerAttack;
  playerAttack=instance_create(x,y-28,oBelmontDagger)
  playerAttack.bulletSpeed=15
  if tMysticDagger=1.2 {playerAttack.bBounce=1}
  else {playerAttack.bBounce=0}

  if daggerSpamCheck>=12 and daggerSpamCheck<=20
  {
    daggerSpamCheck=100
    for(i=0;i<4;i+=1)
    {
      playerAttack=instance_create(x,y-28,oBelDagNightmareExt)
      playerAttack.bulletSpeed=13-(i*2)
      if tMysticDagger=1.2 {playerAttack.bBounce=1}
      else {playerAttack.bBounce=0}
    }
  }
  busterLastShotTime=0

  if global.bNightmareMode=0 {global.hudBelmont_WeaponEn[0]-=round((8-global.skillTree[3])*tMysticDagger)}
  else //Nightmare mode only
  {
    if daggerSpamCheck=100 {global.hudBelmont_WeaponEn[0]-=global.nightmareDagger}
    else {global.hudBelmont_WeaponEn[0]-=round((8-global.skillTree[3])*tMysticDagger)}
  }
  if daggerSpamCheck<=40 {daggerSpamCheck=0}
  endAbilUse(ACT_FIRE,5,1,-1)
}
else if tSkillUse=32 and attackState=0 // -------------------- BELMONT - HOLY WATER --------------------
{
  playSound(global.snd_HolyWaterThrow,0,0.92,1)
  var tBlessedVessel;
  tBlessedVessel=1
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=39 //Equipment: Blessed Vessel
    {
      tBlessedVessel=1.2
      break;
    }
  }
  var playerAttack;
  playerAttack=instance_create(x,y-22,oBelmontHolyWater)
  if tBlessedVessel=1.2 {playerAttack.bTrail=1}
  else {playerAttack.bTrail=0}
  busterLastShotTime=0

  global.hudBelmont_WeaponEn[0]-=round((12-global.skillTree[4])*tBlessedVessel)
  endAbilUse(ACT_FIRE,5,1,0.5)
}
else if tSkillUse=40 and attackState=0 // -------------------- SAMUS - CANNON --------------------
{
  var playerAttack,tXadjust,tYadjust,tDir;
  tXadjust=10; tYadjust=29; tDir=0

  idleTime=0
  if mmState=BUSTER_STAND
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=14; tYadjust=29
  }
  else if mmState=BUSTER_STAND_UP
  {
    tDir=90
    tXadjust=6; tYadjust=42
  }
  else if mmState=BUSTER_RUN
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=12; tYadjust=23
  }
  else if mmState=BUSTER_RUN_UP
  {
    tDir=90
    tXadjust=3; tYadjust=32
  }
  else if mmState=BUSTER_JUMP
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=14; tYadjust=23
  }
  else if mmState=BUSTER_JUMP_UP
  {
    tDir=90
    tXadjust=8; tYadjust=33
  }
  else if mmState=BUSTER_JUMP_DOWN
  {
    tDir=270
    tXadjust=10; tYadjust=11
  }
  else if mmState=BUSTER_DUCK
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=13; tYadjust=16
  }

  var tPlasma;
  tPlasma=1
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=37 //Equipment: Plasma Canister
    {
      tPlasma=1.1
      break;
    }
  }

  if mmState=BUSTER_STAND_UP or mmState=BUSTER_RUN_UP or mmState=BUSTER_JUMP_UP or mmState=BUSTER_JUMP_DOWN //Check if near walls
  {
    if (isCollisionLeft(8) and image_xscale=-1) or (isCollisionRight(8) and image_xscale=1) {tXadjust=0}
  }

  if attackCharge>=0 and attackCharge<=24
  {
    if busterPCheck=0
    {
      playerAttack=instance_create(x+(tXadjust*image_xscale),y-tYadjust,oSamusCannon)
      playerAttack.direction=tDir; playerAttack.exPwr=1
      if global.hasAbilToken[4]>=6
      {
        playSound(global.snd_MetShotB,0,1,1)
        playerAttack.sprite_index=sSamusSpazer
      }
      else {playSound(global.snd_MetShotA,0,1,1)}
      if tPlasma=1.1 {playerAttack.bCanPierce=1}
      busterAnimStay=15
      busterLastShotTime=0
      global.hudSamus_CannonEn[0]+=round(30-(global.skillTree[29]*3))*tPlasma
    }
  }
  else if attackCharge>=25 //Charged shot
  {
    playerAttack=instance_create(x+(tXadjust*image_xscale),y-tYadjust,oSamusCannon)
    if global.hasAbilToken[4]>=6
    {
      playSound(global.snd_MetShotB,0,1,1)
      playerAttack.sprite_index=sSamusChargeSpazer
    }
    else
    {
      playSound(global.snd_MetShotA,0,1,1)
      playerAttack.sprite_index=sSamusChargeCannon
    }
    playerAttack.direction=tDir; playerAttack.exPwr=0.65; playerAttack.bCanPierce=1
    busterAnimStay=15
    busterLastShotTime=0
    global.hudSamus_CannonEn[0]+=round(90-(global.skillTree[29]*12))*tPlasma
  }
}
else if tSkillUse=41 and attackState=0 // -------------------- SAMUS - MISSILE --------------------
{
  specialLastShotTime=0
  busterAnimStay=15
  idleTime=0
  var playerAttack,tXadjust,tYadjust,tDir;
  tXadjust=10; tYadjust=29; tDir=0
  if mmState=BUSTER_STAND
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=14; tYadjust=29
  }
  else if mmState=BUSTER_STAND_UP
  {
    tDir=90
    tXadjust=6; tYadjust=42
  }
  else if mmState=BUSTER_RUN
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=12; tYadjust=23
  }
  else if mmState=BUSTER_RUN_UP
  {
    tDir=90
    tXadjust=3; tYadjust=32
  }
  else if mmState=BUSTER_JUMP
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=14; tYadjust=23
  }
  else if mmState=BUSTER_JUMP_UP
  {
    tDir=90
    tXadjust=8; tYadjust=33
  }
  else if mmState=BUSTER_JUMP_DOWN
  {
    tDir=270
    tXadjust=10; tYadjust=11
  }
  else if mmState=BUSTER_DUCK
  {
    if image_xscale=1 {tDir=0} else {tDir=180}
    tXadjust=13; tYadjust=16
  }

  if mmState=BUSTER_STAND_UP or mmState=BUSTER_RUN_UP or mmState=BUSTER_JUMP_UP or mmState=BUSTER_JUMP_DOWN //Check if near walls
  {
    if (isCollisionLeft(4) and image_xscale=-1) or (isCollisionRight(4) and image_xscale=1) {tXadjust=0}
  }

  var tRailGun;
  tRailGun=0
  if global.hasAbilToken[4]>=8
  {
    for(i=0;i<3;i+=1)
    {
      if global.equipClaire[i]=34 //Equipment: Rail Gun
      {
        tRailGun=1
        break;
      }
    }
  }

  if tRailGun=0
  {
    equipValA=0
    for(i=0;i<3;i+=1)
    {
      if global.equipClaire[i]=19 //Equipment: Blast Cannon
      {
        equipValA=14
        break;
      }
    }

    if busterLastShotTime<40 {missileDelay+=2}
    busterLastShotTime=0
    playerAttack=instance_create(x+(tXadjust*image_xscale),y-tYadjust,oSamusMissile)
    playerAttack.direction=tDir
    if specAttackChargeA>=55-(global.skillTree[7]*6)-equipValA and global.hudSamus_Missiles[0]>=3
    {
      playSound(global.snd_MetMissile,0,1,1)
      missileRecharge-=25
      missileDelay+=3
      global.hudSamus_Missiles[0]-=3
      playerAttack.sprite_index=sSamusSuperMissile; playerAttack.exPwr=2
    }
    else
    {
      playSound(global.snd_MetMissile,0,1,1)
      missileRecharge-=10
      global.hudSamus_Missiles[0]-=1
      playerAttack.sprite_index=sSamusMissile; playerAttack.exPwr=1
    }
  }
  else
  {
    if global.hudSamus_Missiles[0]>=5
    {
      playSound(global.snd_MetMissile,0,1,1)
      if busterLastShotTime<40 {missileDelay+=5}
      busterLastShotTime=0
      missileRecharge-=25
      missileDelay+=3
      global.hudSamus_Missiles[0]-=5
      playerAttack=instance_create(x+(tXadjust*image_xscale),y-tYadjust,oSamusMissile)
      playerAttack.direction=tDir
      playerAttack.sprite_index=sSamusSuperMissile; playerAttack.exPwr=2
    }
  }
}
else if tSkillUse=42 and attackState=ACT_MORPHBALL // -------------------- SAMUS - BOMB --------------------
{
  playSound(global.snd_MorphBomb,0,1,1)
  idleTime=0
  var playerAttack;
  playerAttack=instance_create(x,y-8,oSamusBomb)
  playerAttack.bombType=0
  global.hudSamus_Bombs[0]+=1
}
else if tSkillUse=50 // -------------------- GAME - BLADE STRIKE --------------------
{
  if attackState=0 or attackState=ACT_BLOCK
  {
    playSound(global.snd_BladeStrike,0,1,20000+random(4000))
    var playerAttack;
    playerAttack=instance_create(x,y,oJCGameBladeStrike)
    equipValA=0
    for(i=0;i<3;i+=1)
    {
      if global.equipClaire[i]=23 //Equipment: Razor Blade
      {
        equipValA=1
        break;
      }
    }
    global.hudGame_WeaponEn[0]-=12-global.skillTree[11]-equipValA
    endAbilUse(ACT_ATK,atkSpdClaire-1,0,5.5/atkSpdClaire)
  }
}
else if tSkillUse=51 and attackState=0 // -------------------- GAME - CHAINBLADE STRIKE --------------------
{
  playSound(global.snd_PlayerAtk[0],0,1,1)
  var playerAttack;
  playerAttack=instance_create(x,y,oJCGameChainSpawn)
  equipValA=0
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=24 //Equipment: Magic Urn
    {
      equipValA=32
      break;
    }
  }
  global.hudGame_WeaponEn[0]-=(96-round(96*(global.skillTree[13]*0.03)))-equipValA
  endAbilUse(ACT_FIRE,4,1,-1)
}
else if tSkillUse=52 and attackState=0 // -------------------- GAME - DRAGON SHIELD --------------------
{
  playSound(global.snd_PlayerAtk[0],0,1,1)
  var playerAttack,tDir;
  tDir=0
  for(i=0;i<24;i+=1)
  {
    playerAttack=instance_create(x+(18*image_xscale),y-8,oJCGameFlameShield)
    playerAttack.shieldDir=tDir
    if i=0 {playerAttack.sprite_index=sJCGameDragonHead}
    tDir+=360/26
  }
  global.hudGame_WeaponEn[0]-=50-round(50*(global.skillTree[12]*0.03))
  endAbilUse(ACT_FIRE,4,1,-1)
}
