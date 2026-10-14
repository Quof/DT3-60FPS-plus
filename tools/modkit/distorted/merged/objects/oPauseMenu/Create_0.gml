//title options change (added): opened from the title screen's Options entry (oInitializeGame). Only the Options submenu
//is used there, and no game is running (no player, HUD or Chao), so what needs them is skipped or guarded. Closing it
//saves the options to DT3Options.dts (saveOptions) and goes back to the title menu.
titleMode=(room=rTitle)
//global.recMenuOpenNum+=1
if titleMode=0 {global.recMenuOpenNum+=1} //title options change: a game record (saved in the game save)
image_speed=0.1
textColorMain=make_color_rgb(240,240,240)
textColorShadow=make_color_rgb(0,120,72)
colorStatFill=make_color_rgb(16,96,104)
colorLineProg=make_color_rgb(0,120,48)
colorFillInstr=make_color_rgb(7,177,83)
colorRecognitionBox=make_color_rgb(0,102,120)
colorRecogTop=make_color_rgb(255,239,66)
colorRecogBottom=make_color_rgb(216,146,4)
colorRecogShadow=make_color_rgb(49,33,24)
event_user(0)

cursorRepeatMove=0
subMenu=0
if global.optKeepMenuPos>0 {mainCurPos=global.optKeepMenuPos-10}
else {mainCurPos=1}
mainInc=20
mainMax=9
mainCurX=15
mainCurY=28+((mainCurPos-1)*mainInc)
if titleMode=1 //title options change (added): straight into Options
{
  mainCurPos=7
  mainCurY=28+((mainCurPos-1)*mainInc)
  subMenu=7
  //The title reads oKeyCodesHighFPS (every frame) but this menu reads oKeyCodes (30fps ticks only). At 60/120fps the
  //Confirm press that opened the menu could still be new to oKeyCodes on its next tick and activate the first option
  //(Change Controls) straight away. Mark whatever is held right now as already held.
  //for(i=1;i<=14;i+=1)
  //for(i=1;i<=16;i+=1) //gamepad change: + menu Confirm/Back
  for(i=1;i<=18;i+=1) //gamepad change: + menu Confirm/Back //options tabs change: + 17/18, the Options tabs (U/L1, I/R1)
  {
    oKeyCodes.kCode[i]=scrController(i)
    oKeyCodes.kCodePressed[i]=0
  }
}

sawBirdHatJ=0
sawBirdHatC=0

//---------- Submenu Variables ----------
//Menu - Progress
mP_Spinner=0
mP_Page=1
mP_PageCurInc=15
mP_PageMax=1
mP_PageCurX=20

for(i=0;i<8;i+=1)
{
  instrProg[i]=string_char_at(global.eGateProg,i+1)
}

//Menu - Equipment
mEq_CurX=70
mEq_CurY=151
mEq_CurPos=1

//Menu - Ability Set
mAS_Character="JERRY"
mAS_Ability="LINK"
//-- 0: Ability Level
//-- 1: Ability Exp
//-- 2: Ability Next
//-- 3: Ability Power
//-- 4: Ability Name
//-- 5: Ability Description
for(i=0;i<6;i+=1)
{
  if i<=3
  {
    mAS_AbilA[i]=0
    mAS_AbilB[i]=0
    mAS_AbilC[i]=0
    mAS_AbilType[i]=""
    mAS_AbilIcon[i]=0
  }
  else if i>=4
  {
    mAS_AbilA[i]=""
    mAS_AbilB[i]=""
    mAS_AbilC[i]=""
  }
}

//Menu - Spend AP
mSAP_FrameCount=0
mSAP_CurFrame=0
mSAP_CurX=11
mSAP_CurY=10

info_Name=""
info_Index=-1
info_Lv=0
info_Max=0
info_Cost=0

//Menu - Map
mMap_Submenu=1
mMap_Max=1 //Mainland
if global.gameProgress>=725 and global.gameProgress<=830 {mMap_Max=2} //Gate 2 - Forest Palace
if global.gameProgress>=840 {mMap_Max=3} //Gate 3 - Water Palace

