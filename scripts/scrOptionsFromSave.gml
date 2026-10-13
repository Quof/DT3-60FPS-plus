/*
saves folder change (added): the original game kept its options, the hats being worn and the keyboard controls in the
save file (DT3data.dts), under the same keys DT3Options.dts uses now. When the options file is made for the first time
and a save from the game's folder was moved into the Saves folder (oInitializeGame), the options are taken from that
save. Only the ones set to something other than the original's default are taken, as those are the ones the player
changed. The rest keep this version's defaults, as several of those changed (VSync, the gamepad, the window size, the
dash settings, the map header). The original's gamepad presets (236) are gone, so they aren't taken. The menus' Confirm
and Cancel keys follow Jump and Action A, the keys the original's menus used. Then the options are saved.
argument0: the save file
*/
var tS,tV;
if !scrFileHas(argument0) {exit}
ini_open(argument0)
tS="ALPHA"
//the hats being worn
tV=ini_read_real(tS,"147",0); if tV!=0 {global.wearingHatJ=tV}
tV=ini_read_real(tS,"148",0); if tV!=0 {global.wearingHatC=tV}
//the options (each with the original's default)
tV=ini_read_real(tS,"201",95); if tV!=95 {global.optMusic=tV}
tV=ini_read_real(tS,"202",95); if tV!=95 {global.optSound=tV}
tV=ini_read_real(tS,"203",1); if tV!=1 {global.optShowPointsEarned=tV}
tV=ini_read_real(tS,"204",1); if tV!=1 {global.optShowDamage=tV}
tV=ini_read_real(tS,"205",1); if tV!=1 {global.optEnemyHP=tV}
tV=ini_read_real(tS,"206",1); if tV!=1 {global.optLowHealthWarn=tV}
tV=ini_read_real(tS,"207",1); if tV!=1 {global.optShowArea=tV}
tV=ini_read_real(tS,"208",1); if tV!=1 {global.optShowCombatAward=tV}
tV=ini_read_real(tS,"211",0); if tV!=0 {global.optKeepMenuPos=tV}
tV=ini_read_real(tS,"212",0); if tV!=0 {global.gamePriority=tV}
tV=ini_read_real(tS,"213",1); if tV!=1 {global.optVSync=tV}
tV=ini_read_real(tS,"214",1); if tV!=1 {global.optShowHUD=tV}
tV=ini_read_real(tS,"215",3); if tV!=3 {global.optCursorRepeat=tV}
tV=ini_read_real(tS,"217",1); if tV!=1 {global.optAtkTShow=tV}
tV=ini_read_real(tS,"218",1); if tV!=1 {global.optShowChainMeter=tV}
tV=ini_read_real(tS,"219",0); if tV!=0 {global.optShowHoverInfo=tV}
tV=ini_read_real(tS,"220",30); if tV!=30 {global.optSplitWindow=tV}
tV=ini_read_real(tS,"221",1); if tV!=1 {global.optChaoRoam=tV}
tV=ini_read_real(tS,"222",0); if tV!=0 {global.optGamePad=tV}
tV=ini_read_real(tS,"223",0); if tV!=0 {global.optShowKeyState=tV}
tV=ini_read_real(tS,"224",1); if tV!=1 {global.optWindowSize=tV}
tV=ini_read_real(tS,"225",1); if tV!=1 {global.optShowScore=tV}
tV=ini_read_real(tS,"226",1); if tV!=1 {global.optShowMoney=tV}
tV=ini_read_real(tS,"227",0); if tV!=0 {global.optCentralizeHUD=tV}
tV=ini_read_real(tS,"228",0); if tV!=0 {global.optMessagePlink=tV}
tV=ini_read_real(tS,"229",1); if tV!=1 {global.optDPadDash=tV}
tV=ini_read_real(tS,"230",0); if tV!=0 {global.optRightIsForward=tV}
tV=ini_read_real(tS,"231",1); if tV!=1 {global.optCanResizeWindow=tV}
tV=ini_read_real(tS,"232",0); if tV!=0 {global.optUnrealGuyChainAudio=tV}
tV=ini_read_real(tS,"233",0); if tV!=0 {global.optUnrealGuyChainVisual=tV}
tV=ini_read_real(tS,"234",0); if tV!=0 {global.optUnrealGuySpreeAudio=tV}
tV=ini_read_real(tS,"235",0); if tV!=0 {global.optUnrealGuySpreeVisual=tV}
tV=ini_read_real(tS,"237",0); if tV!=0 {global.optChaoAttack=tV}
tV=ini_read_real(tS,"238",0); if tV!=0 {global.optShowMapHeader=tV}
tV=ini_read_real(tS,"239",1); if tV!=1 {global.optBitrateExplosion=tV}
tV=ini_read_real(tS,"240",0); if tV!=0 {global.optPlayerTrail=tV}
tV=ini_read_real(tS,"241",0); if tV!=0 {global.optWeaponTrail=tV}
tV=ini_read_real(tS,"242",0); if tV!=0 {global.optDeathCounter=tV}
tV=ini_read_real(tS,"243",100); if tV!=100 {global.optUnrealVolume=tV}
tV=ini_read_real(tS,"244",1); if tV!=1 {global.optUnrealPitch=tV}
tV=ini_read_real(tS,"245",0); if tV!=0 {global.optNoBounce=tV}
tV=ini_read_real(tS,"246",0); if tV!=0 {global.optDashWarn=tV}
tV=ini_read_real(tS,"247",1); if tV!=1 {global.optChaoItemWarn=tV}
tV=ini_read_real(tS,"248",1); if tV!=1 {global.optMorphControls=tV}
tV=ini_read_real(tS,"249",0); if tV!=0 {global.optSwapType=tV}
tV=ini_read_real(tS,"250",0.4); if tV!=0.4 {global.optStickDeadZone=tV}
//the keyboard controls
tV=ini_read_string(tS,"301","W"); if tV!="W" {global.ctrlUp=tV}
tV=ini_read_string(tS,"302","S"); if tV!="S" {global.ctrlDown=tV}
tV=ini_read_string(tS,"303","A"); if tV!="A" {global.ctrlLeft=tV}
tV=ini_read_string(tS,"304","D"); if tV!="D" {global.ctrlRight=tV}
tV=ini_read_string(tS,"305","J"); if tV!="J" {global.ctrlJump=tV}
tV=ini_read_string(tS,"306","U"); if tV!="U" {global.ctrlCharSwap=tV}
tV=ini_read_string(tS,"307","I"); if tV!="I" {global.ctrlAbilSwap=tV}
tV=ini_read_string(tS,"308","K"); if tV!="K" {global.ctrlActA=tV}
tV=ini_read_string(tS,"309","L"); if tV!="L" {global.ctrlActB=tV}
tV=ini_read_string(tS,"310","O"); if tV!="O" {global.ctrlActC=tV}
tV=ini_read_string(tS,"311","Q"); if tV!="Q" {global.ctrlDashLeft=tV}
tV=ini_read_string(tS,"312","E"); if tV!="E" {global.ctrlDashRight=tV}
ini_close()
global.ctrlConfirm=global.ctrlJump
global.ctrlCancel=global.ctrlActA
saveOptions()
