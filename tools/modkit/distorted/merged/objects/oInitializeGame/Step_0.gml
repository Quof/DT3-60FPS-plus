screenEfA+=1*gDeltaTime
if screenEfA mod 6=0
{
  var tFFScl;
  tFFScl=random(0.1)
  tEffect=instance_create(random(room_width),random(room_height),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.25
  tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl; tEffect.direction=random_range(70,110)
  tEffect.speed=random(0.75)+0.75; tEffect.fadeSpd=0.005; tEffect.image_blend=c_green
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0
}

if screenEfA mod 135=0
{
  var tPosFireX,tPosFireY,tDir;
  tPosFireX=random(room_width)
  tPosFireY=random(room_height)
  tDir=0
  for(i=0;i<20;i+=1)
  {
    var tFFScl;
    tFFScl=random(0.1)
    tEffect=instance_create(tPosFireX,tPosFireY,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.1
    tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl; tEffect.direction=tDir
    tEffect.speed=random(0.5)+1.5; tEffect.fadeSpd=0.005; tEffect.image_blend=c_green
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0
    tDir+=360/20
  }
}

//cursor movement
if bCanUseMenu=1
{
  //-- Title flash --
  titleCTime+=2*gDeltaTime
  //if titleCTime<=80
  //  titleRGB-=2*gDeltaTime
  //else if titleCTime>=81
  //{
  //  titleRGB+=2*gDeltaTime
  //  if titleCTime=160
  //    titleCTime=0
  //}
  if titleCTime>=160 {titleCTime-=160} //60fps change: wraps at 160 whatever the step; "=160" was missed after a frame rate change mid-flash (F2 or Options: a half count at 120fps, an odd one at 60), and the colour then rose past 255 for good, where make_color_rgb wraps it (the title snapped dark, then went back to orange, over and over)
  titleRGB=255-min(titleCTime,160-titleCTime) //60fps change: from the time (255 down to 175 and back, as at 30fps), so it can't drift: added up per frame it lost half a step every flash at 120fps (a count of 80.5 was in neither branch)
  titleCl=make_color_rgb(titleRGB,255,titleRGB)

  //title options change (added): the Options menu (oPauseMenu) has the controls while it's open
  if instance_exists(oPauseMenu) {exit}
  if instance_exists(oModMenu) {exit} //mods change (added): the Mods window is open

  //save slots change (added): the slot list, in place of the five options after New Game or Continue. Moving through it
  //shows each slot's save on the right; Back goes back to the five options
  if slotMenu>0
  {
    if oKeyCodesHighFPS.kCodePressed[4]=1 or oKeyCodesHighFPS.kCodePressed[3]=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if oKeyCodesHighFPS.kCodePressed[4]=1 {slotCursorPos+=1; if slotCursorPos>5 {slotCursorPos=1}}
      else {slotCursorPos-=1; if slotCursorPos<1 {slotCursorPos=5}}
      //global.paraString[0]="DT3data"+string(slotCursorPos)+".dts"
      //global.paraString[0]=global.saveDir+"DT3data"+string(slotCursorPos)+".dts" //saves folder change: in the Saves folder
      global.paraString[0]=scrSlotFile(slotCursorPos) //save slots change: slot 1 is DT3data.dts
      event_user(0)
      if locCheck>0 {titleLocation=locationCheck(locCheck)}
      else {titleLocation=""}
    }
    else if oKeyCodesHighFPS.kCodePressed[16]=1 //back to the five options, showing the slot in use again
    {
      resetKeyCodes()
      playSound(global.snd_MenuCancel,0,1,1)
      slotMenu=0
      //global.paraString[0]="DT3data"+string(global.saveSlot)+".dts"
      //global.paraString[0]=global.saveDir+"DT3data"+string(global.saveSlot)+".dts" //saves folder change: in the Saves folder
      global.paraString[0]=scrSlotFile(global.saveSlot) //save slots change: slot 1 is DT3data.dts
      event_user(0)
      if locCheck>0 {titleLocation=locationCheck(locCheck)}
      else {titleLocation=""}
    }
    else if oKeyCodesHighFPS.kCodePressed[15]=1 or keyboard_check_pressed(vk_enter)
    {
      resetKeyCodes()
      if slotMenu=2 and titleLocation="" {playSound(global.snd_MenuCancel,0,1,1)} //an empty slot: nothing to continue
      else
      {
        playSound(global.snd_MenuConfirm,0,0.95,1)
        global.gamePaused=0
        global.saveSlot=slotCursorPos
        global.lastSaveSlot=slotCursorPos //shown on the right next time
        saveOptions()
        if slotMenu=1 //---------- New Game ----------
        {
          global.saveSlotNewGame=0
          //a save already in this slot stays until the new game is saved (oGame doesn't autosave till then), and a
          //copy of it goes to DT3data<slot>backup.dts
          if titleLocation!=""
          {
            var tBackup;
            //tBackup="DT3data"+string(slotCursorPos)+"backup.dts"
            //tBackup=global.saveDir+"DT3data"+string(slotCursorPos)+"backup.dts" //saves folder change: in the Saves folder
            tBackup=string_replace(scrSlotFile(slotCursorPos),".dts","backup.dts") //save slots change: slot 1's is DT3databackup.dts
            if file_exists(tBackup) {file_delete(tBackup)}
            file_copy(global.paraString[0],tBackup)
            global.saveSlotNewGame=1
          }
          event_user(2)
        }
        else {event_user(3)} //---------- Continue ----------
      }
    }
    exit
  }

  //----- Title menu controls -----
  if oKeyCodesHighFPS.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if fileCursorPos<arraySizeMax
    {
      fileCursorY+=cursorMoveInc
      fileCursorPos+=1
    }
    else
    {
      fileCursorY-=cursorMoveInc*(arraySizeMax-1)
      fileCursorPos=1
    }
  }
  else if oKeyCodesHighFPS.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if fileCursorPos>1
    {
      fileCursorY-=cursorMoveInc
      fileCursorPos-=1
    }
    else
    {
      fileCursorY+=cursorMoveInc*(arraySizeMax-1)
      fileCursorPos=arraySizeMax
    }
  }

  //input codes
  if keyboard_check_pressed(vk_enter)
  {
    var window_string;
    //if completedGame=2
    if completedGame=2 or titleTrueEnd=1 //save slots change: any save at the true end, not just the one shown
    {
      //inputMenu=get_string("Input code... >>Here are a few codes... (All codes are lowercase)#
      window_string = "Input code... >>Here are a few codes... (All codes are lowercase)#
      [earthshiftisbroken] : Nightmare Mode#
      [ihatemyself] : Achilles Mode#
      [ohmygodbirdsaresocool] : Easy Mode#
      [praisethesun] : Dark Mode#
      [framerate] : 2x Speed Mode#
      [nzz] or [negativezeroz] : All enemies renamed to Buttface McGee#
      [droggeljug] : Most text replaced with droggeljug"
    }
    else
    {
      window_string = "Input code... (All codes are lowercase)#If you're trying to start the game, check the controls listed on the bottom-right of the screen."
    }
    inputMenu=get_string(window_string,"")

    if inputMenu="earthshiftisbroken" //Nightmare Mode
    {
      if global.bNightmareMode=0
      {
        global.bNightmareMode=1
        codeNightmare=1 //save slots change (added): kept while looking through the slots (event_user(0))
        global.difficulty=1
        global.skillTree[0]=2
        global.skillTree[1]=2
        global.skillTree[2]=3
        global.skillTree[3]=3
        global.skillTree[4]=5
        global.skillTree[22]=1
        global.skillTree[23]=1
        global.skillTree[24]=4
        global.skillTree[25]=5
        global.skillTree[26]=2
        global.skillTree[28]=1
        global.skillTree[29]=1
        global.equipItems="0001100111110000001111111011011111111111"
        global.chestMoney="00000000000010000000000000000000010000000000000100000000000000000000000000011"
        //spsp ns new item list for nightmare and no free curse items
        global.equipItems="1101100110000000001111111011111111111111"
        global.chestMoney="00000000000000000000000000000000000000000000000000000000000000000000000000000"
        global.extraItems="11111111"
        global.itemFinder=1
        for(i=0;i<3;i+=1)
        {
          global.equipJerry[i]=0
          global.equipClaire[i]=0
        }
        show_message("[Nightmare Mode] Activated!##On this setting, the game works like it does in [Assist Mode] but without the half damage benefit. Enemies will not drop any money or award AP.##Nightmare Mode exclusive#Nearly all collectibles have been replaced with a piece of cheese that does nothing. Certain skills have been set and some equipment is given. Inactive abilities now recharge a bit faster than normal. Heart Containers are still dropped from Gate bosses and another can be obtained by completing the Cursed Trials.##To get this going, just start a new game. You may want to back up your save file if you already have one on the normal setting.##Anyway, good luck!")
      }
      else
      {
        show_message("[Nightmare Mode] was already turned on.")
      }
    }
    if inputMenu="ihatemyself" //One Hit Kill Mode
    {
      if global.bOneHitKillMode=0
      {
        global.bOneHitKillMode=1
        codeAchilles=1 //save slots change (added): kept while looking through the slots (event_user(0))
        show_message("[Achilles Mode] Activated!##On this setting, everything kills you in one hit. This can be paired with [Nightmare Mode] or extra self-hate.#A new game is required.")
      }
      else
      {
        show_message("[Achilles Mode] was already turned on.")
      }
    }
    if inputMenu="ohmygodbirdsaresocool" //Permanent Easy Mode
    {
      if global.permaEasyMode=0
      {
        global.permaEasyMode=1
        codeEasy=1 //save slots change (added): kept while looking through the slots (event_user(0))
        show_message("[Permanent Easy Mode] Activated!!##On this setting, you have the half damage of [Assist Mode] without the penalties.#A new game is required.")
      }
      else
      {
        show_message("[Permanent Easy Mode] was already turned on. Look, this game is not going to be made any easier for you.")
      }
    }
    if inputMenu="praisethesun" //Dark mode
    {
      if global.modeDark=0
      {
        global.modeDark=1
        show_message("[Dark Mode] Activated!##All maps are now dark rooms. Note this mode may not work on all machines. This mode is meant for silly fun.#It does not save.")
      }
      else
      {
        show_message("[Dark Mode] was already turned on.")
      }
    }
    if inputMenu="framerate" //2x Speed mode
    {
      if global.modeSpeed=0
      {
        global.modeSpeed=1
        global.gameFrameRate=60
        show_message("[2x Speed Mode] Activated!##The game will run twice as fast. Note this mode may not work on all machines. This mode is meant for silly fun.#It does not save.")
      }
      else
      {
        show_message("[2x Speed Mode] was already turned on.")
      }
    }
    if inputMenu="nzz" or inputMenu="negativezeroz" //Buttface mode
    {
      if global.modeButtface=0
      {
        global.modeButtface=1
        show_message("[Buttface Mode] Activated!##All enemies are now named Buttface McGee.#It does not save.")
      }
      else
      {
        show_message("[Buttface Mode] was already turned on.")
      }
    }
    if inputMenu="droggeljug" //droggeljug mode
    {
      if global.modeDroggeljug=0
      {
        global.modeDroggeljug=1
        show_message("[droggeljug Mode] Activated!##If you entered this, you already know what this does.#It does not save.")
      }
      else
      {
        show_message("[droggeljug Mode] was already turned on.")
      }
    }
    if inputMenu="wahfuu" //Wahfuu mode
    {
      if global.modeWahfuu=0
      {
        global.modeWahfuu=1
        show_message("[Wahfuu Mode] Activated!##Abomination now renamed to 'Wahfuu' and Sand Crawler renamed to 'Wahfuu Jr.'#It does not save.")
      }
      else
      {
        show_message("[Wahfuu Mode] was already turned on.")
      }
    }
    if inputMenu="anicephysicsengine" //spsp ice mode
    {
      if global.modeNice=0
      {
        global.modeNice=1
        show_message("[nIce Mode] Activated!##Ice physics for the entire game! Amazing! What more could you want?#It does not save.")
      }
      else
      {
        show_message("[nIce Mode] was already turned on.")
      }
    }
    if inputMenu="quof" //Quof (First speed run / 1 sitting run) (no game changes)
    {
      show_message("Quof, go to sleep, you've been awake too long.##Congrats to Quof for having the first speed run / single sitting run of the game.#Completion Time: 28 Hours, 33 Minutes, 47 Seconds, 58 Hundredths")
    }
    if inputMenu="kefit" //Kefit pls (no game changes)
    {
      show_message("Kefit pls.")
    }
    if inputMenu="zephyrburst" //ZephyrBurst (no game changes)
    {
      show_message("I am not a new game mode!")
    }
    if inputMenu="shrouds" //Shrouds (no game changes)
    {
      show_message("You played DT1. You already know you don't want them in this.")
    }
    /*if inputMenu="remember undo" //For unlocking the final chapter (Getting Jeremy to remember how to undo) //spsp
    {
      if truthCaveProg=90 //Unlock since player has beaten Parasite
      {
        ini_open(global.paraString[0])
        sectionWrite="ALPHA"
        ini_write_real(sectionWrite,"123iH",100) //Save to the Cave progress variable - used during ending to trigger chapter 21
        ini_close()
        show_message("The truth is now open to you. Go forward without fear. Jeremy will handle the rest.")
      }
      else if truthCaveProg<90 //Do not unlock as player has not finished the Path to the Truth
      {
        show_message("Jeremy is not ready for this yet.")
      }
      else //Already unlocked
      {
        show_message("The true path is already open. Continue on and Jeremy will do the rest.")
      }
    }*/
    if inputMenu="undo remember" //For unlocking the final chapter (Getting Jeremy to remember how to undo) //spsp
    {
      if truthCaveProg=90 //Unlock since player has beaten Parasite
      {
        ini_open(global.paraString[0])
        sectionWrite="ALPHA"
        ini_write_real(sectionWrite,"123iH",100) //Save to the Cave progress variable - used during ending to trigger chapter 21
        ini_close()
        show_message("The truth is now open to you. Go forward without fear. Jeremy will handle the rest.")
      }
      else if truthCaveProg<90 //Do not unlock as player has not finished the Path to the Truth
      {
        show_message("Jeremy is not ready for this yet.")
      }
      else //Already unlocked
      {
        show_message("The true path is already open. Continue on and Jeremy will do the rest.")
      }
    }
    if inputMenu="remember undo" //spsp
    {
        show_message("Nope :^)##Fun fact: The hints in the cave are all unchanged, and they still apply.")
    }
    if inputMenu="ireallyliketocheat" //Debug Mode
    {
      inputMenu=get_string("You're trying to turn on debug mode, but you need one more code.","")
      if inputMenu="iamadirtycheater"
      {
        if global.debugMenu=0
        {
          global.debugMenu=1
          show_message("[Debug Menu] Activated!#It does not save.")
        }
        else
        {
          global.debugMenu=0
          show_message("[Debug Menu] Deactivated!")
        }
      }
    }
    if inputMenu="save0"
    {
      //global.paraString[0] = global.initialSave
      //save slots change: back to the save slots (the one played last), or to the command line's save file as before
      //if parameter_count()=0 {global.saveSlot=global.lastSaveSlot; global.paraString[0]="DT3data"+string(global.saveSlot)+".dts"}
      //if parameter_count()=0 {global.saveSlot=global.lastSaveSlot; global.paraString[0]=global.saveDir+"DT3data"+string(global.saveSlot)+".dts"} //saves folder change: in the Saves folder
      if parameter_count()=0 {global.saveSlot=global.lastSaveSlot; global.paraString[0]=scrSlotFile(global.saveSlot)} //save slots change: slot 1 is DT3data.dts
      else {global.paraString[0] = global.initialSave}
      event_user(0)
      if locCheck>0 {titleLocation=locationCheck(locCheck)}
      else {titleLocation=""}
    }
    else if string_starts_with(inputMenu,"save ") and string_length(inputMenu)>=6 // load different saves
    {
      Sname_len = string_length(inputMenu)-5
      Sname = string_copy(inputMenu,6,Sname_len)
      //global.paraString[0] = string_insert(Sname,".dts",1)
      //saves folder change: in the Saves folder; one made before it (in the game's folder) is copied in first
      if !file_exists(global.saveDir+Sname+".dts") and file_exists(Sname+".dts") {file_copy(Sname+".dts",global.saveDir+Sname+".dts")}
      global.paraString[0]=global.saveDir+Sname+".dts"
      global.saveSlot=0 //save slots change (added): New Game and Continue use this file instead of the slots ('save0' goes back)
      event_user(0)
      if locCheck>0 {titleLocation=locationCheck(locCheck)}
      else {titleLocation=""}
    }
    scrModHook("titleCode",inputMenu,0) //mods change (added): the mods' own codes
  }

  //start game
  //if oKeyCodesHighFPS.kCodePressed[5]=1 or keyboard_check_pressed(vk_enter)
  if oKeyCodesHighFPS.kCodePressed[15]=1 or keyboard_check_pressed(vk_enter) //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    resetKeyCodes()
    playSound(global.snd_MenuConfirm,0,0.95,1)
    global.gamePaused=0
    if fileCursorPos=1 //---------- New Game ----------
    {
      //save slots change: the slot list first (its New Game starts the game); with a save file from the command line or
      //'save NAME', straight to event_user(2), which has the code that was here
      if global.saveSlot>0 {slotMenu=1; slotCursorPos=global.saveSlot; global.gamePaused=true}
      else {global.saveSlotNewGame=0; event_user(2)}
      /*
      SS_StopSound(global.msc_TitleMenu)
      ini_open(global.paraString[0])
      var sectionRead;
      sectionRead="ALPHA"
      global.gameCompleted=ini_read_real(sectionRead,"144",0)
      ini_close()
      room_goto(rBeginning)
      */
    }
    //else if fileCursorPos=2 and titleLocation!="" //---------- Continue ----------
    else if fileCursorPos=2 //---------- Continue ---------- //save slots change
    {
      //save slots change: the slot list first, like New Game; event_user(3) has the code that was here
      if global.saveSlot>0 {slotMenu=2; slotCursorPos=global.saveSlot; global.gamePaused=true}
      else if titleLocation!="" {event_user(3)}
      /*
      SS_StopSound(global.msc_TitleMenu)
      loadSaveData()
      global.resetMusic=true

      extCheatFlag=string_char_at(global.extraFlags,10)
      if extCheatFlag="1"
      {
        room_goto(rCheaterRoom)
      }
      else
      {
        if checkIfCheating=0 {room_goto(roomToPlace)}
        else {room_goto(rCheaterRoom)}
      }
      */
    }
    else if fileCursorPos=3 //---------- Options ---------- //title options change (added)
    {
      //the pause menu's Options submenu; in title mode it saves to DT3Options.dts only (see oPauseMenu)
      global.gamePaused=true
      instance_create(0,0,oPauseMenu)
    }
    //else if fileCursorPos=3 //---------- Back Story ----------
    else if fileCursorPos=4 //---------- Back Story ---------- //title options change
    {
      SS_StopSound(global.msc_TitleMenu)
      room_goto(rBackStory)
    }
    //else if fileCursorPos=4 //---------- Exit ----------
    else if fileCursorPos=5 //---------- Exit ---------- //title options change
      game_end()
    else if fileCursorPos=6 //---------- Mods ---------- //mods change (added)
    {
      global.gamePaused=true
      instance_create(0,0,oModMenu)
    }
  }
}
else
{
  if introProg>=1
  {
    titleDelay+=1*gDeltaTime
    if titleWidth<432 //Title sweep
    {
      titleWidth+=1.2*gDeltaTime
      if titleWidth>=432
      {
        titleWidth=432
        titleDelay=0
      }
    }
    else
    {
      if subtitleAlpha<1 //Subtitle fade in
      {
        if titleDelay>=25
        {
          subtitleAlpha+=0.02*gDeltaTime
          if subtitleAlpha>=1
            titleDelay=0
        }
      }
      else //Menu fade in
      {
        if titleDelay>=4
        {
          fileWAlpha+=0.01*gDeltaTime
          if fileWAlpha>=1
            bCanUseMenu=1
        }
      }
    }
  }

  //if oKeyCodesHighFPS.kCodePressed[5]=1 or keyboard_check_pressed(vk_enter)
  if oKeyCodesHighFPS.kCodePressed[15]=1 or keyboard_check_pressed(vk_enter) //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    resetKeyCodes()
    playSound(global.snd_MenuConfirm,0,0.95,1)
    titleWidth=432
    subtitleAlpha=1
    fileWAlpha=1
    introProg=1
    oTitleScreenChao.moveProg=10000
    //oTitleScreenChao.speed=2
    //oTitleScreenChao.direction=65
    oTitleScreenChao._speed=2 //60fps change: the title Chao moves with _speed/_direction now; built-in speed moved it uncorrected (2x/4x as fast at 60/120fps)
    oTitleScreenChao._direction=65 //60fps change: see above
    bCanUseMenu=1
  }
}

if !instance_exists(oGame) //close the game
{
  if keyboard_check_pressed(vk_escape)
  {
    var closeGame;
    closeGame=show_question("Do you want to quit the game? :(")
    if closeGame=true
      game_end()
  }
}
