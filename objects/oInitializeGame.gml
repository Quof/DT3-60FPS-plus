#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
loadImage=false
versionTag="1.5.2.4 - [The Saved Edition]"
//Load external files
if !variable_global_exists("gamePriority")
{
  SS_Init()
  loadExtFiles()
  global.gamePriority=0     //initialize game priority var (loading purposes as well)
  global.sessionPlayTime=0  //how long the player has been playing this play session
}
stopAllMusic()
stopLoopingSounds()
global.debugMenu=1
global.location=0
titleBirdNum=0
initGameVars()
//Check ini
sectionRead=""
locCheck=0
event_user(0)

if locCheck>0 {titleLocation=locationCheck(locCheck)}
else {titleLocation=""}

SS_LoopSound(global.msc_TitleMenu); SS_SetSoundVol(global.msc_TitleMenu,global.optMusic*100)
window_set_size(480*screenCheck,352*screenCheck)
window_center()

global.gamePaused=true

//Initialize start up screen --------------------------------------------------
if progressCheck=0
{
  fileCursorPos=1
  fileCursorY=150
}
else //Start cursor on "Continue" if the player has a saved game in progress
{
  fileCursorPos=2
  fileCursorY=175
}
fileCursorX=120
cursorMoveInc=25
arraySizeMax=4

//-- Intro data --
bCanUseMenu=0
introProg=0
loadImage=true
loadingType=""
controlHelp="Controls:#[W] Up    [S] Down#[J] Confirm"

//-- Title and menu stuff --
titleDelay=0
titleWidth=0
titleRGB=255
titleCl=make_color_rgb(titleRGB,titleRGB,titleRGB)
titleCTime=0
subtitleAlpha=0
fileWAlpha=0
textColorMain=make_color_rgb(240,240,240)
textColorShadow=make_color_rgb(0,120,72)

//-- Characters stuff --
charJerry=instance_create(424,305,oMisc)
charJerry.sprite_index=sJerryGetUp
charJerry.type=1; charJerry.image_index=1; charJerry.image_speed=0; charJerry.image_xscale=-1
charClaire=instance_create(104,321,oMisc)
charClaire.sprite_index=sClaireSitUp
charClaire.type=1; charClaire.image_index=2; charClaire.image_speed=0

var titleBird;
for(i=0;i<titleBirdNum;i+=1)
{
  titleBird=instance_create(328-(i*5),320,oLittleBirdStaticA)
}

//-- Effects stuff --
screenEfA=0
instance_create(512,256,oTitleScreenChao)