mMap_CurX=19; mMap_CurY=10
if global.location=1 {mMap_CurX=7; mMap_CurY=8}
else if global.location=2 {mMap_CurX=8; mMap_CurY=9}
else if global.location=3 {mMap_CurX=10; mMap_CurY=8}
else if global.location=4 {mMap_CurX=11; mMap_CurY=8}
else if global.location=5 {mMap_CurX=14; mMap_CurY=8}
else if global.location=6 {mMap_CurX=14; mMap_CurY=7}
else if global.location=7 {mMap_CurX=13; mMap_CurY=7}
else if global.location=8 {mMap_CurX=17; mMap_CurY=8}
else if global.location=9 {mMap_CurX=19; mMap_CurY=10}
else if global.location=10 {mMap_CurX=15; mMap_CurY=7}
else if global.location=11 {mMap_CurX=21; mMap_CurY=8}
else if global.location=12 {mMap_CurX=24; mMap_CurY=8}
else if global.location=13 {mMap_CurX=26; mMap_CurY=7}
else if global.location=14 {mMap_CurX=27; mMap_CurY=7}
else if global.location=15 {mMap_CurX=29; mMap_CurY=7}
else if global.location=16 {mMap_CurX=27; mMap_CurY=9}
else if global.location=17 {mMap_CurX=24; mMap_CurY=9}
else if global.location=18 {mMap_CurX=11; mMap_CurY=7}
else if global.location=19 {mMap_CurX=13; mMap_CurY=10}
else if global.location=20 {mMap_CurX=16; mMap_CurY=11}
else if global.location=21 {mMap_CurX=13; mMap_CurY=11}
else if global.location=22 {mMap_CurX=11; mMap_CurY=11}
else if global.location=23 {mMap_CurX=9; mMap_CurY=11}
else if global.location=24 {mMap_CurX=8; mMap_CurY=12}
else if global.location=25 {mMap_CurX=17; mMap_CurY=13}
else if global.location=26 {mMap_CurX=15; mMap_CurY=13}
else if global.location=27 {mMap_CurX=13; mMap_CurY=12}
else if global.location=28 {mMap_CurX=10; mMap_CurY=13}
else if global.location=29 {mMap_CurX=9; mMap_CurY=13}
else if global.location=30 {mMap_CurX=26; mMap_CurY=10}
else if global.location=31 {mMap_CurX=27; mMap_CurY=10}
else if global.location=32 {mMap_CurX=29; mMap_CurY=10}
else if global.location=33 {mMap_CurX=28; mMap_CurY=11}
else if global.location=34 {mMap_CurX=31; mMap_CurY=9}
else if global.location=35 {mMap_CurX=32; mMap_CurY=11}
else if global.location=36 {mMap_CurX=29; mMap_CurY=12}
else if global.location=37 {mMap_CurX=31; mMap_CurY=11}
else if global.location=38 {mMap_CurX=26; mMap_CurY=11}
else if global.location=39 {mMap_CurX=25; mMap_CurY=11}
else if global.location=40 {mMap_CurX=24; mMap_CurY=11}
else if global.location=41 {mMap_CurX=19; mMap_CurY=11}
else if global.location=42 {mMap_CurX=21; mMap_CurY=12}
else if global.location=43 {mMap_CurX=22; mMap_CurY=10}
else if global.location=44 {mMap_CurX=21; mMap_CurY=14}
else if global.location=45 {mMap_CurX=17; mMap_CurY=14}
else if global.location=46 {mMap_CurX=14; mMap_CurY=14}
else if global.location=47 {mMap_CurX=14; mMap_CurY=16}
else if global.location=48 {mMap_CurX=18; mMap_CurY=16}
else if global.location=49 {mMap_CurX=21; mMap_CurY=17}
else if global.location=50 {mMap_CurX=24; mMap_CurY=14}
else if global.location=51 {mMap_CurX=27; mMap_CurY=15}
else if global.location=52 {mMap_CurX=30; mMap_CurY=15}
else if global.location=53 {mMap_CurX=32; mMap_CurY=14}
else if global.location=54 {mMap_CurX=32; mMap_CurY=16}
else if global.location=55 {mMap_CurX=34; mMap_CurY=15}
else if global.location=56 {mMap_CurX=36; mMap_CurY=15}
else if global.location=57 {mMap_CurX=32; mMap_CurY=15}
else if global.location=58 {mMap_CurX=36; mMap_CurY=16}
else if global.location=59 {mMap_CurX=4; mMap_CurY=10}
else if global.location=60 {mMap_CurX=11; mMap_CurY=10}
else if global.location=61 {mMap_CurX=21; mMap_CurY=6}
else if global.location=62 {mMap_CurX=24; mMap_CurY=6}
else if global.location=63 {mMap_CurX=26; mMap_CurY=5}
else if global.location=64 {mMap_CurX=21; mMap_CurY=4}
else if global.location=65 {mMap_CurX=18; mMap_CurY=4}
else if global.location=66 {mMap_CurX=16; mMap_CurY=4}
else if global.location=67 {mMap_CurX=13; mMap_CurY=4}
else if global.location=68 {mMap_CurX=15; mMap_CurY=6}
else if global.location=69 {mMap_CurX=11; mMap_CurY=4}
else if global.location=70 {mMap_CurX=11; mMap_CurY=5}
else if global.location=71 {mMap_CurX=24; mMap_CurY=3}
else if global.location=72 {mMap_CurX=8; mMap_CurY=6}
else if global.location=73 {mMap_CurX=8; mMap_CurY=8}
else if global.location=74 {mMap_CurX=6; mMap_CurY=5}
else if global.location=75 {mMap_CurX=23; mMap_CurY=16}
else if global.location=76 {mMap_CurX=26; mMap_CurY=16}
else if global.location=77 {mMap_CurX=29; mMap_CurY=8}
else if global.location=78 {mMap_CurX=31; mMap_CurY=7}
else if global.location=79 {mMap_CurX=26; mMap_CurY=6}
else if global.location=80 {mMap_CurX=28; mMap_CurY=5}
else if global.location=81 {mMap_CurX=31; mMap_CurY=5}
else if global.location=82 {mMap_CurX=30; mMap_CurY=7}
else if global.location=83 {mMap_CurX=29; mMap_CurY=4}
else if global.location=84 {mMap_CurX=32; mMap_CurY=4}
else if global.location=85 {mMap_CurX=34; mMap_CurY=4}
else if global.location=86 {mMap_CurX=35; mMap_CurY=4}
else if global.location=87 {mMap_CurX=11; mMap_CurY=16}
else if global.location=88 {mMap_CurX=10; mMap_CurY=16}
else if global.location=89 {mMap_CurX=26; mMap_CurY=13}
else if global.location=90 {mMap_CurX=28; mMap_CurY=13}
else if global.location=91 {mMap_CurX=4; mMap_CurY=9}
else if global.location=92 {mMap_CurX=33; mMap_CurY=9}
else if global.location=93 {mMap_CurX=33; mMap_CurY=7}
else if global.location=94 {mMap_CurX=4; mMap_CurY=8}
else if global.location=95 {mMap_CurX=24; mMap_CurY=12}
else if global.location=96 {mMap_CurX=33; mMap_CurY=5}
else if global.location=97 {mMap_CurX=33; mMap_CurY=11}
else if global.location=98 {mMap_CurX=10; mMap_CurY=6}
else if global.location=99 {mMap_CurX=3; mMap_CurY=5}
else if global.location=101 {mMap_CurX=3; mMap_CurY=13}
else if global.location=102 {mMap_CurX=5; mMap_CurY=13}
else if global.location=103 {mMap_CurX=6; mMap_CurY=14}
else if global.location=104 {mMap_CurX=6; mMap_CurY=16}
else if global.location=105 {mMap_CurX=5; mMap_CurY=17}
else if global.location=106 {mMap_CurX=3; mMap_CurY=17}
else if global.location=107 {mMap_CurX=2; mMap_CurY=16}
else if global.location=108 {mMap_CurX=2; mMap_CurY=14}
else if global.location=109 {mMap_CurX=4; mMap_CurY=15}
else if global.location=110 {mMap_CurX=35; mMap_CurY=10}
else if global.location=111 {mMap_CurX=38; mMap_CurY=10}    //spsp

