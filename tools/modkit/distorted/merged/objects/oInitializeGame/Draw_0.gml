if loadImage=false //Loading bar
{
  loadingBarMax=201
  draw_set_alpha(1)
  draw_set_font(fnt_Location)
  draw_set_halign(fa_center)
  draw_set_color(c_ltgray)
  draw_rectangle(142,156,144+loadingBarMax,162,false)
  draw_set_color(c_white)
  draw_rectangle(142,156,144+loadingBarMax,162,true)
  draw_set_color(c_green)
  draw_text(234,112,"Loading External Files")
  draw_rectangle(143,157,143+loadingBar,161,false)
  draw_text(234,170,"Loading: " +string(loadingType))
}
else //Title screen stuff
{
  //Help Info
  draw_set_color(c_black)
  draw_set_alpha(0.4)
  //draw_rectangle(2,324,112,335,0) //Game by darken
  draw_rectangle(2,336,112,349,0) //Send to darken
  draw_rectangle(382,308,477,349,0) //control help darken
  draw_set_alpha(1)
  draw_set_halign(fa_left)
  draw_set_font(fnt_StatRender)
  textDropShadow("Version: " +string(versionTag),4,1,c_white,c_black,1)
  draw_set_font(fnt_Points)
  //textDropShadow("Game by ZephyrBurst",4,323,c_white,c_black,1)
  textDropShadow("Game by ZephyrBurst",4,335,c_white,c_black,1)
  //title options change (added): controls can be changed from the title's Options menu now, so show the current ones
  //controlHelp="Controls:#[" +string(global.ctrlUp) +"] Up    [" +string(global.ctrlDown) +"] Down#[" +string(global.ctrlJump) +"] Confirm"
  //controlHelp="Controls:#[" +string(global.ctrlUp) +"] Up    [" +string(global.ctrlDown) +"] Down#[" +string(global.ctrlConfirm) +"] Confirm" //controls change: Confirm's own key
  controlHelp="Controls:#[Up Key] Up    [Down Key] Down#[Confirm] Confirm" //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
  textDropShadow(controlHelp,384,307,c_white,c_black,1)

  //DT3 Title - width[432]  heightToSecondWord[30]
  draw_sprite_general(sTitleText,0,0,0,titleWidth,30,10,48,1,1,0,titleCl,titleCl,titleCl,titleCl,1)
  //Subtitle
  draw_sprite_general(sTitleText,0,0,30,124,20,10,78,1,1,0,titleCl,titleCl,titleCl,titleCl,subtitleAlpha)
  //Title Menu
  //draw_sprite_ext(sFileMain,0,107,133,1,1,0,c_white,fileWAlpha)
  //save slots change: drawn in parts now. On the left the five options (sFileMain's left part) or the slot list
  //(sFileSlots, with the end of the circuit moved to the slot on the cursor: sFileSlotLink); on the right the preview
  //panel, coloured by the save's mode and with the MODE box (sFilePanel, frame from event_user(0))
  //if slotMenu=0 {draw_sprite_part_ext(sFileMain,0,0,0,116,105,107,133,1,1,c_white,fileWAlpha)}
  if slotMenu=0 and arraySizeMax<6 {draw_sprite_part_ext(sFileMain,0,0,0,116,105,107,133,1,1,c_white,fileWAlpha)} //mods change: as before without the Mods button
  else if slotMenu=0 //mods change (added): a sixth button, Mods, under Exit Game: the panel one button longer
  {
    draw_sprite_part_ext(sFileMain,0,0,0,116,98,107,133,1,1,c_white,fileWAlpha) //the five buttons
    draw_sprite_part_ext(sFileMain,0,0,79,116,6,107,231,1,1,c_white,fileWAlpha) //the sixth from Exit Game's edges: top,
    draw_sprite_part_ext(sFileMain,0,0,85,18,10,107,237,1,1,c_white,fileWAlpha) //left end,
    draw_sprite_part_ext(sFileMain,0,84,85,32,10,191,237,1,1,c_white,fileWAlpha) //right end,
    draw_sprite_part_ext(sFileMain,0,0,95,116,10,107,247,1,1,c_white,fileWAlpha) //bottom, then the panel's bottom edge
    draw_set_alpha(fileWAlpha)
    draw_set_color(make_color_rgb(0,184,72))
    draw_rectangle(125,237,191,247,0) //the button's middle, where its label goes
    draw_set_font(fnt_PauseMenuMain)
    draw_set_halign(fa_left)
    textDropShadow("Mods",125,235,make_color_rgb(240,240,240),make_color_rgb(0,120,64),1)
    draw_set_alpha(1)
  }
  else
  {
    draw_sprite_ext(sFileSlots,0,107,133,1,1,0,c_white,fileWAlpha)
    draw_sprite_ext(sFileSlotLink,slotCursorPos-1,200,146,1,1,0,c_white,fileWAlpha)
  }
  draw_sprite_ext(sFilePanel,titlePanel,223,133,1,1,0,c_white,fileWAlpha)

  if bCanUseMenu=1 //Control menu
  {
    draw_set_color(c_white)
    //----- Quest Record -----
    if titleLocation!=""
    {
      for(i=0;i<titleChips;i+=1)
      {
        draw_sprite(sPauseM_Chips,i,242+(i*16),157)
      }

      if instrProg[0]="9"
        draw_sprite_ext(sPauseM_Instruments,0,342,152,0.5,0.5,0,c_white,1) //Full Moon Cello
      if instrProg[1]="9"
        draw_sprite_ext(sPauseM_Instruments,1,352,152,0.5,0.5,0,c_white,1) //Conch Horn
      if instrProg[2]="9"
        draw_sprite_ext(sPauseM_Instruments,2,362,152,0.5,0.5,0,c_white,1) //Sea Lily's Bell
      if instrProg[3]="9"
        draw_sprite_ext(sPauseM_Instruments,3,372,152,0.5,0.5,0,c_white,1) //Surf Harp
      if instrProg[4]="9"
        draw_sprite_ext(sPauseM_Instruments,4,342,162,0.5,0.5,0,c_white,1) //Wind Marimba
      if instrProg[5]="9"
        draw_sprite_ext(sPauseM_Instruments,5,352,162,0.5,0.5,0,c_white,1) //Coral Triangle
      if instrProg[6]="9"
        draw_sprite_ext(sPauseM_Instruments,6,362,162,0.5,0.5,0,c_white,1) //Organ of Evening Calm
      if instrProg[7]="9"
        draw_sprite_ext(sPauseM_Instruments,7,372,162,0.5,0.5,0,c_white,1) //Thunder Drum

      draw_set_font(fnt_PauseMenuText)

      //textDropShadow(titleLocation,232,178,textColorMain,textColorShadow,1)
      textDropShadow(titleLocation,232,178,textColorMain,titlePanelShadow,1) //save slots change: the shadow goes with the panel's colour
      var tMinuteZ, tSecondZ;
      if titleMinute<10 {tMinuteZ="0"}
      else {tMinuteZ=""}
      if titleSecond<10 {tSecondZ="0"}
      else {tSecondZ=""}
      //textDropShadow(string(titleHour) +string(":") +string(tMinuteZ) +string(titleMinute) +string(":") +string(tSecondZ) +string(titleSecond),232,202,textColorMain,textColorShadow,1)
      textDropShadow(string(titleHour) +string(":") +string(tMinuteZ) +string(titleMinute) +string(":") +string(tSecondZ) +string(titleSecond),232,202,textColorMain,titlePanelShadow,1) //save slots change
      if titleModeName!="" {textDropShadow(titleModeName,320,202,textColorMain,titlePanelShadow,1)} //save slots change (added): the MODE box (not for normal saves)
    }
    //save slots change (added): the font was only set above when the save shown has a location, so with an empty slot
    //shown (the true end message can show for any save now) these texts came out in fnt_Points
    draw_set_font(fnt_PauseMenuText)
    //if completedGame=1
    if completedGame=1 and titleTrueEnd=0 //save slots change: the true end message below wins when any save has reached it
    {
      textDropShadow("Oh hey, you've beaten the game!#Also, press [Enter] and type 'earthshiftisbroken' for more fun!#AND/OR... type 'ihatemyself' for something else!",120,96,textColorMain,textColorShadow,1)
    }
    //else if completedGame=2
    else if completedGame=2 or titleTrueEnd=1 //save slots change: any save at the true end (titleTrueEnd), not just the one shown
    {
      textDropShadow("Oh hey, you've reached the true end!#Also, press [Enter] for more fun!",120,104,textColorMain,textColorShadow,1)
    }

    var tInfoY; tInfoY=248 //mods change (added): the title menu's info text, lower when the Mods button makes the menu longer
    if slotMenu=0 and arraySizeMax>=6 {tInfoY=267}
    //save slots change (added): what the slot on the cursor does, in the slot list
    if slotMenu=1
    {
      if titleLocation="" {textDropShadow("Start a new game in this slot.",80,248,c_white,c_black,4)}
      else {textDropShadow("Start a new game in this slot. The save that's already here is kept#(and backed up) until you save the new game.",80,248,c_white,c_black,4)}
    }
    else if slotMenu=2
    {
      if titleLocation="" {textDropShadow("This slot is empty.",80,248,c_white,c_black,4)}
      else {textDropShadow("Continue the game saved in this slot.",80,248,c_white,c_black,4)}
    }
    //if fileCursorPos=1 {textDropShadow("If you want to start a new game.",80,248,c_white,c_black,4)}
    //else if fileCursorPos=1 {textDropShadow("If you want to start a new game.",80,248,c_white,c_black,4)} //save slots change
    //else if fileCursorPos=2 {textDropShadow("If you want to continue from where you left off last time.",80,248,c_white,c_black,4)}
    //else if fileCursorPos=3 {textDropShadow("If you want a refresher on the story so far, or if you didn't play the#first two games.",80,248,c_white,c_black,4)}
    //else if fileCursorPos=4 {textDropShadow("If you want to close the game, but why would you ever want to do that?",80,248,c_white,c_black,4)}
    //else if fileCursorPos=3 {textDropShadow("If you want to change the controls, audio, display and other settings.",80,248,c_white,c_black,4)} //title options change (added)
    //else if fileCursorPos=4 {textDropShadow("If you want a refresher on the story so far, or if you didn't play the#first two games.",80,248,c_white,c_black,4)} //title options change
    //else if fileCursorPos=5 {textDropShadow("If you want to close the game, but why would you ever want to do that?",80,248,c_white,c_black,4)} //title options change
    else if fileCursorPos=1 {textDropShadow("If you want to start a new game.",80,tInfoY,c_white,c_black,4)} //mods change: at tInfoY
    else if fileCursorPos=2 {textDropShadow("If you want to continue from where you left off last time.",80,tInfoY,c_white,c_black,4)} //mods change
    else if fileCursorPos=3 {textDropShadow("If you want to change the controls, audio, display and other settings.",80,tInfoY,c_white,c_black,4)} //mods change
    else if fileCursorPos=4 {textDropShadow("If you want a refresher on the story so far, or if you didn't play the#first two games.",80,tInfoY,c_white,c_black,4)} //mods change
    else if fileCursorPos=5 {textDropShadow("If you want to close the game, but why would you ever want to do that?",80,tInfoY,c_white,c_black,4)} //mods change
    else if fileCursorPos=6 {textDropShadow("If you want to turn mods on or off. Mods are other people's add-ons for#the game: only use ones you trust, as they can run their own code.",80,tInfoY,c_white,c_black,4)} //mods change (added)

    //File cursor
    //draw_sprite_ext(sTitleCursor,0,fileCursorX,fileCursorY,1,1,0,titleCl,1)
    if slotMenu=0 {draw_sprite_ext(sTitleCursor,0,fileCursorX,fileCursorY,1,1,0,titleCl,1)}
    else {draw_sprite_ext(sTitleCursor,0,fileCursorX,147+19*(slotCursorPos-1),1,1,0,titleCl,1)} //save slots change (added): on the slot list's rows
    
    //Display save file used
    draw_set_font(fnt_StatRender)
    draw_set_halign(fa_right)
    //textDropShadow("Active Save",478,-1,c_white,c_black,1)
    //textDropShadow(global.paraString[0],478,9,c_white,c_black,1)
    //Display game modes active
    draw_set_halign(fa_left)
    if global.bNightmareMode=1 {textDropShadow("*Nightmare Mode*",2,146,c_white,c_black,1)}
    if global.bOneHitKillMode=1 {textDropShadow("*Achilles Mode*",2,156,c_white,c_black,1)}
    if global.permaEasyMode=1 {textDropShadow("*Easy Mode*",2,166,c_white,c_black,1)}
    if global.modeDark=1 {textDropShadow("*Dark Mode*",2,176,c_white,c_black,1)}
    if global.modeSpeed=1 {textDropShadow("*2x Speed Mode*",2,186,c_white,c_black,1)}
    scrModHook("drawTitle",0,0) //mods change (added): the mods' own title screen text (under the modes above)

    if global.bNightmareMode=1 and global.bOneHitKillMode=1 //Red tint on title screen if Night Terror is on
    {
      if nmm_redPulse=0
      {
        nmm_redAlpha+=0.005*gDeltaTime
        if nmm_redAlpha>=0.35 {nmm_redPulse=1}
      }
      else if nmm_redPulse=1
      {
        nmm_redAlpha-=0.005*gDeltaTime
        if nmm_redAlpha<=0.2 {nmm_redPulse=0}
      }
      draw_set_alpha(nmm_redAlpha)
      draw_set_color(c_red)
      draw_rectangle(-1,-1,room_width+1,room_height+1,0)
    }
    if !instance_exists(oDHexRing)     //spsp
    {
      var theRing;
      theRing=instance_create(112,112,oDHexRing)
      with theRing {spinSpd=-1; changeDelay=0; moveSpd=0; image_angle=irandom(359)}
  }
}
}