//-- Nightmare effect stuff --
nmm_redAlpha=0.2
nmm_redPulse=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
  if titleCTime<=80
    titleRGB-=2*gDeltaTime
  else if titleCTime>=81
  {
    titleRGB+=2*gDeltaTime
    if titleCTime=160
      titleCTime=0
  }
  titleCl=make_color_rgb(titleRGB,255,titleRGB)

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
    if completedGame=2
    {
      inputMenu=get_string("Input code... >>Here are a few codes... (All codes are lowercase)#
      [earthshiftisbroken] : Nightmare Mode#
      [ihatemyself] : Achilles Mode#
      [ohmygodbirdsaresocool] : Easy Mode#
      [praisethesun] : Dark Mode#
      [framerate] : 2x Speed Mode#
      [nzz] or [negativezeroz] : All enemies renamed to Buttface McGee#
      [droggeljug] : Most text replaced with droggeljug","")
    }
    else
    {
      inputMenu=get_string("Input code... (All codes are lowercase)#If you're trying to start the game, check the controls listed on the bottom-right of the screen.","")
    }

    if inputMenu="earthshiftisbroken" //Nightmare Mode
    {
      if global.bNightmareMode=0
      {
        global.bNightmareMode=1
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
    if inputMenu="remember undo" //For unlocking the final chapter (Getting Jeremy to remember how to undo)
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
  }

  //start game
  if oKeyCodesHighFPS.kCodePressed[5]=1 or keyboard_check_pressed(vk_enter)
  {
    resetKeyCodes()
    playSound(global.snd_MenuConfirm,0,0.95,1)
    global.gamePaused=0
    if fileCursorPos=1 //---------- New Game ----------
    {
      SS_StopSound(global.msc_TitleMenu)
      ini_open(global.paraString[0])
      var sectionRead;
      sectionRead="ALPHA"
      global.gameCompleted=ini_read_real(sectionRead,"144",0)
      ini_close()
      room_goto(rBeginning)
    }
    else if fileCursorPos=2 and titleLocation!="" //---------- Continue ----------
    {
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
    }
    else if fileCursorPos=3 //---------- Back Story ----------
    {
      SS_StopSound(global.msc_TitleMenu)
      room_goto(rBackStory)
    }
    else if fileCursorPos=4 //---------- Exit ----------
      game_end()
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

  if oKeyCodesHighFPS.kCodePressed[5]=1 or keyboard_check_pressed(vk_enter)
  {
    resetKeyCodes()
    playSound(global.snd_MenuConfirm,0,0.95,1)
    titleWidth=432
    subtitleAlpha=1
    fileWAlpha=1
    introProg=1
    oTitleScreenChao.moveProg=10000
    oTitleScreenChao.speed=2
    oTitleScreenChao.direction=65
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
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oGame)
  SS_Unload()
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ini_open(global.paraString[0])
sectionRead="ALPHA"
titleHour=ini_read_real(sectionRead,"101",0)
titleMinute=ini_read_real(sectionRead,"102",0)
titleSecond=ini_read_real(sectionRead,"103",0)
locCheck=ini_read_real(sectionRead,"120",0)
progressCheck=ini_read_real(sectionRead,"123",0)
extraGateProg=ini_read_string(sectionRead,"123iX","00000000")
titleChips=ini_read_real(sectionRead,"124",0)
completedGame=ini_read_real(sectionRead,"144",0)
screenCheck=ini_read_real(sectionRead,"224",1)

truthCaveProg=ini_read_real(sectionRead,"123iH",0)

titleBirdNum=ini_read_real(sectionRead,"107",0)

global.bNightmareMode=ini_read_real(sectionRead,"137b",0)
global.bOneHitKillMode=ini_read_real(sectionRead,"137c",0)
global.permaEasyMode=ini_read_real(sectionRead,"146",0)

global.optMusic=ini_read_real(sectionRead,"201",95)
global.optSound=ini_read_real(sectionRead,"202",95)
global.optGamePad=ini_read_real(sectionRead,"222",0)

global.ctrlUp=ini_read_string(sectionRead,"301","W")
global.ctrlDown=ini_read_string(sectionRead,"302","S")
global.ctrlLeft=ini_read_string(sectionRead,"303","A")
global.ctrlRight=ini_read_string(sectionRead,"304","D")
global.ctrlJump=ini_read_string(sectionRead,"305","J")
global.ctrlCharSwap=ini_read_string(sectionRead,"306","U")
global.ctrlAbilSwap=ini_read_string(sectionRead,"307","I")
global.ctrlActA=ini_read_string(sectionRead,"308","K")
global.ctrlActB=ini_read_string(sectionRead,"309","L")
global.ctrlActC=ini_read_string(sectionRead,"310","O")
global.ctrlDashLeft=ini_read_string(sectionRead,"311","Q")
global.ctrlDashRight=ini_read_string(sectionRead,"312","E")
ini_close()

for(i=0;i<8;i+=1)
{
  instrProg[i]=string_char_at(extraGateProg,i+1)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
  draw_rectangle(2,324,112,335,0) //Game by darken
  draw_rectangle(2,336,308,349,0) //Send to darken
  draw_rectangle(382,308,477,349,0) //control help darken
  draw_set_alpha(1)
  draw_set_halign(fa_left)
  draw_set_font(fnt_StatRender)
  textDropShadow("Version: " +string(versionTag),4,1,c_white,c_black,1)
  draw_set_font(fnt_Points)
  textDropShadow("Game by ZephyrBurst",4,323,c_white,c_black,1)
  textDropShadow("Send all questions and concerns to ZephyrBurst@yahoo.com",4,335,c_white,c_black,1)
  textDropShadow(controlHelp,384,307,c_white,c_black,1)

  //DT3 Title - width[432]  heightToSecondWord[30]
  draw_sprite_general(sTitleText,0,0,0,titleWidth,30,10,48,1,1,0,titleCl,titleCl,titleCl,titleCl,1)
  //Subtitle
  draw_sprite_general(sTitleText,0,0,30,124,20,10,78,1,1,0,titleCl,titleCl,titleCl,titleCl,subtitleAlpha)
  //Title Menu
  draw_sprite_ext(sFileMain,0,107,133,1,1,0,c_white,fileWAlpha)

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
      
      textDropShadow(titleLocation,232,178,textColorMain,textColorShadow,1)
      var tMinuteZ, tSecondZ;
      if titleMinute<10 {tMinuteZ="0"}
      else {tMinuteZ=""}
      if titleSecond<10 {tSecondZ="0"}
      else {tSecondZ=""}
      textDropShadow(string(titleHour) +string(":") +string(tMinuteZ) +string(titleMinute) +string(":") +string(tSecondZ) +string(titleSecond),232,202,textColorMain,textColorShadow,1)
    }
    if completedGame=1
    {
      textDropShadow("Oh hey, you've beaten the game!#Also, press [Enter] and type 'earthshiftisbroken' for more fun!#AND/OR... type 'ihatemyself' for something else!",120,96,textColorMain,textColorShadow,1)
    }
    else if completedGame=2
    {
      textDropShadow("Oh hey, you've reached the true end!#Also, press [Enter] for more fun!",120,104,textColorMain,textColorShadow,1)
    }
    
    if fileCursorPos=1 {textDropShadow("If you want to start a new game.",80,248,c_white,c_black,4)}
    else if fileCursorPos=2 {textDropShadow("If you want to continue from where you left off last time.",80,248,c_white,c_black,4)}
    else if fileCursorPos=3 {textDropShadow("If you want a refresher on the story so far, or if you didn't play the#first two games.",80,248,c_white,c_black,4)}
    else if fileCursorPos=4 {textDropShadow("If you want to close the game, but why would you ever want to do that?",80,248,c_white,c_black,4)}
    
    //File cursor
    draw_sprite_ext(sTitleCursor,0,fileCursorX,fileCursorY,1,1,0,titleCl,1)
    
    //Display save file used
    draw_set_font(fnt_StatRender)
    draw_set_halign(fa_right)
    textDropShadow("Active Save",478,-1,c_white,c_black,1)
    textDropShadow(global.paraString[0],478,9,c_white,c_black,1)
    //Display game modes active
    draw_set_halign(fa_left)
    if global.bNightmareMode=1 {textDropShadow("*Nightmare Mode*",2,146,c_white,c_black,1)}
    if global.bOneHitKillMode=1 {textDropShadow("*Achilles Mode*",2,156,c_white,c_black,1)}
    if global.permaEasyMode=1 {textDropShadow("*Easy Mode*",2,166,c_white,c_black,1)}
    if global.modeDark=1 {textDropShadow("*Dark Mode*",2,176,c_white,c_black,1)}
    if global.modeSpeed=1 {textDropShadow("*2x Speed Mode*",2,186,c_white,c_black,1)}
    
    if global.bNightmareMode=1 and global.bOneHitKillMode=1 //Red tint on title screen if Night Terror is on
    {
      if nmm_redPulse=0
      {
        nmm_redAlpha+=0.005
        if nmm_redAlpha>=0.35 {nmm_redPulse=1}
      }
      else if nmm_redPulse=1
      {
        nmm_redAlpha-=0.005
        if nmm_redAlpha<=0.2 {nmm_redPulse=0}
      }
      draw_set_alpha(nmm_redAlpha)
      draw_set_color(c_red)
      draw_rectangle(-1,-1,room_width+1,room_height+1,0)
    }
  }
}
