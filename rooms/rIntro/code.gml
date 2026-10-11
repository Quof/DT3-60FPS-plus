set_application_title("DT3: Saved Game Remastered (60FPS)")

//Initialize
globalvar gDeltaTime, gDeltaDoTicks, gDeltaTick;
global.modeSpeed=0
global.gameFrameRate=120
gDeltaTime = 30/global.gameFrameRate
gDeltaDoTicks = 0
gDeltaTick = 0.0

global.objectIDMap = ds_map_create()

global.paraString[0]="DT3data.dts"
//saves folder change (added): the save files and the options (DT3Options.dts: loadOptions, saveOptions) go in a Saves
//folder in the game's folder, made here if it isn't there (a save file given on the command line is used where it is).
//If it can't be made, they stay in the game's folder as before
global.saveDir=working_directory+"\Saves\"
if !directory_exists(global.saveDir) {directory_create(global.saveDir)}
if !directory_exists(global.saveDir) {global.saveDir=""}
//options from before (in the game's folder) are copied into the Saves folder if it has none yet; the old file is left
if global.saveDir!=""
{
  if !file_exists(global.saveDir+"DT3Options.dts") and file_exists("DT3Options.dts") {file_copy("DT3Options.dts",global.saveDir+"DT3Options.dts")}
}

//Check if command line arguments were given
var pNum;
pNum=parameter_count()
if pNum>0
{
  var i;
  for(i=0;i<pNum;i+=1)
  {
    global.paraString[i]=parameter_string(i+1)
  }
}
global.initialSave = global.paraString[0]
//save slots change (added): 1 while a new game started over a slot's save hasn't been saved yet: that save stays and
//oGame doesn't autosave till then (see oInitializeGame)
global.saveSlotNewGame=0

global.bNightmareMode=0
global.bCanUseEsc=1
global.ctrlUp="W"
global.ctrlDown="S"
global.ctrlLeft="A"
global.ctrlRight="D"
global.ctrlJump="J"
global.ctrlCharSwap="U"
global.ctrlAbilSwap="I"
global.ctrlActA="K"
global.ctrlActB="L"
global.ctrlActC="O"
//controls change (added): the menu's Confirm/Cancel, Pause and Cutscene Skip keys (scrController reads them)
global.ctrlConfirm="J"
global.ctrlCancel="K"
global.ctrlPause="P"
global.ctrlSkip="M"
if !instance_exists(oKeyCodes)
{
  instance_create(0,0,oKeyCodes)
}
if !instance_exists(oKeyCodesHighFPS)
{
  instance_create(0,0,oKeyCodesHighFPS)
}
room_goto(rTitle)
