loadImage=false
versionTag="1.5.2.4 - [The Saved Edition] - 60FPS"
//Load external files
if !variable_global_exists("gamePriority")
{
  SS_Init()
  loadExtFiles()
  scrSoundGainInit() //sound volume change (added): the sound effects' loudness adjustments (playSound)
  global.gamePriority=0     //initialize game priority var (loading purposes as well)
  global.sessionPlayTime=0  //how long the player has been playing this play session
}
stopAllMusic()
stopLoopingSounds()
global.debugMenu=1
global.location=0
titleBirdNum=0
initGameVars()

//saves folder change (added): whether the options file is being made for the first time (there's none, or an empty
//one), before loadOptions reads it. If a save is moved in from the game's folder below, its options are used (scrOptionsFromSave)
var tOptNew;
tOptNew=!scrFileHas(global.saveDir+"DT3Options.dts")
loadOptions()
scrModInit() //mods change (added): finds the mods in the Mods folder and loads the ones turned on (once)

//Check ini
sectionRead=""
locCheck=0

//save slots change (added): New Game and Continue pick one of five save slots, DT3data.dts and DT3data2.dts to DT3data5.dts (the options
//in DT3Options.dts are shared by all of them). global.saveSlot is the slot in use, or 0 when the save file came from the
//command line or the 'save NAME' code: then New Game and Continue use that file directly, as before.
if !variable_global_exists("saveSlot")
{
  if parameter_count()=0
  {
    //saves folder change (added): the slots' saves (and their backups) from before the Saves folder, in the game's folder,
    //are moved into it, once (DT3Options.dts: 502)
    if global.savesFolderMoved=0
    {
      var tMvI,tMvName;
      for(tMvI=1;tMvI<=5;tMvI+=1)
      {
        tMvName="DT3data"+string(tMvI)+".dts"
        //if file_exists(tMvName) and !file_exists(global.saveDir+tMvName) {file_copy(tMvName,global.saveDir+tMvName)}
        scrSaveMove(tMvName) //saves folder change: moved instead of copied, like DT3data.dts and DT3Options.dts (scrSaveMove)
        tMvName="DT3data"+string(tMvI)+"backup.dts"
        //if file_exists(tMvName) and !file_exists(global.saveDir+tMvName) {file_copy(tMvName,global.saveDir+tMvName)}
        scrSaveMove(tMvName) //saves folder change: moved instead of copied
      }
      global.savesFolderMoved=1
      saveOptions()
    }
    //the save from before the slots (DT3data.dts) becomes slot 1, once
    if global.saveSlotsMoved=0
    {
      //if file_exists("DT3data.dts") and !file_exists("DT3data1.dts") {file_copy("DT3data.dts","DT3data1.dts")}
      //if file_exists("DT3data.dts") and !file_exists(global.saveDir+"DT3data1.dts") {file_copy("DT3data.dts",global.saveDir+"DT3data1.dts")} //saves folder change: into the Saves folder
      //save slots change: slot 1 is DT3data.dts now (scrSlotFile), copied in below
      global.saveSlotsMoved=1
      saveOptions()
    }
    //save slots change (added): slot 1's file is DT3data.dts in the Saves folder (scrSlotFile). If it isn't there yet, it's
    //copied in, once (DT3Options.dts: 503), from slot 1's old file (DT3data1.dts, in the Saves folder or the game's folder,
    //which has the newest slot 1 progress). The old files are left where they are. DT3data.dts in the game's folder is
    //moved in after this (scrSaveMove)
    if global.slot1Moved=0
    {
      var tS1From;
      tS1From=""
      if file_exists(global.saveDir+"DT3data1.dts") {tS1From=global.saveDir+"DT3data1.dts"}
      else if file_exists("DT3data1.dts") {tS1From="DT3data1.dts"}
      //else if file_exists("DT3data.dts") {tS1From="DT3data.dts"} //saves folder change: DT3data.dts in the game's folder is moved in below instead (scrSaveMove)
      if tS1From!="" and tS1From!=scrSlotFile(1) and !file_exists(scrSlotFile(1)) {file_copy(tS1From,scrSlotFile(1))}
      if file_exists(global.saveDir+"DT3data1backup.dts") and !file_exists(global.saveDir+"DT3databackup.dts") {file_copy(global.saveDir+"DT3data1backup.dts",global.saveDir+"DT3databackup.dts")}
      global.slot1Moved=1
      saveOptions()
    }
    //saves folder change (added): every time the game starts, the save in the game's folder (DT3data.dts, the original
    //game's save) is moved into the Saves folder as slot 1's save if the Saves folder doesn't have one (scrSaveMove).
    //If neither has one, it's made as before. When the options file is new too, the options are taken from that save
    //(the original game kept them in it: scrOptionsFromSave)
    if scrSaveMove("DT3data.dts") and tOptNew {scrOptionsFromSave(scrSlotFile(1))}
    global.saveSlot=global.lastSaveSlot //the slot played last (DT3Options.dts) is the one shown on the right
    //global.paraString[0]="DT3data"+string(global.saveSlot)+".dts"
    //global.paraString[0]=global.saveDir+"DT3data"+string(global.saveSlot)+".dts" //saves folder change: in the Saves folder
    global.paraString[0]=scrSlotFile(global.saveSlot) //save slots change: slot 1 is DT3data.dts
  }
  else {global.saveSlot=0}
}
slotMenu=0      //1: the slot list for New Game, 2: for Continue
slotCursorPos=1
//save slots change (added): the true end message (and the list of codes) shows when any save has reached the true end
//(the five slots, and the save file in use if it isn't one of them). Files that aren't there are skipped, not created
titleTrueEnd=0
var tTrueI,tTrueFile;
for(tTrueI=0;tTrueI<=5;tTrueI+=1)
{
  if tTrueI=0 {tTrueFile=global.paraString[0]}
  //else {tTrueFile="DT3data"+string(tTrueI)+".dts"}
  //else {tTrueFile=global.saveDir+"DT3data"+string(tTrueI)+".dts"} //saves folder change: in the Saves folder
  else {tTrueFile=scrSlotFile(tTrueI)} //save slots change: slot 1 is DT3data.dts
  if file_exists(tTrueFile)
  {
    ini_open(tTrueFile)
    if ini_read_real("ALPHA","144",0)=2 {titleTrueEnd=1}
    ini_close()
  }
}
codeNightmare=0 //modes turned on with codes on this screen, for a new game (event_user(0) keeps them while looking through the slots)
codeAchilles=0
codeEasy=0