for(i=0;i<=110;i+=1)
{
  mapIndexCheck[i]=string_char_at(global.mapAreas,i)
}
for(i=0;i<=12;i+=1)
{
  mapExtIndex2[i]=string_char_at(global.mapExt2,i)
}
for(i=0;i<=13;i+=1)
{
  mapExtIndex3[i]=string_char_at(global.mapExt3,i)
}

mMap_FrameCount=0
mMap_CurFrame=0
mapDetails=0
coll_HeartP=0
coll_Chest=0
coll_Arrow=0
coll_HeartE=0
coll_Missile=0
coll_Ki=0
coll_Air=0
coll_Wallet=0
max_HeartP=0
max_Chest=0
max_Arrow=0
max_HeartE=0
max_Missile=0
max_Ki=0
max_Air=0
max_Wallet=0

//Menu - Records / Recognitions
mR_Page=1
mR_CurInc=15
mR_PageMax=7
mR_CurX=291
mR_CurY=30
mR_Tab=1 //1:Records  -  2: Recognitions
mR_RecPageMax=11
mR_RecCurPos=1
mR_CurRecInc=11

//Menu - Options
mO_CurPos=1
mO_CurX=24
mO_CurY=37+12
mO_OptMax=8
mO_OptSubMenu=1
//mO_OptConMax=7 //Gamepad profile num
//gamepad change: the gamepad presets are gone (Gamepad Setup is now a list like CONTROLS, see subMenu 14)
mO_CtrlItem=1 //niche dash change (added): the Control option on the cursor's row (set in the Step, see subMenu 7)
//1: Control
//2: Graphics
//3: Display
//4: Gameplay
//5: Unreal Guy
//6: Audio
maxHats=15

