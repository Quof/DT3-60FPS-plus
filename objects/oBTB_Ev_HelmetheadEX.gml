#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_black

roomShake=0

if global.bossTrack=0
{
  sceneDelay=650
  global.gamePaused=true
  fadeAlpha=1
}
else
{
  fadeAlpha=0
  if global.BTB_HelmetHead=1 {instance_create(304,304,oHelmetHeadFakeEX)}
  else {instance_create(304,304,oHelmetHeadEX)}
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rBT_HelmetheadEX //----- [] Boss Fight: Helmethead EX ----- [1]
{
  if global.bossTrack=0
  {
    if roomShake=1
    {
      var tEffect;
      tEffect=instance_create(48+random(384),80,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=23
      tEffect.image_speed=0.2; tEffect.fadeSpd=0.075; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0

      tEffect=instance_create(48+random(384),80,oEffectGrav)
      tEffect.type=2; tEffect.sprite_index=sSE_RockFall; tEffect.newBlend=-1; tEffect.depth=23
      tEffect.fadeSpd=0.04; tEffect.image_xscale=0.25+random(0.4); tEffect.image_yscale=0.25+random(0.4)
      tEffect.xSpd=0; tEffect.ySpd=1+random(3); tEffect.followID=-1; tEffect.rotation=0; tEffect.grav=0.2
    }

    if sceneProgress=0
    {
      if sceneDelay>=50
      {
        fadeAlpha-=0.01
        if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=45
      {
        var tempMplay;
        tempMplay=findMusic(827)
        playMusic(tempMplay,0,0)
        roomShake=1
      }
      else if sceneDelay=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=50
      {
        msgCreate(0,0,"?????","Oh how I have waited for this moment.",8,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if sceneDelay=160
      {
        msgCreate(0,0,"?????","For MY moment to rise!",8,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=250
      {
        msgCreate(0,0,"?????","I could hear them. I could hear them all!",8,1,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if sceneDelay=370
      {
        msgCreate(0,0,"?????","I could hear your voice too. Even you beckoned for me.",8,1,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay=510
      {
        msgCreate(0,0,"?????","It's time we do this once more to settle this once and for all.",8,1,oMessagePerson,0)
        newMessage.fadingTime=150
      }
      else if sceneDelay>=680 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      var tBossTitle,tempMplay;
      tBossTitle=instance_create(0,0,oBossNameDisplay)
      tBossTitle.bossName="Helmethead EX"
      tBossTitle.bossTitle="The Meme Lives On"
      tempMplay=findMusic(802)
      playMusic(tempMplay,0,0)
      boss=instance_create(304,304,oHelmetHeadEX)
      global.currentBoss="Helmethead EX"
      global.bossTrack=1
      storeStatus(0)
      global.gamePaused=false
      sceneProgress=0
    }
  }
  else if global.bossTrack=1
  {
    if sceneProgress=1 //End Boss
    {
      var tempMplay;
      tempMplay=findMusic(204)
      playMusic(tempMplay,0,0)
      sceneProgress=0
      global.currentBoss=""
      global.bossTrack=0
    }
  }
}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 and global.gamePaused=true //Cutscene skip
{
  if !instance_exists(oPauseMenu)
  {
    if global.bossTrack=0 and room=rBT_HelmetheadEX //[1]
    {
      bWaitForInput=false
      with oEffect {instance_destroy()}
      with oMisc {instance_destroy()}
      with oMessageCutscene {instance_destroy()}
      fadeAlpha=0
      sceneDelay=0; sceneProgress=3
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