event_user(0)

if locCheck>0 {titleLocation=locationCheck(locCheck)}
else {titleLocation=""}

//SS_LoopSound(global.msc_TitleMenu); SS_SetSoundVol(global.msc_TitleMenu,global.optMusic*100)
SS_LoopSound(global.msc_TitleMenu); SS_SetSoundVol(global.msc_TitleMenu,scrMusicVolume(getReplayGain(9000))) //remastered music change: the same volume as the rest of the music (scrMusicVolume), with the title music's own loudness adjustment
window_set_size(480*global.optWindowSize,352*global.optWindowSize)
window_center()

global.gamePaused=true

//Initialize start up screen --------------------------------------------------
if progressCheck=0
{
  fileCursorPos=1
  //fileCursorY=150
  fileCursorY=147 //title options change: five buttons on a 19px step now (sFileMain)
}
else //Start cursor on "Continue" if the player has a saved game in progress
{
  fileCursorPos=2
  //fileCursorY=175
  fileCursorY=166 //title options change
}
fileCursorX=120
//cursorMoveInc=25
//arraySizeMax=4
cursorMoveInc=19 //title options change: New Game, Continue, Options, Back Story, Exit Game
arraySizeMax=5 //title options change
if global.modCount>0 {arraySizeMax=6} //mods change (added): and Mods, when there are mods in the Mods folder

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