//Menu - Customize Remastered Changes (dipswitch change (added): Options > Gameplay, the dipswitch list in remasterSwitchList)
mDS_CurPos=1

//Menu - Gamepad Setup (gamepad change (added): Options > Control, the GAMEPAD list, subMenu 14)
mGP_CurPos=1      //1-16: actions (global.gpRowAct), 17: Set to Default (controls change: was 1-12, 13)
mGP_Listen=0      //1: waiting for a button on the pad
mGP_ListenTime=0
mGP_WaitRelease=0 //1: waiting for everything on the pad to be let go first

//Menu - Color Zone Colors (color zone change (added): Options > Graphics; subMenu 16 is the zone list, 17 changes one)
mCZ_CurPos=1  //zone 1-4
mCZ_EditPos=1 //1-3: red/green/blue, 4: Default
mCZ_Hold=0    //ticks left/right has been held (changes speed up)
//The option only shows once this save has seen the color zones: they first show up in the Vault, and its "Color Zones"
//scene ends at gameProgress 2370. On the title screen that's the save shown there (oInitializeGame.progressCheck).
//Without it, Graphics is laid out as before (the hats on rows 9 and 10).
mCZ_Show=0
if titleMode=1 {if instance_exists(oInitializeGame) {if oInitializeGame.progressCheck>=2370 {mCZ_Show=1}}}
else if global.gameProgress>=2370 {mCZ_Show=1}
//mCZ_HatRow=9+mCZ_Show //Graphics row of Jerry's Hat (Claire's Hat is the next one)
mCZ_HatRow=10 //options move change: Display row of Jerry's Hat (Claire's Hat is the next one); the hats are on Display now

//Menu - Save
mS_CurPos=1
mS_CurInc=26
mS_CurMax=4
mS_CurX=15
mS_CurY=30

//Menu - Controls
mCon_CurPos=1
mCon_CurInc=12
//mCon_CurMax=13
mCon_CurMax=17 //controls change: + Confirm, Cancel, Pause, Cutscene Skip
mCon_CurX=16
mCon_CurY=22

//Menu - Items
mItem_CurX=1
mItem_CurY=1
mItem_CurInc=31

menuInfoText=""
//---------- Input Commands ----------
curInfo=vk_f1

//---------- Extra Item Check ----------
for(i=0;i<3;i+=1)
{
  //bottles[i]=string_char_at(global.extraItems,i+1)
  //bottles[i]=oPlayer1.pBottles[i]
  if instance_exists(oPlayer1) {bottles[i]=oPlayer1.pBottles[i]} //title options change: there's no player on the title screen
  else {bottles[i]="0"}
}
//---------- Item Check ----------
for(i=0;i<40;i+=1)
{
  eCheck[i]=string_char_at(global.equipItems,i+1)
  items[i]=string_char_at(global.equipItems,i+1)
  if items[i]!="0" {items[i]=i+1}
  else {items[i]=0}
}

//Achievement
//global.gamePercent=checkItemPercent(0)
//if global.gamePercent=100
if titleMode=0 {global.gamePercent=checkItemPercent(0)} //title options change: no game loaded on the title screen
if global.gamePercent=100 and titleMode=0 //title options change
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,6)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNoticeSS)
    tAchievement.myAchievement="Item Collector"; tAchievement.checkNum=6
  }
}

confirmationMenu=0
confirmMenuPos=1 //0:Confirm, 1:Cancel

//jukebox change (added): where the music playing is from, for "Music From" in the bottom right (scrMusicCredit, Draw)
mMusicCredit=""
if titleMode=0 and global.currentMusic!=0
{
  var tMusicPlay;
  tMusicPlay=findMusic(global.currentMusic)
  if SS_IsSoundPlaying(tMusicPlay) or SS_IsSoundLooping(tMusicPlay) {mMusicCredit=scrMusicCredit(global.currentMusic)}
}
