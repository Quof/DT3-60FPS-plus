ini_open("DT3Options.dts")
var sectionRead,tempVar;

sectionRead="ALPHA"
var tempVar;
global.wearingHatJ=ini_read_real(sectionRead,"147",0)
global.wearingHatC=ini_read_real(sectionRead,"148",0)

global.optMusic=ini_read_real(sectionRead,"201",95)
global.optSound=ini_read_real(sectionRead,"202",95)
global.optShowPointsEarned=ini_read_real(sectionRead,"203",1)
global.optShowDamage=ini_read_real(sectionRead,"204",1)
global.optEnemyHP=ini_read_real(sectionRead,"205",1)
global.optLowHealthWarn=ini_read_real(sectionRead,"206",1)
global.optShowArea=ini_read_real(sectionRead,"207",1)
global.optShowCombatAward=ini_read_real(sectionRead,"208",1)
global.optKeepMenuPos=ini_read_real(sectionRead,"211",0)
global.gamePriority=ini_read_real(sectionRead,"212",0)
global.optVSync=ini_read_real(sectionRead,"213",1)
global.optShowHUD=ini_read_real(sectionRead,"214",1)
global.optCursorRepeat=ini_read_real(sectionRead,"215",3)
global.optAtkTShow=ini_read_real(sectionRead,"217",1)
global.optShowChainMeter=ini_read_real(sectionRead,"218",1)
global.optShowHoverInfo=ini_read_real(sectionRead,"219",0)
global.optSplitWindow=ini_read_real(sectionRead,"220",30)
global.optChaoRoam=ini_read_real(sectionRead,"221",1)
//global.optGamePad=ini_read_real(sectionRead,"222",0)
global.optGamePad=ini_read_real(sectionRead,"222",1) //gamepad change: on by default now that pads work without extra software
global.optShowKeyState=ini_read_real(sectionRead,"223",0)
global.optWindowSize=ini_read_real(sectionRead,"224",2)
global.optShowScore=ini_read_real(sectionRead,"225",1)
global.optShowMoney=ini_read_real(sectionRead,"226",1)
global.optCentralizeHUD=ini_read_real(sectionRead,"227",0)
global.optMessagePlink=ini_read_real(sectionRead,"228",0)
//global.optDPadDash=ini_read_real(sectionRead,"229",1)
global.optDPadDash=ini_read_real(sectionRead,"229",0) //dash defaults change: off by default
//global.optRightIsForward=ini_read_real(sectionRead,"230",0)
global.optRightIsForward=ini_read_real(sectionRead,"230",1) //niche dash change: on by default (with DT4 Dashing; Left/Right Dashing is the off switch for both)
//global.optDT4Dash=ini_read_real(sectionRead,"251",0) //dt4 dash change (added): DT4 Dashing
global.optDT4Dash=ini_read_real(sectionRead,"251",1) //dt4 dash change (added): DT4 Dashing //niche dash change: on by default
global.optCanResizeWindow=ini_read_real(sectionRead,"231",1)
global.optUnrealGuyChainAudio=ini_read_real(sectionRead,"232",0)
global.optUnrealGuyChainVisual=ini_read_real(sectionRead,"233",0)
global.optUnrealGuySpreeAudio=ini_read_real(sectionRead,"234",0)
global.optUnrealGuySpreeVisual=ini_read_real(sectionRead,"235",0)
//global.optGamepadSetup=ini_read_real(sectionRead,"236",1) //gamepad change: the gamepad presets are gone (gamepad controls: keys 321-334 below)
global.optChaoAttack=ini_read_real(sectionRead,"237",0)
global.optShowMapHeader=ini_read_real(sectionRead,"238",1)
global.optBitrateExplosion=ini_read_real(sectionRead,"239",1)
global.optPlayerTrail=ini_read_real(sectionRead,"240",0)
global.optWeaponTrail=ini_read_real(sectionRead,"241",0)
global.optDeathCounter=ini_read_real(sectionRead,"242",0)
global.optUnrealVolume=ini_read_real(sectionRead,"243",100)
global.optUnrealPitch=ini_read_real(sectionRead,"244",1)
global.optNoBounce=ini_read_real(sectionRead,"245",0)
global.optDashWarn=ini_read_real(sectionRead,"246",0)
global.optChaoItemWarn=ini_read_real(sectionRead,"247",1)
global.optMLoop=ini_read_real(sectionRead,"247s",0) // music loop
global.optMorphControls=ini_read_real(sectionRead,"248",1)
global.optSwapType=ini_read_real(sectionRead,"249",0)
global.optStickDeadZone=ini_read_real(sectionRead,"250",0.4)
//fps option change (added): Options > Graphics > FPS (also F2), 60 by default. Not while the 2x Speed code mode is on (it
//sets the frame rate itself)
if global.modeSpeed=0
{
  var tFPS;
  tFPS=ini_read_real(sectionRead,"252",60)
  if tFPS!=30 and tFPS!=60 and tFPS!=120 {tFPS=60}
  scrSetFrameRate(tFPS)
}

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
global.ctrlConfirm=ini_read_string(sectionRead,"313","J") //controls change (added): menu Confirm
global.ctrlCancel=ini_read_string(sectionRead,"314","K") //controls change (added): menu Cancel
global.ctrlPause=ini_read_string(sectionRead,"315","P") //controls change (added)
global.ctrlSkip=ini_read_string(sectionRead,"316","M") //controls change (added): Cutscene Skip

