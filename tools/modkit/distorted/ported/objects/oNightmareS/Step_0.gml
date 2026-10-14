if global.gamePaused=false
{
  if bClouds=1
  {
    cloudSpawn+=1*gDeltaTime
    if cloudSpawn=250
    {
      instance_create(view_xview[0]+view_wview[0]+4,view_yview[0]+random_range(8,96),oBkgCloud)
      cloudSpawn=irandom(50)
    }
  }

  if room=rExtGateS_1 //Lakitu spawn
  {
    if sceneProgress=0 and oPlayer1.x>=3000
    {
        var eBarrier;
        eBarrier=instance_create(2960,0,oEnemyBarrier); eBarrier.image_yscale=22
        eBarrier=instance_create(3376,0,oEnemyBarrier); eBarrier.image_yscale=22
        sceneProgress+=1
    }
    else if sceneProgress=1 and !instance_exists(oFireBro)
    {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress+=1
    }
  }
  else if room=rExtGateS_2
  {
    if oPlayer1.x>=8*16 and bWallSpawn=0
    {
      var tNewWall;
      tNewWall=instance_create(-32,0,oAdvancingDeathWall)
      tNewWall.type=0; tNewWall.xSpd=1; tNewWall.xThres=32
      bWallSpawn=1
    }
  }
  else if room=rExtGateB_1 //spsp ns
  {
    if sceneProgress=0 and !instance_exists(oEnemyBase)
    {
        with oEventBarrier {instance_destroy()}
        sceneProgress+=1
    }
  }
  else if room=rExtGateG_2 //Map display and slimes spawning in
  {
    //if scrController(4) {mapTime+=1}
    if scrController(4) {mapTime+=1*gDeltaTime} //60fps change: per frame (as DT3+'s oEvExGates)
    else {mapTime=0}

    //if instance_number(oPT_Slime)<8 {slimeTime+=1}
    if instance_number(oPT_Slime)<8 {slimeTime+=1*gDeltaTime} //60fps change: per frame (as DT3+'s oEvExGates)
    if slimeTime>=300 and false       //spsp
    {
      global.tempAction[0]=64
      var tRanNum,tXX,tYY;
      tRanNum=choose(0,1,2)
      if tRanNum=0 {tXX=720; tYY=432}
      else if tRanNum=1 {tXX=528; tYY=768}
      else if tRanNum=2 {tXX=1712; tYY=416}
      delaySpawn(240,96,oPT_Slime,0,1,0,0.1)
      slimeTime=0
    }
  }
  else if room=rExtGateG_3
  {
    global.hudGame_WeaponEn[0]=34
  }
}
else if room=rExtGateF_3 //----- [] Advancing fire wall of doom -----
{
  if oPlayer1.x>=960 and bWallSpawn=0
  {
    var tFlash,tNewWall;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    background_blend[0]=make_color_rgb(210,200,200)
    tNewWall=instance_create(752,0,oAdvancingDeathWall)
    tNewWall.type=1
    tNewWall.xSpd=2
    tNewWall.xThres=16
    bWallSpawn=1
  }
}

keyWaitForInput()
if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if room=rExtGateA_6 //[A]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=9
      }
    }
    else if room=rExtGateB_6 //[B]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=14
      }
    }
    else if room=rExtGateC_5 //[C]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        sceneDelay=0; sceneProgress=5
      }
    }
    else if room=rExtGateD_6 //[D]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oMisc {instance_destroy()}
        oPlayer1.x=352; oPlayer1.y=416
        sceneDelay=0; sceneProgress=8
      }
    }
    else if room=rExtGateE_5 //[E]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        with oMisc {instance_destroy()}
        oPlayer1.x=272; oPlayer1.y=304
        sceneDelay=0; sceneProgress=6
      }
    }
    else if room=rExtGateF_6 //[F]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        oPlayer1.x=160; oPlayer1.y=432
        sceneDelay=0; sceneProgress=3
      }
    }
    else if room=rExtGateG_4 //[G]
    {
      if global.bossTrack=0
      {
        bWaitForInput=false
        with oMessageCutscene {instance_destroy()}
        oPlayer1.x=288; oPlayer1.y=288
        sceneDelay=0; sceneProgress=6
      }
    }
  }
}

//Map Events
if room=rExtGateE_1 //Slightly faster Dash Energy recovery
{
  if global.gamePaused=false
  {
    if oPlayer1.dashEnergy<oPlayer1.dashMeterMax-3*gDeltaTime {oPlayer1.dashEnergy+=3*gDeltaTime}
  }
}
else if room=rExtGateB_6 //Subtle background color change
{
  bgSeq+=1*gDeltaTime
  if bgSeq>=1 and bgSeq<=60 {bgCol+=0.1*gDeltaTime}
  else if bgSeq>=61 and bgSeq<=120
  {
    bgCol-=0.1*gDeltaTime
    if bgSeq=120 {bgSeq=0}
  }
  background_color=make_color_rgb(bgCol,bgCol,bgCol)
}
