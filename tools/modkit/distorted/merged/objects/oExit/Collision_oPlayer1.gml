/*
Exit script.
This will move the player to another room.
exitType relates to whether the player has to press a key to activate the event. (Set in creation code.)
0: Player must press up. Use for doors.
1: Player must walk into the exit.
2: Player must press down. Use for pipes.
*/
if exitType=0 //Press Up
{
  if oKeyCodesHighFPS.kCodePressed[3]=1 and global.gamePaused=false
  {
    if room=rMain_45 and global.gameProgress=2600 //Barrens - Twin Rocks puzzle
    {
      if global.tempAction[0]=0 and desertDir=1 {global.tempAction[0]+=1}
      else if global.tempAction[0]=1 and desertDir=4 {global.tempAction[0]+=1}
      else if global.tempAction[0]=2 and desertDir=2 {global.tempAction[0]+=1}
      else if global.tempAction[0]=3 and desertDir=3 {global.tempAction[0]+=1}
      else if global.tempAction[0]=4 and desertDir=1 {global.tempAction[0]+=1}
      else if global.tempAction[0]=5 and desertDir=3 {global.tempAction[0]+=1}
      else if global.tempAction[0]=6 and desertDir=2 {global.tempAction[0]+=1}
      else if global.tempAction[0]=7 and desertDir=4 {global.tempAction[0]+=1}
      else if global.tempAction[0]=8 and desertDir=1
      {
        newMapX=3280; newMapY=288
        toRoom=rMain_46
      }
      else
      {
        global.tempAction[0]=0
        if desertDir=1 {global.tempAction[0]+=1}
      }
    }
    if room=rHexPlat55 //spsp ns final instrument
    {
      var instrProg;
      instrProg=string_char_at(global.eGateProg,8)
      if instrProg="0"
      {
        var tNewString;
        tNewString=string_delete(global.eGateProg,8,1)
        tNewString=string_insert("8",tNewString,8)
        global.eGateProg=tNewString
      }
    }
    scrModHook("exitPlayer",exitType,0) //mods change (added): the mods' own code for exits (they can change toRoom, newMapX, newMapY)

    global.wpWaterLEntry=global.wpWaterLevel
    global.recAreaTrans+=1
    global.newMapX=newMapX; global.newMapY=newMapY
    global.gamePaused=false
    writeToPlayerGlobals()
    if global.bNightmareMode=0 {global.difficulty=2}
    if global.rmDeaths>=5 {global.chaoRecognition=1}
    global.rmDeaths=0; global.hitsTaken=0
    SS_StopSound(global.msc_Starman)
    transition_steps=10
    transition_kind=21
    if variable_local_exists("newStep") {transition_steps=newStep}
    if variable_local_exists("newTrans") {transition_kind=newTrans}
    room_goto_fixed(toRoom)
  }
}
else if exitType=1 //No key (Player Touch)
{
  if room=rBelmont3_2B and true and x=288 and instance_exists(oRedDiamond)     //spsp
  {
    instance_destroy()
    exit
  }

  scrModHook("exitPlayer",exitType,0) //mods change (added): see above
  global.wpWaterLEntry=global.wpWaterLevel
  global.recAreaTrans+=1
  global.newMapX=newMapX; global.newMapY=newMapY
  global.gamePaused=false
  writeToPlayerGlobals()
  if toRoom=rLink2_Overworld or toRoom=rLink2_Overworld2 {playSound(global.snd_ZeldaToMap,0,1,1)}
  if global.bNightmareMode=0 {global.difficulty=2}
  if global.rmDeaths>=5 {global.chaoRecognition=1}
  global.rmDeaths=0; global.hitsTaken=0
  SS_StopSound(global.msc_Starman)
  transition_steps=10
  transition_kind=21
  if variable_local_exists("newStep") {transition_steps=newStep}
  if variable_local_exists("newTrans") {transition_kind=newTrans}
  
  if room=rExtGateE_2 and true      //spsp
  {
    global.modeSpeed=1
    //global.gameFrameRate=60
    global.distSpeedRoom=1 //60fps change: the next room runs at 2x speed through global.modSpeedMul (the mod's roomStart hook); DT3+'s gameFrameRate is the FPS option
  }
  else if room=rExtGateE_3 and true      //spsp
  {
    global.modeSpeed=0
    //global.gameFrameRate=30
    global.distSpeedRoom=0 //60fps change: see above
    //SS_SetSoundFreq(findMusic(11),22050)
    scrMusicFreq(findMusic(11),22050) //60fps change: scaled to the music file's own sample rate, as DT3+'s playMusic does (scrMusicFreq)
  }
  
  room_goto_fixed(toRoom)
}
else if exitType=2 //Press Down
{
  if oKeyCodesHighFPS.kCodePressed[4]=1 and global.gamePaused=false
  {
    global.gamePaused=true
    playSound(global.snd_MarioPipe,0,1,1)
    if global.activeCharacter=0 oPlayer1.sprite_index=sJerryIdle
    else if global.activeCharacter=1 oPlayer1.sprite_index=sClaireIdle
    oPlayer1.image_speed=0.1
    oPlayer1.depth=1100000
    oPlayer1.bCanTakeDamage=false
    oPlayer1.bCanTakeHit=false
    animPlayerExit=1
  }
}