//dipswitch change (added): the remaster's dipswitches (Options > Gameplay > Customize Remastered Changes), on by default
var i;
remasterSwitchList()
//for(i=0;i<global.dsCount;i+=1) {variable_global_set(global.dsVar[i],ini_read_real(sectionRead,global.dsKey[i],1))}
for(i=0;i<global.dsCount;i+=1) {variable_global_set(global.dsVar[i],ini_read_real(sectionRead,global.dsKey[i],global.dsDefault[i]))} //niche dash change: each dipswitch's own default
//niche dash change (added): without Niche Dash Settings there are only Left/Right Dashing' two setups (on: Right is Forward
//and DT4 Dashing off; off: both on), so DT4 Dashing follows Right is Forward. (Also when the dipswitch is turned off.)
if global.nicheDashSettings=0 {global.optDT4Dash=global.optRightIsForward}
//autosave change (added): Autosave is minutes between autosaves; anything but 0 (off), 5, 15 or 30 goes back to 15
if global.autosaveFreq!=0 and global.autosaveFreq!=5 and global.autosaveFreq!=15 and global.autosaveFreq!=30 {global.autosaveFreq=15}

//gamepad change (added): gamepad controls (codes: scrGamepadInit), key 320+action (Skip and Pause are always BACK/START)
scrGamepadDefaults()
//for(i=1;i<=14;i+=1)
//{
//  if i!=11 and i!=12 {global.gpBind[i]=ini_read_real(sectionRead,string(320+i),global.gpBind[i])}
//}
//controls change: all 16 now (11 Cutscene Skip, 12 Pause, 15 Confirm, 16 Cancel can be set too); missing ones keep the defaults
for(i=1;i<=16;i+=1) {global.gpBind[i]=ini_read_real(sectionRead,string(320+i),global.gpBind[i])}

//color zone change (added): Color Zone Colors (Options > Graphics), keys 261-264. By default 1 is red, 2 blue, 3 green
//and 4 yellow, the colors oColorZone always used
global.czDefault[1]=c_red; global.czDefault[2]=c_blue; global.czDefault[3]=c_green; global.czDefault[4]=c_yellow
for(i=1;i<=4;i+=1) {global.czColor[i]=ini_read_real(sectionRead,string(260+i),global.czDefault[i])}

//save slots change (added): the save slot played last (500, shown on the title screen; see oInitializeGame) and whether
//the save from before the slots (DT3data.dts) has been copied to slot 1 yet (501)
global.lastSaveSlot=median(1,round(ini_read_real(sectionRead,"500",1)),5)
global.saveSlotsMoved=ini_read_real(sectionRead,"501",0)
global.savesFolderMoved=ini_read_real(sectionRead,"502",0) //saves folder change (added): the saves from before the Saves folder have been copied into it (oInitializeGame)

ini_close()
