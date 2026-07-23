#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recMenuOpenNum+=1
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
mO_OptConMax=7 //Gamepad profile num
//1: Control
//2: Graphics
//3: Display
//4: Gameplay
//5: Unreal Guy
//6: Audio
maxHats=15

//Menu - Save
mS_CurPos=1
mS_CurInc=26
mS_CurMax=4
mS_CurX=15
mS_CurY=30

//Menu - Controls
mCon_CurPos=1
mCon_CurInc=12
mCon_CurMax=13
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
  bottles[i]=oPlayer1.pBottles[i]
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
global.gamePercent=checkItemPercent(0)
if global.gamePercent=100
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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recTimeInMenu+=1
if cursorRepeatMove>0
{
  cursorRepeatMove+=1
  if cursorRepeatMove>=global.optCursorRepeat+1
    cursorRepeatMove=0
}
if subMenu=0 //---------- Main Menu ----------
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mainCurPos=1
    {
      mainCurPos=mainMax
      mainCurY+=mainInc*(mainMax-1)
    }
    else
    {
      mainCurPos-=1
      mainCurY-=mainInc
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mainCurPos=mainMax
    {
      mainCurPos=1
      mainCurY-=mainInc*(mainMax-1)
    }
    else
    {
      mainCurPos+=1
      mainCurY+=mainInc
    }
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    resetKeyCodes()
    subMenu=mainCurPos
  }
}
else if subMenu=1 //---------- PROGRESS ----------
{
  if oKeyCodes.kCodePressed[1]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mP_Page=1
    {
      mP_Page=mP_PageMax
      mP_PageCurX+=mP_PageCurInc*(mP_PageMax-1)
    }
    else
    {
      mP_Page-=1
      mP_PageCurX-=mP_PageCurInc
    }
  }
  else if oKeyCodes.kCodePressed[2]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mP_Page=mP_PageMax
    {
      mP_Page=1
      mP_PageCurX-=mP_PageCurInc*(mP_PageMax-1)
    }
    else
    {
      mP_Page+=1
      mP_PageCurX+=mP_PageCurInc
    }
  }
}
else if subMenu=2 //---------- EQUIPMENT ----------
{
  if oKeyCodes.kCodePressed[1]=1 //Left
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mEq_CurPos=1 {mEq_CurPos=6}
    else if mEq_CurPos=2 {mEq_CurPos=1}
    else if mEq_CurPos=3 {mEq_CurPos=2}
    else if mEq_CurPos=4 {mEq_CurPos=3}
    else if mEq_CurPos=5 {mEq_CurPos=4}
    else if mEq_CurPos=6 {mEq_CurPos=5}
    else if mEq_CurPos=7 {mEq_CurPos=8}
    else if mEq_CurPos=8 {mEq_CurPos=7}
  }
  else if oKeyCodes.kCodePressed[2]=1 //Right
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mEq_CurPos=1 {mEq_CurPos=2}
    else if mEq_CurPos=2 {mEq_CurPos=3}
    else if mEq_CurPos=3 {mEq_CurPos=4}
    else if mEq_CurPos=4 {mEq_CurPos=5}
    else if mEq_CurPos=5 {mEq_CurPos=6}
    else if mEq_CurPos=6 {mEq_CurPos=1}
    else if mEq_CurPos=7 {mEq_CurPos=8}
    else if mEq_CurPos=8 {mEq_CurPos=7}
  }
  else if oKeyCodes.kCodePressed[3]=1 or oKeyCodes.kCodePressed[4]=1 //Up/Down
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mEq_CurPos=1 {mEq_CurPos=7}
    else if mEq_CurPos=2 {mEq_CurPos=7}
    else if mEq_CurPos=3 {mEq_CurPos=7}
    else if mEq_CurPos=4 {mEq_CurPos=8}
    else if mEq_CurPos=5 {mEq_CurPos=8}
    else if mEq_CurPos=6 {mEq_CurPos=8}
    else if mEq_CurPos=7 {mEq_CurPos=1}
    else if mEq_CurPos=8 {mEq_CurPos=4}
  }

  //Find cursor positions
  if mEq_CurPos=1 {mEq_CurX=70; mEq_CurY=151}
  else if mEq_CurPos=2 {mEq_CurX=104; mEq_CurY=151}
  else if mEq_CurPos=3 {mEq_CurX=138; mEq_CurY=151}
  else if mEq_CurPos=4 {mEq_CurX=184; mEq_CurY=151}
  else if mEq_CurPos=5 {mEq_CurX=218; mEq_CurY=151}
  else if mEq_CurPos=6 {mEq_CurX=252; mEq_CurY=151}
  else if mEq_CurPos=7 {mEq_CurX=152; mEq_CurY=30}
  else if mEq_CurPos=8 {mEq_CurX=170; mEq_CurY=30}

  if oKeyCodes.kCodePressed[5]=1 //Goto item menu or use potion
  {
    resetKeyCodes()
    if global.currentBoss="" //If there is no boss encounter
    {
      if global.bShooter=0 //If the player is not in the Dragoon segment
      {
        if room!=rMain_76 //If the player is in the Abomination map
        {
          var tBCursed,tCurseCheck;
          tBCursed=0
          tCurseCheck=0
          for(i=0;i<3;i+=1)
          {
            if global.activeCharacter=0
            {
              if global.equipJerry[i]=10 {tCurseCheck+=1}
              else if global.equipJerry[i]=11 {tCurseCheck+=1}
              else if global.equipJerry[i]=12 {tCurseCheck+=1}
            }
            else
            {
              if global.equipClaire[i]=10 {tCurseCheck+=1}
              else if global.equipClaire[i]=11 {tCurseCheck+=1}
              else if global.equipClaire[i]=12 {tCurseCheck+=1}
            }
          }
          if tCurseCheck=3 and global.canCharSwap=1 {tBCursed=1}

          if tBCursed=0 //If the player is not in the cursed arenas
          {
            if mEq_CurPos>=1 and mEq_CurPos<=3 //Jerry Equip Slots
            {
              if global.equipJerry[mEq_CurPos-1]>-1 {subMenu=12}
            }
            else if mEq_CurPos>=4 and mEq_CurPos<=6 //Claire Equip Slots
            {
              if global.equipClaire[mEq_CurPos-4]>-1 {subMenu=12}
            }
            else if mEq_CurPos=7 or mEq_CurPos=8 //Bottle Slots
            {
              var tHexorMsg;
              tHexorMsg=0

              if bottles[mEq_CurPos-7]="2" //Half life restored
              {
                if oPlayer1.life<oPlayer1.maxLife
                {
                  if global.activeCharacter=4 {tHexorMsg=1}
                  playSound(global.snd_HealingPlant,0,1,1)
                  global.recItemUsed+=1
                  var tLifeRecover;
                  tLifeRecover=oPlayer1.maxLife/2
                  oPlayer1.life+=tLifeRecover
                  if oPlayer1.life>oPlayer1.maxLife {oPlayer1.life=oPlayer1.maxLife}
                  oPlayer1.pBottles[mEq_CurPos-7]="1"
                  bottles[mEq_CurPos-7]="1"
                }
                else
                {
                  playSound(global.snd_Error,0,1,1)
                  msgCreate(120,120,"","Your life is already full.",7,1,oMessagePerson,0)
                  newMessage.fadingTime=35
                }
              }
              else if bottles[mEq_CurPos-7]="3" //Full life restored
              {
                if oPlayer1.life<oPlayer1.maxLife
                {
                  if global.activeCharacter=4 {tHexorMsg=1}
                  playSound(global.snd_HealingPlant,0,1,1)
                  global.recItemUsed+=1
                  oPlayer1.life=oPlayer1.maxLife
                  oPlayer1.pBottles[mEq_CurPos-7]="1"
                  bottles[mEq_CurPos-7]="1"
                }
                else
                {
                  playSound(global.snd_Error,0,1,1)
                  msgCreate(120,120,"","Your life is already full.",7,1,oMessagePerson,0)
                  newMessage.fadingTime=35
                }
              }

              if tHexorMsg=1
              {
                if room=rDistFinal_Pong
                {
                  msgCreate(260,80,"Hexor","Jeremy, stop that. Those don't work in here.",0,1,oMessagePerson,0)
                  newMessage.fadingTime=90
                }
                else
                {
                  msgCreate(260,80,"Hexor","Jeremy please. I thought we were above that.",0,1,oMessagePerson,0)
                  newMessage.fadingTime=90
                }
              }
            }
          }
          else
          {
            playSound(global.snd_Error,0,1,1)
            msgCreate(120,120,"","Can't use items or change equipment while within the cursed arena with the cursed equipment on.",7,2,oMessagePerson,0)
            newMessage.fadingTime=55
          }
        }
        else
        {
          playSound(global.snd_Error,0,1,1)
          msgCreate(120,120,"","Can't use items or change equipment in this area.",7,2,oMessagePerson,0)
          newMessage.fadingTime=45
        }
      }
      else
      {
        playSound(global.snd_Error,0,1,1)
        msgCreate(120,120,"","Can't use items or change equipment during this segment.",7,2,oMessagePerson,0)
        newMessage.fadingTime=45
      }
    }
    else
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","Can't use items or change equipment during boss fights.",7,2,oMessagePerson,0)
      newMessage.fadingTime=45
    }
  }
  else if oKeyCodes.kCodePressed[7]=1 and global.currentBoss="" //Unequip item
  {
    resetKeyCodes()
    if mEq_CurPos>=1 and mEq_CurPos<=3 //Jerry
    {
      if global.equipJerry[mEq_CurPos-1]>0
      {
        playSound(global.snd_Error,0,1,1)
        var tNewString,teSlotCheck;
        teSlotCheck=global.equipJerry[mEq_CurPos-1]-1
        tNewString=string_delete(global.equipItems,global.equipJerry[mEq_CurPos-1],1)
        tNewString=string_insert("1",tNewString,global.equipJerry[mEq_CurPos-1])
        global.equipItems=tNewString
        eCheck[teSlotCheck]="1"
        global.equipJerry[mEq_CurPos-1]=0
        //Check Speed Booster
        oPlayer1.dashRecovery=20+(global.skillTree[22]*4)
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=25 {oPlayer1.dashRecovery+=2}
        }
      }
    }
    else if mEq_CurPos>=4 and mEq_CurPos<=6 //Claire
    {
      if global.equipClaire[mEq_CurPos-4]>0
      {
        playSound(global.snd_Error,0,1,1)
        var tNewString,teSlotCheck;
        teSlotCheck=global.equipClaire[mEq_CurPos-4]-1
        tNewString=string_delete(global.equipItems,global.equipClaire[mEq_CurPos-4],1)
        tNewString=string_insert("1",tNewString,global.equipClaire[mEq_CurPos-4])
        global.equipItems=tNewString
        eCheck[teSlotCheck]="1"
        global.equipClaire[mEq_CurPos-4]=0
        //Check Speed Booster
        oPlayer1.dashRecovery=20+(global.skillTree[22]*4)
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=25 {oPlayer1.dashRecovery+=2}
        }
      }
    }
  }
  /*else if oKeyCodes.kCodePressed[8]=1 and global.currentBoss="" //Unequip all items
  {
    resetKeyCodes()
    playSound(global.snd_Error,0,1,1)
    var tNewString,tRemoveSlotJ,tRemoveSlotC;
    for(i=0;i<3;i+=1)
    {
      tRemoveSlotJ[i]=global.equipJerry[i]-1
      tRemoveSlotC[i]=global.equipClaire[i]-1
      if global.equipJerry[i]>0 {global.equipJerry[i]=0}
      if global.equipClaire[i]>0 {global.equipClaire[i]=0}
      tNewString=string_delete(global.equipItems,global.equipJerry[i],1)
      tNewString=string_insert("1",tNewString,global.equipJerry[i])
      global.equipItems=tNewString
      tNewString=string_delete(global.equipItems,global.equipClaire[i],1)
      tNewString=string_insert("1",tNewString,global.equipClaire[i])
      global.equipItems=tNewString
      if tRemoveSlotJ[i]>=0 {eCheck[tRemoveSlotJ[i]]="1"}
      if tRemoveSlotC[i]>=0 {eCheck[tRemoveSlotC[i]]="1"}
    }
    //Check Speed Booster
    oPlayer1.dashRecovery=20+(global.skillTree[22]*4)
  }*/
}
else if subMenu=3 //---------- SKILL TREE ----------
{
  if scrController(3) and cursorRepeatMove=0
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorRepeatMove=0 {cursorRepeatMove=1}
    if mSAP_CurY=2 {mSAP_CurY+=8}
    else {mSAP_CurY-=1}
  }
  else if scrController(4) and cursorRepeatMove=0
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorRepeatMove=0 {cursorRepeatMove=1}
    if mSAP_CurY=10 {mSAP_CurY-=8}
    else {mSAP_CurY+=1}
  }
  else if scrController(1) and cursorRepeatMove=0
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorRepeatMove=0 {cursorRepeatMove=1}
    if mSAP_CurX=1 {mSAP_CurX+=18}
    else {mSAP_CurX-=1}
  }
  else if scrController(2) and cursorRepeatMove=0
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorRepeatMove=0 {cursorRepeatMove=1}
    if mSAP_CurX=19 {mSAP_CurX-=18}
    else {mSAP_CurX+=1}
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    if global.pAP>=info_Cost and info_Index!=-1
    {
      if info_Lv<info_Max
      {
        playSound(global.snd_SkillGet,0,1,1)
        global.pAP-=info_Cost
        global.skillTree[info_Index]+=1

        //Scripted upgrades
        if info_Index=1 {global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)}
        else if info_Index=22 {oPlayer1.dashRecovery=24+(global.skillTree[22]*2)}
        else if info_Index=23 {oPlayer1.dashInvulnerability=9+global.skillTree[23]}
        else if info_Index=24 {oPlayer1.recoverTime=17+global.skillTree[24]}
      }
    }
  }
}
else if subMenu=4 //---------- MAP ----------
{
  if mMap_Submenu=1
  {
    if scrController(3) and cursorRepeatMove=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorRepeatMove=0 {cursorRepeatMove=1}
      if mMap_CurY=2 {mMap_CurY+=16}
      else {mMap_CurY-=1}
    }
    else if scrController(4) and cursorRepeatMove=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorRepeatMove=0 {cursorRepeatMove=1}
      if mMap_CurY=18 {mMap_CurY-=16}
      else {mMap_CurY+=1}
    }
    else if scrController(1) and cursorRepeatMove=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorRepeatMove=0 {cursorRepeatMove=1}
      if mMap_CurX=1 {mMap_CurX+=36}
      else {mMap_CurX-=1}
    }
    else if scrController(2) and cursorRepeatMove=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorRepeatMove=0 {cursorRepeatMove=1}
      if mMap_CurX=37 {mMap_CurX-=36}
      else {mMap_CurX+=1}
    }
  }

  if oKeyCodes.kCodePressed[9]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mMap_Submenu=1 {mMap_Submenu=mMap_Max}
    else {mMap_Submenu-=1}
  }
  else if oKeyCodes.kCodePressed[10]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mMap_Submenu<mMap_Max {mMap_Submenu+=1}
    else {mMap_Submenu=1}
  }
}
else if subMenu=5 //---------- ABILITY SET ----------
{
  if oKeyCodes.kCodePressed[1]=1 or oKeyCodes.kCodePressed[2]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mAS_Character="JERRY"
    {
      mAS_Character="CLAIRE"
      mAS_Ability="BELMONT"
    }
    else
    {
      mAS_Character="JERRY"
      mAS_Ability="LINK"
    }
  }

  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mAS_Character="JERRY"
    {
      if mAS_Ability="LINK" {mAS_Ability="GAME"}
      else if mAS_Ability="GAME" {mAS_Ability="MEGA MAN"}
      else if mAS_Ability="MEGA MAN" {mAS_Ability="LINK"}
    }
    else if mAS_Character="CLAIRE"
    {
      if mAS_Ability="BELMONT" {mAS_Ability="GAME"}
      else if mAS_Ability="GAME" {mAS_Ability="SAMUS"}
      else if mAS_Ability="SAMUS" {mAS_Ability="BELMONT"}
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mAS_Character="JERRY"
    {
      if mAS_Ability="LINK" {mAS_Ability="MEGA MAN"}
      else if mAS_Ability="MEGA MAN" {mAS_Ability="GAME"}
      else if mAS_Ability="GAME" {mAS_Ability="LINK"}
    }
    else if mAS_Character="CLAIRE"
    {
      if mAS_Ability="BELMONT" {mAS_Ability="SAMUS"}
      else if mAS_Ability="SAMUS" {mAS_Ability="GAME"}
      else if mAS_Ability="GAME" {mAS_Ability="BELMONT"}
    }
  }
}
else if subMenu=6 //---------- RECORDS ----------
{
  if oKeyCodes.kCodePressed[1]=1 or oKeyCodes.kCodePressed[2]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mR_Tab=1
    {
      mR_Tab=2
      mR_CurX+=15
      mR_CurY=30
    }
    else
    {
      mR_Tab=1
      mR_CurX-=15
      mR_CurY=30
    }
    mR_Page=1
  }

  if mR_Tab=1 //Records
  {
    if oKeyCodes.kCodePressed[3]=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if mR_Page=1
      {
        mR_Page=mR_PageMax
        mR_CurY+=mR_CurInc*(mR_PageMax-1)
      }
      else
      {
        mR_Page-=1
        mR_CurY-=mR_CurInc
      }
    }
    else if oKeyCodes.kCodePressed[4]=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if mR_Page=mR_PageMax
      {
        mR_Page=1
        mR_CurY-=mR_CurInc*(mR_PageMax-1)
      }
      else
      {
        mR_Page+=1
        mR_CurY+=mR_CurInc
      }
    }
  }
  else //Recognitions
  {
    if oKeyCodes.kCodePressed[3]=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if mR_Page=1
      {
        mR_Page=mR_RecPageMax
        mR_CurY+=mR_CurRecInc*(mR_RecPageMax-1)
      }
      else
      {
        mR_Page-=1
        mR_CurY-=mR_CurRecInc
      }
    }
    else if oKeyCodes.kCodePressed[4]=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if mR_Page=mR_RecPageMax
      {
        mR_Page=1
        mR_CurY-=mR_CurRecInc*(mR_RecPageMax-1)
      }
      else
      {
        mR_Page+=1
        mR_CurY+=mR_CurRecInc
      }
    }

    if oKeyCodes.kCodePressed[5]=1
    {
      mR_RecCurPos=1
      subMenu=13
    }
  }
}
else if subMenu=7 //---------- OPTIONS ----------
{
  if mO_OptSubMenu=2
  {
    if global.wearingHatJ=9 and sawBirdHatJ=0
    {
      global.recBirdsSeen+=1
      sawBirdHatJ=1
    }
    else if global.wearingHatC=9 and sawBirdHatC=0
    {
      global.recBirdsSeen+=1
      sawBirdHatC=1
    }
  }

  mO_CurX=24
  mO_CurY=37+(mO_CurPos*12)

  if oKeyCodes.kCodePressed[3]=1 //Up
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mO_CurPos=1 {mO_CurPos=mO_OptMax}
    else {mO_CurPos-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1 //Down
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mO_CurPos=mO_OptMax {mO_CurPos=1}
    else {mO_CurPos+=1}
  }
  else if oKeyCodes.kCodePressed[9]=1 //Opt Menu Left
  {
    playSound(global.snd_MenuCursor,0,1,1)
    mO_CurPos=1
    if mO_OptSubMenu=1 {mO_OptSubMenu=6}
    else {mO_OptSubMenu-=1}
  }
  else if oKeyCodes.kCodePressed[10]=1 //Opt Menu Right
  {
    playSound(global.snd_MenuCursor,0,1,1)
    mO_CurPos=1
    if mO_OptSubMenu=6 {mO_OptSubMenu=1}
    else {mO_OptSubMenu+=1}
  }

  if mO_OptSubMenu=1 {mO_OptMax=9} //Control
  else if mO_OptSubMenu=2 {mO_OptMax=10} //Graphics
  else if mO_OptSubMenu=3 {mO_OptMax=9} //Display
  else if mO_OptSubMenu=4 {mO_OptMax=10} //Gameplay
  else if mO_OptSubMenu=5 {mO_OptMax=7} //Unreal Guy
  else if mO_OptSubMenu=6 {mO_OptMax=5} //Audio

  if scrController(1) and cursorRepeatMove mod 2=0 //----- Left -----
  {
    if mO_OptSubMenu=2
    {
      if mO_CurPos=3 //Window Scaling
      {
        if oKeyCodes.kCodePressed[1]=1
        {
          global.optWindowSize-=0.25
          if global.optWindowSize<1 {global.optWindowSize=3}
          window_set_size(480*global.optWindowSize,352*global.optWindowSize)
          window_center()
          playSound(global.snd_MenuCursor,0,1,1)
        }
      }
      else if mO_CurPos=9 or mO_CurPos=10 //Hat cycle
      {
        if oKeyCodes.kCodePressed[1]=1
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if mO_CurPos=9
          {
            if global.wearingHatJ=0 {global.wearingHatJ=maxHats}
            else {global.wearingHatJ-=1}
          }
          else
          {
            if global.wearingHatC=0 {global.wearingHatC=maxHats}
            else {global.wearingHatC-=1}
          }
        }
      }
    }
    else if mO_OptSubMenu=3
    {
      if mO_CurPos=3 //Show Split Window
      {
        if global.optSplitWindow>0
        {
          playSound(global.snd_MenuCursor,0,1,1)
          global.optSplitWindow-=1
        }
      }
    }
    else if mO_OptSubMenu=5
    {
      if mO_CurPos=5 //Unreal Guy Voice Volume
      {
        if global.optUnrealVolume>0
        {
          playSound(global.snd_MenuCursor,0,1,1)
          global.optUnrealVolume-=1
        }
      }
      else if mO_CurPos=6 //Unreal Guy Voice Pitch
      {
        if oKeyCodes.kCodePressed[1]=1
        {
          if global.optUnrealPitch>0.5
          {
            playSound(global.snd_MenuCursor,0,1,1)
            global.optUnrealPitch-=0.25
          }
        }
      }
    }
    else if mO_OptSubMenu=6
    {
      if mO_CurPos=1 //Music Volume
      {
        if global.optMusic>0
        {
          playSound(global.snd_MenuCursor,0,1,1)
          global.optMusic-=1
          var tempMplay;
          tempMplay=findMusic(global.currentMusic)
          SS_SetSoundVol(tempMplay,global.optMusic*100)
          if global.optMusic=0 {stopAllMusic()}
        }
      }
      else if mO_CurPos=2 //Sound Volume
      {
        if global.optSound>0
        {
          playSound(global.snd_MenuCursor,0,1,1)
          global.optSound-=1
        }
      }
    }
  }
  else if scrController(2) and cursorRepeatMove mod 2=0 //----- Right -----
  {
    if mO_OptSubMenu=2
    {
      if mO_CurPos=3 //Window Scaling
      {
        if oKeyCodes.kCodePressed[2]=1
        {
          global.optWindowSize+=0.25
          if global.optWindowSize>3 {global.optWindowSize=1}
          window_set_size(480*global.optWindowSize,352*global.optWindowSize)
          window_center()
          playSound(global.snd_MenuCursor,0,1,1)
        }
      }
      else if mO_CurPos=9 or mO_CurPos=10 //Hat cycle
      {
        if oKeyCodes.kCodePressed[2]=1
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if mO_CurPos=9
          {
            if global.wearingHatJ=maxHats {global.wearingHatJ=0}
            else {global.wearingHatJ+=1}
          }
          else
          {
            if global.wearingHatC=maxHats {global.wearingHatC=0}
            else {global.wearingHatC+=1}
          }
        }
      }
    }
    else if mO_OptSubMenu=3
    {
      if mO_CurPos=3 //Show Split Window
      {
        if global.optSplitWindow<60
        {
          playSound(global.snd_MenuCursor,0,1,1)
          global.optSplitWindow+=1
        }
      }
    }
    else if mO_OptSubMenu=5
    {
      if mO_CurPos=5 //Unreal Guy Voice Volume
      {
        if global.optUnrealVolume<100
        {
          playSound(global.snd_MenuCursor,0,1,1)
          global.optUnrealVolume+=1
        }
      }
      else if mO_CurPos=6 //Unreal Guy Voice Pitch
      {
        if oKeyCodes.kCodePressed[2]=1
        {
          if global.optUnrealPitch<2
          {
            playSound(global.snd_MenuCursor,0,1,1)
            global.optUnrealPitch+=0.25
          }
        }
      }
    }
    else if mO_OptSubMenu=6
    {
      if mO_CurPos=1 //Music Volume
      {
        if global.optMusic<100
        {
          playSound(global.snd_MenuCursor,0,1,1)
          var prevVol,tempMplay;
          prevVol=global.optMusic
          tempMplay=findMusic(global.currentMusic)
          global.optMusic+=1
          if prevVol=0 {playMusic(tempMplay,0,0)}
          SS_SetSoundVol(tempMplay,global.optMusic*100)
        }
      }
      else if mO_CurPos=2 //Sound Volume
      {
        if global.optSound<100
        {
          playSound(global.snd_MenuCursor,0,1,1)
          global.optSound+=1
        }
      }
    }
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    resetKeyCodes()
    if mO_OptSubMenu!=5 {playSound(global.snd_MenuConfirm,0,1,1)}

    if mO_OptSubMenu=1 //---------- CONTROL ----------
    {
      if mO_CurPos=1 //Change Controls
      {
        subMenu=11
      }
      else if mO_CurPos=2 //Gamepad setup
      {
        subMenu=14
      }
      else if mO_CurPos=3 //Gamepad input
      {
        if global.optGamePad=1 {global.optGamePad=0}
        else {global.optGamePad=1}
      }
      else if mO_CurPos=4 //D-Pad Dash
      {
        if global.optDPadDash=1 {global.optDPadDash=0}
        else {global.optDPadDash=1}
      }
      else if mO_CurPos=5 //Right is Forward
      {
        if global.optRightIsForward=1 {global.optRightIsForward=0}
        else {global.optRightIsForward=1}
      }
      else if mO_CurPos=6 //Show Key State
      {
        if global.optShowKeyState=1 {global.optShowKeyState=0}
        else {global.optShowKeyState=1}
      }
      else if mO_CurPos=7 //Cursor Repeat
      {
        global.optCursorRepeat+=1
        if global.optCursorRepeat=6 {global.optCursorRepeat=1}
      }
      else if mO_CurPos=8 //Keep Menu Position
      {
        if global.optKeepMenuPos>0 {global.optKeepMenuPos=0}
        else {global.optKeepMenuPos=1}
      }
      else if mO_CurPos=9 //Swap Type
      {
        global.optSwapType+=1
        if global.optSwapType>=4 {global.optSwapType=0}
      }
    }
    else if mO_OptSubMenu=2 //---------- GRAPHICS ----------
    {
      if mO_CurPos=1 //Game Priority
      {
        global.gamePriority+=1
        if global.gamePriority=3 {global.gamePriority=0}
        set_program_priority(global.gamePriority)
      }
      else if mO_CurPos=2 //Set Synchronization
      {
        if global.optVSync=1 {global.optVSync=0}
        else {global.optVSync=1}
        set_synchronization(global.optVSync)
      }
      else if mO_CurPos=3 //Window Scaling
      {
        if global.optWindowSize<2 {global.optWindowSize=2}
        else if global.optWindowSize>=2 and global.optWindowSize<3 {global.optWindowSize=3}
        else {global.optWindowSize=1}
        window_set_size(480*global.optWindowSize,352*global.optWindowSize)
        window_center()
      }
      else if mO_CurPos=4 //Window Resizing
      {
        if global.optCanResizeWindow=1 {global.optCanResizeWindow=0}
        else {global.optCanResizeWindow=1}
        window_set_sizeable(global.optCanResizeWindow)
      }
      else if mO_CurPos=5 //Low Health Warn
      {
        if global.optLowHealthWarn=1 {global.optLowHealthWarn=0}
        else {global.optLowHealthWarn=1}
      }
      else if mO_CurPos=6 //Game Over Settings
      {
        global.optBitrateExplosion+=1
        if global.optBitrateExplosion>=3 {global.optBitrateExplosion=0}
      }
      else if mO_CurPos=7 //Player Trail
      {
        if global.optPlayerTrail=1 {global.optPlayerTrail=0}
        else {global.optPlayerTrail=1}
      }
      else if mO_CurPos=8 //Weapon Trail
      {
        if global.optWeaponTrail=1 {global.optWeaponTrail=0}
        else {global.optWeaponTrail=1}
      }
      else if mO_CurPos=9 //Jerry Hat
      {
        global.wearingHatJ=0
      }
      else if mO_CurPos=10 //Claire Hat
      {
        global.wearingHatC=0
      }
    }
    else if mO_OptSubMenu=3 //---------- DISPLAY ----------
    {
      if mO_CurPos=1 //Show HUD
      {
        if global.optShowHUD<2
        {
          if global.optShowHUD=1 {global.optShowHUD=0}
          else {global.optShowHUD=1}
        }
      }
      else if mO_CurPos=2 //Centralize Mobility HUD
      {
        if global.optCentralizeHUD=1 {global.optCentralizeHUD=0}
        else {global.optCentralizeHUD=1}
      }
      else if mO_CurPos=3 //Show Split Window
      {
        if global.optSplitWindow=0 {global.optSplitWindow=30}
        else {global.optSplitWindow=0}
      }
      else if mO_CurPos=4 //Show Combat Awards
      {
        if global.optShowCombatAward=1 {global.optShowCombatAward=0}
        else {global.optShowCombatAward=1}
      }
      else if mO_CurPos=5 //Show Chain Time
      {
        if global.optShowChainMeter=1 {global.optShowChainMeter=0}
        else {global.optShowChainMeter=1}
      }
      else if mO_CurPos=6 //Show Area
      {
        if global.optShowArea=1 {global.optShowArea=0}
        else {global.optShowArea=1}
      }
      else if mO_CurPos=7 //Show Score
      {
        if global.optShowScore=1 {global.optShowScore=0}
        else {global.optShowScore=1}
      }
      else if mO_CurPos=8 //Show Map Header
      {
        if global.optShowMapHeader=1 {global.optShowMapHeader=0}
        else {global.optShowMapHeader=1}
      }
      else if mO_CurPos=9 //Show Death Counter
      {
        if global.optDeathCounter=1 {global.optDeathCounter=0}
        else {global.optDeathCounter=1}
      }
    }
    else if mO_OptSubMenu=4 //---------- GAMEPLAY ----------
    {
      if mO_CurPos=1 //Show Damage
      {
        if global.optShowDamage<2
        {
          if global.optShowDamage=1 {global.optShowDamage=0}
          else {global.optShowDamage=1}
        }
      }
      else if mO_CurPos=2 //Show AP Earned
      {
        if global.optShowPointsEarned=1 {global.optShowPointsEarned=0}
        else {global.optShowPointsEarned=1}
      }
      else if mO_CurPos=3 //Show Enemy HP
      {
        if global.optEnemyHP<2
        {
          if global.optEnemyHP=1 {global.optEnemyHP=0}
          else {global.optEnemyHP=1}
        }
      }
      else if mO_CurPos=4 //Show Money Pickup
      {
        if global.optShowMoney=1 {global.optShowMoney=0}
        else {global.optShowMoney=1}
      }
      else if mO_CurPos=5 //Show Atk Type
      {
        if global.optAtkTShow=1 {global.optAtkTShow=0}
        else {global.optAtkTShow=1}
      }
      else if mO_CurPos=6 //Let Chao Roam
      {
        if global.optChaoRoam=1
        {
          global.optChaoRoam=0
          oIdentifier.fairyAutoRoam=false
        }
        else {global.optChaoRoam=1}
      }
      else if mO_CurPos=7 //Show Hover Info
      {
        if global.optShowHoverInfo=1 {global.optShowHoverInfo=0}
        else {global.optShowHoverInfo=1}
      }
      else if mO_CurPos=8 //Chao Seek Enemy
      {
        if global.optChaoAttack=0 {global.optChaoAttack=1}
        else if global.optChaoAttack=1 {global.optChaoAttack=2}
        else if global.optChaoAttack=2
        {
          global.optChaoAttack=0
          oIdentifier.followTarget=oPlayer1
        }
      }
      else if mO_CurPos=9 //No Air Stall on Down
      {
        if global.optNoBounce=1 {global.optNoBounce=0}
        else {global.optNoBounce=1}
      }
      else if mO_CurPos=10 //Morph Controls
      {
        if global.optMorphControls=0 {global.optMorphControls=1}
        else if global.optMorphControls=1 {global.optMorphControls=2}
        else {global.optMorphControls=0}
      }
    }
    else if mO_OptSubMenu=5 //---------- UNREAL GUY ----------
    {
      if mO_CurPos=1 //Unreal Chain Audio
      {
        playSound(global.snd_MenuConfirm,0,1,1)
        if global.optUnrealGuyChainAudio=1 {global.optUnrealGuyChainAudio=0}
        else {global.optUnrealGuyChainAudio=1}
      }
      else if mO_CurPos=2 //Unreal Chain Visual
      {
        playSound(global.snd_MenuConfirm,0,1,1)
        if global.optUnrealGuyChainVisual=1 {global.optUnrealGuyChainVisual=0}
        else {global.optUnrealGuyChainVisual=1}
      }
      else if mO_CurPos=3 //Unreal Spree Audio
      {
        playSound(global.snd_MenuConfirm,0,1,1)
        if global.optUnrealGuySpreeAudio=1 {global.optUnrealGuySpreeAudio=0}
        else {global.optUnrealGuySpreeAudio=1}
      }
      else if mO_CurPos=4 //Unreal Spree Visual
      {
        playSound(global.snd_MenuConfirm,0,1,1)
        if global.optUnrealGuySpreeVisual=1 {global.optUnrealGuySpreeVisual=0}
        else {global.optUnrealGuySpreeVisual=1}
      }
      else if mO_CurPos=5 //Unreal Guy Voice Volume
      {
        playSound(global.snd_MenuConfirm,0,1,1)
        global.optUnrealVolume=100
      }
      else if mO_CurPos=6 //Unreal Guy Voice Pitch
      {
        playSound(global.snd_MenuConfirm,0,1,1)
        global.optUnrealPitch=1
      }
      else if mO_CurPos=7 //Unreal Guy Sound Test
      {
        if choose(0,1)=0 {playSound(global.snd_killChain[0],0,1-(1-(global.optUnrealVolume/100)),22050*global.optUnrealPitch)}
        else {playSound(global.snd_killingSpree[0],0,1-(1-(global.optUnrealVolume/100)),22050*global.optUnrealPitch)}
      }
    }
    else if mO_OptSubMenu=6 //---------- AUDIO ----------
    {
      if mO_CurPos=1 //Music Volume
      {
        if global.optMusic=0
        {
          global.optMusic=100
          var tempMplay;
          tempMplay=findMusic(global.currentMusic)
          playMusic(tempMplay,0,0)
        }
        else
        {
          global.optMusic=0
          stopAllMusic()
        }
      }
      else if mO_CurPos=2 //Sound Volume
      {
        if global.optSound=0 {global.optSound=100}
        else {global.optSound=0}
      }
      else if mO_CurPos=3 //Message Plink
      {
        if global.optMessagePlink=1 {global.optMessagePlink=0}
        else {global.optMessagePlink=1}
      }
      else if mO_CurPos=4 //Dash Warn
      {
        if global.optDashWarn=1 {global.optDashWarn=0}
        else {global.optDashWarn=1}
      }
      else if mO_CurPos=5 //Chao Item Warn
      {
        if global.optChaoItemWarn=1 {global.optChaoItemWarn=0}
        else {global.optChaoItemWarn=1}
      }
    }
  }
}
else if subMenu=8 //---------- TELEPORT ----------
{
  if oKeyCodes.kCodePressed[5]=1
  {
    resetKeyCodes()
    if global.mapTeleport=0 or global.bBossGallery=1 //Can't use
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","This function is either being blocked or there are no active teleport locations.",7,2,oMessagePerson,0)
      newMessage.fadingTime=45
    }
    else
    {
      writeToPlayerGlobals()
      global.gamePaused=false
      global.bossTrack=0; global.rmDeaths=0; global.currentBoss=""
    }
    
    if global.bBossGallery=0
    {
      if global.mapTeleport=1 //Gate A
      {
        global.newMapX=208; global.newMapY=128
        room_goto(rMain_5Gate)
        exit;
      }
      else if global.mapTeleport=2 //Gate B
      {
        global.newMapX=128; global.newMapY=160
        room_goto(rMain_8Gate)
        exit;
      }
      else if global.mapTeleport=3 //Gate C
      {
        global.newMapX=416; global.newMapY=192
        room_goto(rMain_14Gate)
        exit;
      }
      else if global.mapTeleport=4 //Gate D
      {
        global.newMapX=256; global.newMapY=96
        room_goto(rMain_28Gate)
        exit;
      }
      else if global.mapTeleport=5 //Gate E
      {
        global.newMapX=320; global.newMapY=128
        room_goto(rMain_39Vault)
        exit;
      }
      else if global.mapTeleport=6 //Gate F
      {
        global.newMapX=288; global.newMapY=208
        room_goto(rMain_48Gate)
        exit;
      }
      else if global.mapTeleport=7 //Gate G
      {
        global.newMapX=208; global.newMapY=272
        room_goto(rMain_56Gate)
        exit;
      }
      else if global.mapTeleport=8 //Gate H
      {
        //Do nothing, can't teleport from here; this is just here to take up space and confuse you if you're reading this
      }
      else if global.mapTeleport=9 //Gate 4 (Megapolis)
      {
        if global.gameProgress>=1840
        {
          global.newMapX=0; global.newMapY=0
          room_goto(rMega4_Map)
        }
        else
        {
          global.newMapX=208; global.newMapY=304
          room_goto(rMega4_Gate)
        }
        exit;
      }
      else if global.mapTeleport=14 //Vault Shift Maze
      {
        global.newMapX=368; global.newMapY=272
        room_goto(rVault_16)
        exit;
      }
      else if global.mapTeleport=15 //Vault (After completing Chapter 10)
      {
        global.newMapX=64; global.newMapY=208
        room_goto(rMain_39Vault)
        exit;
      }
      else if global.mapTeleport=16 //Main_45
      {
        global.newMapX=48; global.newMapY=384
        room_goto(rMain_44)
        exit;
      }
      else if global.mapTeleport=17 //Gate 6 - Earth Temple
      {
        global.newMapX=80; global.newMapY=288
        room_goto(rGame6_EarthA)
        exit;
      }
      else if global.mapTeleport=18 //Gate 6 - Fire Temple
      {
        global.newMapX=80; global.newMapY=272
        room_goto(rGame6_FireA)
        exit;
      }
      else if global.mapTeleport=19 //Gate 6 - Wind Temple
      {
        global.newMapX=176; global.newMapY=992
        room_goto(rGame6_WindA)
        exit;
      }
      else if global.mapTeleport=20 //Gate 6 - Paradise Island
      {
        global.newMapX=128; global.newMapY=288
        room_goto(rGame6_ParaIslandA)
        exit;
      }
      else if global.mapTeleport=21 //Gate 6 - Watery Cave
      {
        global.newMapX=80; global.newMapY=288
        room_goto(rGame6_WaterCaveA)
        exit;
      }
      else if global.mapTeleport=22 //Subconscious Filter
      {
        global.newMapX=192; global.newMapY=304
        room_goto(rMain_92)
        exit;
      }
      else if global.mapTeleport=23 //Gate 6 - Doom Castle
      {
        global.newMapX=80; global.newMapY=272
        room_goto(rGame6_CoDA)
        exit;
      }
      else if global.mapTeleport=24 //Mountain Temple
      {
        global.newMapX=352; global.newMapY=208
        room_goto(rMain_24)
        exit;
      }
      else if global.mapTeleport=25 //Displaced Construction Site
      {
        global.newMapX=144; global.newMapY=336
        room_goto(rDCS_A)
        exit;
      }
      else if global.mapTeleport=26 //Magical Castle
      {
        global.newMapX=128; global.newMapY=416
        room_goto(rMC_A)
        exit;
      }
      else if global.mapTeleport=27 //Hidden Program Facility
      {
        global.newMapX=224; global.newMapY=288
        room_goto(rHPF_A)
        exit;
      }
      else if global.mapTeleport=28 //Bubble Tower
      {
        global.newMapX=272; global.newMapY=304
        room_goto(rBubbleTowerMain)
        exit;
      }
      else if global.mapTeleport=29 //Path to the Truth
      {
        global.newMapX=112; global.newMapY=448
        room_goto(rPttT_02)
        exit;
      }
      else if global.mapTeleport=31 //Gate 1
      {
        global.newMapX=192; global.newMapY=224
        room_goto(rMario1_1)
        exit;
      }
      else if global.mapTeleport=32 //Gate 2
      {
        global.newMapX=512; global.newMapY=288
        room_goto(rLink2_HP)
        exit;
      }
      else if global.mapTeleport=33 //Gate 3
      {
        global.newMapX=256; global.newMapY=288
        room_goto(rBelmont3_Gate)
        exit;
      }
      else if global.mapTeleport=34 //Gate 4
      {
        global.newMapX=176; global.newMapY=304
        room_goto(rMega4_Gate)
        exit;
      }
      else if global.mapTeleport=35 //Gate 5
      {
        global.newMapX=256; global.newMapY=288
        room_goto(rSamus5_Gate)
        exit;
      }
      else if global.mapTeleport=36 //Gate 6
      {
        global.newMapX=256; global.newMapY=256
        room_goto(rGame6_Gate)
        exit;
      }
      else if global.mapTeleport=41 //Bubble Tower B HUB
      {
        global.newMapX=160; global.newMapY=304
        room_goto(rBT_HUB)
        exit;
      }
    }
  }
}
else if subMenu=9 //---------- SAVE ----------
{
  event_user(1)
  if confirmationMenu=0
  {
    if oKeyCodes.kCodePressed[3]=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if mS_CurPos=1
      {
        mS_CurPos=mS_CurMax
        mS_CurY+=mS_CurInc*(mS_CurMax-1)
      }
      else
      {
        mS_CurPos-=1
        mS_CurY-=mS_CurInc
      }
    }
    else if oKeyCodes.kCodePressed[4]=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if mS_CurPos=mS_CurMax
      {
        mS_CurPos=1
        mS_CurY-=mS_CurInc*(mS_CurMax-1)
      }
      else
      {
        mS_CurPos+=1
        mS_CurY+=mS_CurInc
      }
    }
  
    if oKeyCodes.kCodePressed[5]=1
    {
      resetKeyCodes()
      if mS_CurPos=1 //Save
      {
        if global.bCanSave=true
        {
          global.recSaveNum+=1
          saveData()
        }
        else {playSound(global.snd_MenuCancel,0,1,1)}
      }
      else if mS_CurPos=2 //Retry (Game Over)
      {
        if global.bCanForceGO=true
        {
          global.recForcedGameOver+=1
          global.quickGameOver=1
          oPlayer1.life-=oPlayer1.maxLife
          oHUD.menuOpen=false
          instance_destroy()
          exit;
        }
        else {playSound(global.snd_MenuCancel,0,1,1)}
      }
      else if mS_CurPos=3 //Load
      {
        confirmationMenu=1
        confirmMenuPos=1
      }
      else if mS_CurPos=4 //Title Screen
      {
        confirmationMenu=2
        confirmMenuPos=1
      }
    }
  }
}
else if subMenu=11 //---------- CONTROLS ----------
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mCon_CurPos=1
    {
      mCon_CurPos=mCon_CurMax
      mCon_CurY+=mCon_CurInc*(mCon_CurMax-1)
    }
    else
    {
      mCon_CurPos-=1
      mCon_CurY-=mCon_CurInc
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mCon_CurPos=mCon_CurMax
    {
      mCon_CurPos=1
      mCon_CurY-=mCon_CurInc*(mCon_CurMax-1)
    }
    else
    {
      mCon_CurPos+=1
      mCon_CurY+=mCon_CurInc
    }
  }
  
  if oKeyCodes.kCodePressed[5]=1
  {
    resetKeyCodes()
    playSound(global.snd_MenuConfirm,0,1,1)
    var keyHelpInfo,keyChange;
    keyHelpInfo="Enter the key you would like to#change this action to and press Enter."
    if mCon_CurPos=1 //Up
    {
      keyChange=get_string(keyHelpInfo,global.ctrlUp)
      global.ctrlUp=string_upper(keyChange)
    }
    else if mCon_CurPos=2 //Down
    {
      keyChange=get_string(keyHelpInfo,global.ctrlDown)
      global.ctrlDown=string_upper(keyChange)
    }
    else if mCon_CurPos=3 //Left
    {
      keyChange=get_string(keyHelpInfo,global.ctrlLeft)
      global.ctrlLeft=string_upper(keyChange)
    }
    else if mCon_CurPos=4 //Right
    {
      keyChange=get_string(keyHelpInfo,global.ctrlRight)
      global.ctrlRight=string_upper(keyChange)
    }
    else if mCon_CurPos=5 //Jump
    {
      keyChange=get_string(keyHelpInfo,global.ctrlJump)
      global.ctrlJump=string_upper(keyChange)
    }
    else if mCon_CurPos=6 //Swap Character
    {
      keyChange=get_string(keyHelpInfo,global.ctrlCharSwap)
      global.ctrlCharSwap=string_upper(keyChange)
    }
    else if mCon_CurPos=7 //Swap Ability Set
    {
      keyChange=get_string(keyHelpInfo,global.ctrlAbilSwap)
      global.ctrlAbilSwap=string_upper(keyChange)
    }
    else if mCon_CurPos=8 //Action A
    {
      keyChange=get_string(keyHelpInfo,global.ctrlActA)
      global.ctrlActA=string_upper(keyChange)
    }
    else if mCon_CurPos=9 //Action B
    {
      keyChange=get_string(keyHelpInfo,global.ctrlActB)
      global.ctrlActB=string_upper(keyChange)
    }
    else if mCon_CurPos=10 //Action C
    {
      keyChange=get_string(keyHelpInfo,global.ctrlActC)
      global.ctrlActC=string_upper(keyChange)
    }
    else if mCon_CurPos=11 //Dash Back
    {
      keyChange=get_string(keyHelpInfo,global.ctrlDashLeft)
      global.ctrlDashLeft=string_upper(keyChange)
    }
    else if mCon_CurPos=12 //Dash Right
    {
      keyChange=get_string(keyHelpInfo,global.ctrlDashRight)
      global.ctrlDashRight=string_upper(keyChange)
    }
    else if mCon_CurPos=13 //Set to default controls
    {
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
      global.ctrlDashLeft="Q"
      global.ctrlDashRight="E"
    }
  }
}
else if subMenu=12 //---------- ITEM MENU ----------
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mItem_CurY=1 {mItem_CurY=4}
    else {mItem_CurY-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mItem_CurY=4 {mItem_CurY=1}
    else {mItem_CurY+=1}
  }
  else if oKeyCodes.kCodePressed[1]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mItem_CurX=1 {mItem_CurX=10}
    else {mItem_CurX-=1}
  }
  else if oKeyCodes.kCodePressed[2]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mItem_CurX=10 {mItem_CurX=1}
    else {mItem_CurX+=1}
  }
  
  if oKeyCodes.kCodePressed[5]=1 //Equip item
  {
    resetKeyCodes()
    if mEq_CurPos>=1 and mEq_CurPos<=3 //Jerry
    {
      var tIndAdj;
      tIndAdj=-1
      if mItem_CurY=1 {tIndAdj=0}
      else if mItem_CurY=2 {tIndAdj=10}
      else if mItem_CurY=3 {tIndAdj=20}
      else if mItem_CurY=4 {tIndAdj=30}
      
      if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1
      {
        playSound(global.snd_Equip,0,1,1)
        if global.equipJerry[mEq_CurPos-1]>0
        {
          var tNewString,teSlotCheck,tStringHold;
          teSlotCheck=global.equipJerry[mEq_CurPos-1]-1
          tNewString=string_delete(global.equipItems,global.equipJerry[mEq_CurPos-1],1)
          tNewString=string_insert("1",tNewString,global.equipJerry[mEq_CurPos-1])
          global.equipItems=tNewString
          eCheck[teSlotCheck]="1"
        }
        global.equipJerry[mEq_CurPos-1]=mItem_CurX+tIndAdj
        var tNewString;
        tNewString=string_delete(global.equipItems,mItem_CurX+tIndAdj,1)
        tNewString=string_insert("2",tNewString,mItem_CurX+tIndAdj)
        global.equipItems=tNewString
        eCheck[mItem_CurX-1+tIndAdj]="2"
        
        //Check Speed Booster
        oPlayer1.dashRecovery=20+(global.skillTree[22]*2)
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=25 {oPlayer1.dashRecovery+=4}
        }
        subMenu=2
      }
    }
    else if mEq_CurPos>=4 and mEq_CurPos<=6 //Claire
    {
      var tIndAdj;
      tIndAdj=-1
      if mItem_CurY=1 {tIndAdj=0}
      else if mItem_CurY=2 {tIndAdj=10}
      else if mItem_CurY=3 {tIndAdj=20}
      else if mItem_CurY=4 {tIndAdj=30}
      
      if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1
      {
        playSound(global.snd_Equip,0,1,1)
        if global.equipClaire[mEq_CurPos-4]>0
        {
          var tNewString,teSlotCheck,tStringHold;
          teSlotCheck=global.equipClaire[mEq_CurPos-4]-1
          tNewString=string_delete(global.equipItems,global.equipClaire[mEq_CurPos-4],1)
          tNewString=string_insert("1",tNewString,global.equipClaire[mEq_CurPos-4])
          global.equipItems=tNewString
          eCheck[teSlotCheck]="1"
        }
        global.equipClaire[mEq_CurPos-4]=mItem_CurX+tIndAdj
        var tNewString;
        tNewString=string_delete(global.equipItems,mItem_CurX+tIndAdj,1)
        tNewString=string_insert("2",tNewString,mItem_CurX+tIndAdj)
        global.equipItems=tNewString
        eCheck[mItem_CurX-1+tIndAdj]="2"
        
        //Check Speed Booster
        oPlayer1.dashRecovery=20+(global.skillTree[22]*2)
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=25 {oPlayer1.dashRecovery+=4}
        }
        subMenu=2
      }
    }
  }
}
else if subMenu=13 //---------- RECOGNITIONS ----------
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mR_RecCurPos=1 {mR_RecCurPos=6}
    else {mR_RecCurPos-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mR_RecCurPos=6 {mR_RecCurPos=1}
    else {mR_RecCurPos+=1}
  }
}
else if subMenu=14 //---------- GAMEPAD SETUP ----------
{
  //Change button layout
  if oKeyCodes.kCodePressed[1]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if global.optGamepadSetup=1 {global.optGamepadSetup=mO_OptConMax}
    else {global.optGamepadSetup-=1}
  }
  else if oKeyCodes.kCodePressed[2]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if global.optGamepadSetup=mO_OptConMax {global.optGamepadSetup=1}
    else {global.optGamepadSetup+=1}
  }
  //Change stick dead zone
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if global.optStickDeadZone=0.8 {global.optStickDeadZone=0.2}
    else {global.optStickDeadZone+=0.05}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if global.optStickDeadZone=0.2 {global.optStickDeadZone=0.8}
    else {global.optStickDeadZone-=0.05}
  }
  
}

if keyboard_check_pressed(vk_home)
{
  playSound(global.snd_MenuConfirm,0,1,1)
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
  global.ctrlDashLeft="Q"
  global.ctrlDashRight="E"
}

if oKeyCodes.kCodePressed[6]=1 //Go back to a specific submenu
{
  resetKeyCodes()
  if subMenu>0 and subMenu<11 {subMenu=0} //From main submenus to main menu
  else if subMenu=11 or subMenu=14 {subMenu=7} //From (Control or Gamepad Setup) to Options
  else if subMenu=12 {subMenu=2} //From Item list to Equipment
  else if subMenu=13 {subMenu=6} //From Recognitions to Records
  mapDetails=0
}
if keyboard_check_pressed(curInfo) //Show game info
{
  io_clear()
  show_info()
}

if oKeyCodes.kCodePressed[12]=1 //Close menu
{
  io_clear()
  resetKeyCodes()
  playSound(global.snd_MenuClose,0,1,1)
  global.gamePaused=false
  oHUD.menuOpen=false
  if global.optKeepMenuPos>0 {global.optKeepMenuPos=mainCurPos+10}
  with oPauseMenu {instance_destroy()}
  instance_destroy()
  exit;
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///RECOGNITION TOKENS
//Update Recognitions in the menu
recognitionCount=0
for(i=1;i<=50;i+=1)
{
  tokens[i]=string_char_at(global.tokenRecognitions,i)
  if tokens[i]="1" {recognitionCount+=1}
}
for(i=1;i<=50;i+=1)
{
  tokensSS[i]=string_char_at(global.tokenRecognitionsSetTwo,i)
  if tokensSS[i]="1" {recognitionCount+=1}
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///CONFIRMATION MENU
//Confirmation menu for 'Reverting to previous save' and 'Return to title screen'
if confirmationMenu>0
{
  if oKeyCodes.kCodePressed[3]=1
  {
    if confirmMenuPos=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=0
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    if confirmMenuPos=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=1
    }
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    if confirmMenuPos=0
    {
      if confirmationMenu=1 //Load
      {
        global.gamePaused=false
        initGameVars()
        loadSaveData()
        global.resetMusic=true
        room_goto(roomToPlace)
      }
      else if confirmationMenu=2 //Title Screen
      {
        playSound(global.snd_MenuCancel,0,1,1)
        room_goto(rTitle)
      }
    }
    else if confirmMenuPos=1
    {
      confirmMenuPos=0
      confirmationMenu=0
      io_clear()
      resetKeyCodes()
    }
  }
  else if oKeyCodes.kCodePressed[6]=1
  {
    confirmMenuPos=0
    confirmationMenu=0
    io_clear()
    resetKeyCodes()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  //---------- Fade Back ----------
  draw_set_color(make_color_rgb(0,190,0))
  draw_set_alpha(0.25)
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)

  //---------- Set Positions ----------
  mainMenuX=view_xview[0]+18
  mainMenuY=view_yview[0]+43
  contentMenuX=mainMenuX+114
  contentMenuY=mainMenuY+27
  infoMenuX=mainMenuX+0
  infoMenuY=mainMenuY+213

  //---------- Draw Menu ----------
  draw_sprite(sPauseM_Main,0,mainMenuX,mainMenuY)
  if global.mapTeleport=0 or global.bBossGallery=1 {draw_sprite(sPauseM_NoTeleport,0,mainMenuX+17,mainMenuY+161)}
  draw_sprite(sPauseM_Cursor,0,mainMenuX+mainCurX,mainMenuY+mainCurY)
  if subMenu>0
  {
    draw_sprite(sPauseM_AbilArrow,0,mainMenuX+mainCurX-1,mainMenuY+mainCurY-1)
    draw_set_color(make_color_rgb(240,232,136))
    draw_set_alpha(0.3)
    draw_rectangle(mainMenuX+mainCurX-10,mainMenuY+mainCurY-8,mainMenuX+mainCurX+76,mainMenuY+mainCurY+8,0)
    draw_set_alpha(1)
    draw_rectangle(mainMenuX+mainCurX-10,mainMenuY+mainCurY-8,mainMenuX+mainCurX+76,mainMenuY+mainCurY+8,1)
  }

  //---------- Display Current Chapter ----------
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_left)
  draw_set_alpha(1)
  var tChapterName;
  tChapterName=""
  if global.gameProgress<=29 {tChapterName="Chapter 0: You haven't even started yet..."}
  else if global.gameProgress>=30 and global.gameProgress<=159 {tChapterName="Chapter 1: Everything Has a Beginning"}
  else if global.gameProgress>=160 and global.gameProgress<=529 {tChapterName="Chapter 2: Jerry & Claire"}
  else if global.gameProgress>=530 and global.gameProgress<=629 {tChapterName="Chapter 3: Overrun"}
  else if global.gameProgress>=630 and global.gameProgress<=929 {tChapterName="Chapter 4: Jerry's Adventure"}
  else if global.gameProgress>=930 and global.gameProgress<=1159 {tChapterName="Chapter 5: Reclaiming What's Lost"}
  else if global.gameProgress>=1160 and global.gameProgress<=1539 {tChapterName="Chapter 6: Clairvoyance"}
  else if global.gameProgress>=1540 and global.gameProgress<=1769 {tChapterName="Chapter 7: Familiar Ways"}
  else if global.gameProgress>=1770 and global.gameProgress<=2009 {tChapterName="Chapter 8: Mega Jerry"}
  else if global.gameProgress>=2010 and global.gameProgress<=2169 {tChapterName="Chapter 9: Recollection"}
  else if global.gameProgress>=2170 and global.gameProgress<=2569 {tChapterName="Chapter 10: Something Sleeps in the Darkness"}
  else if global.gameProgress>=2570 and global.gameProgress<=2599 {tChapterName="Chapter 11: Intermission"}
  else if global.gameProgress>=2600 and global.gameProgress<=2679 {tChapterName="Chapter 12: Barren Bewilderment"}
  else if global.gameProgress>=2680 and global.gameProgress<=3089 {tChapterName="Chapter 13: Claire Fusion"}
  else if global.gameProgress>=3090 and global.gameProgress<=3399 {tChapterName="Chapter 14: Truths Revealed"}
  else if global.gameProgress>=3400 and global.gameProgress<=3879 {tChapterName="Chapter 15: Rapid Prototype Game"}
  else if global.gameProgress>=3880 and global.gameProgress<=3939 {tChapterName="Chapter 16: On the Defensive"}
  else if global.gameProgress>=3940 and global.gameProgress<=4209 {tChapterName="Chapter 17: What Lies Beneath"}
  else if global.gameProgress>=4210 and global.gameProgress<=4529 {tChapterName="Chapter 18: A New Empire"}
  else if global.gameProgress>=4530 and global.gameProgress<=5049 {tChapterName="Chapter 19: That Which can be Taken"}
  else if global.gameProgress>=5050 and global.gameProgress<=5490 {tChapterName="Chapter 20: Trust"}
  else if global.gameProgress>=5500 {tChapterName="Chapter 21: Distorted Travesty"}
  textDropShadow(tChapterName,contentMenuX+2,contentMenuY-23,textColorMain,textColorShadow,1)

  textDropShadow("Press the [Home] key to reset your controls to the default settings.",mainMenuX+8,mainMenuY+282,textColorMain,textColorShadow,1)

  //----- Prizes -----
  if global.yoshiDoll>=1 {draw_sprite(sPauseM_YoshiDoll,0,contentMenuX+48,contentMenuY-27)}
  if global.yoshiDoll>=2 {draw_sprite(sPauseM_YoshiDoll,1,contentMenuX+76,contentMenuY-27)}
  if global.yoshiDoll>=3 {draw_sprite(sPauseM_YoshiDoll,2,contentMenuX+104,contentMenuY-27)}
  if global.yoshiDoll>=4 {draw_sprite(sPauseM_YoshiDoll,3,contentMenuX+132,contentMenuY-27)}

  //---------- Menu Titles ----------
  draw_set_font(fnt_PauseMenuMain)
  draw_set_color(textColorMain)
  if mainCurPos=1 //------------------------------ PROGRESS ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"PROGRESS")
    var tDiffText,tExtDiffText;
    tExtDiffText=""
    if global.bNightmareMode=0
    {
      if global.difficulty=1 {tDiffText="[ASSIST MODE]"}
      else if global.difficulty=2 {tDiffText="[STANDARD MODE]"}
      if global.bOneHitKillMode=1 {tDiffText="[ACHILLES MODE]"}
    }
    else
    {
      if global.bOneHitKillMode=0 {tDiffText="[NIGHTMARE MODE]"}
      else {tDiffText="[NIGHT TERROR MODE]"}
    }

    if global.permaEasyMode=1 {tExtDiffText=" (E)"}

    draw_text(contentMenuX+106,contentMenuY,string(tDiffText) +string(tExtDiffText))
    menuInfoText="Your overall progress and status."
    menuProgress()
  }
  else if mainCurPos=2 //------------------------------ EQUIPMENT ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"EQUIPMENT")
    menuInfoText="Change your equipment and use potions to heal."
    menuEquipment()

    if subMenu=2
    {
      if mEq_CurPos=7 or mEq_CurPos=8
      {
        menuInfoText=""
        if bottles[mEq_CurPos-7]="1"
          menuInfoText="Empty Bottle#You can fill it with useful things."
        else if bottles[mEq_CurPos-7]="2"
          menuInfoText="Energy Drink#Restores half of your hearts."
        else if bottles[mEq_CurPos-7]="3"
          menuInfoText="Turbo Smoothie#This amazingly tasty drink restores all of your hearts!"
      }
      else
      {
        menuInfoText=string("Select an available equipment slot to assign an item to.#[" +string(global.ctrlActA) +string("]: Check available equipment.#[") +string(global.ctrlActB) +string("]: Unequip current slot."))
      }
      mSAP_FrameCount+=1
      if mSAP_FrameCount mod 8=0
      {
        if mSAP_CurFrame=0 {mSAP_CurFrame=1}
        else {mSAP_CurFrame=0}
      }
      //Display cursor
      draw_sprite(sPauseM_APCursor,mSAP_CurFrame,contentMenuX+mEq_CurX,contentMenuY+mEq_CurY)
    }
  }
  else if mainCurPos=3 //------------------------------ SPEND AP ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"SPEND AP")
    menuInfoText="Spend the AP you have gained on enhancing various aspects of your characters."
    menuSpendAP()
  }
  else if mainCurPos=4 //------------------------------ MAP ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"MAP")
    menuInfoText="View your current location in the world and how many items are in an area."
    menuMap(0)
    if mapDetails>0 {menuDetailsMap()}
    if global.debugMenu=true
    {
      draw_set_color(c_white)
      draw_text(contentMenuX+24,contentMenuY+32,mMap_CurX)
      draw_text(contentMenuX+24,contentMenuY+44,mMap_CurY)
    }
  }
  else if mainCurPos=5 //------------------------------ ABILITY SET ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"ABILITY SET")
    menuInfoText="View your Ability Set power levels and info on how they function."
    if subMenu=5
    {
      if mAS_Character="JERRY"
      {
        if mAS_Ability="LINK"
        {
          if global.hasAbilToken[1]>=1
            menuInfoText="Excels at close range combat with fast melee strikes, supplemented by powerful arrows and unlimited bombs."
          else {menuInfoText="You have not obtained Jerry's 1st Ability Set."}
        }
        else if mAS_Ability="MEGA MAN"
        {
          if global.hasAbilToken[3]>=1
            menuInfoText="Provides multi-charge levels with the X-Buster as well as a wide range of special weapons. The only downside being the special weapon energy runs out quickly."
          else {menuInfoText="You have not obtained Jerry's 2nd Ability Set."}
        }
        else if mAS_Ability="GAME"
        {
          if global.hasAbilToken[5]>=1 or global.hasAbilToken[6]>=1
            menuInfoText="Does not seem to be linked to any specific game. Looks to be some prototype abilities in alpha stages of the program."
          else {menuInfoText="You have not obtained this Ability Set."}
        }
      }
      else if mAS_Character="CLAIRE"
      {
        if mAS_Ability="BELMONT"
        {
          if global.hasAbilToken[2]>=1
            menuInfoText="Provides decent melee range at the cost of attack speed, with exceptionally fast daggers, as well as slow but powerful bottles of holy water."
          else {menuInfoText="You have not obtained Claire's 1st Ability Set."}
        }
        else if mAS_Ability="SAMUS"
        {
          if global.hasAbilToken[4]>=1
            menuInfoText="Provides good coverage with the Cannon, but it heats up quick and the shots aren't quite as strong as others. Luckily Missiles excel in damage output."
          else {menuInfoText="You have not obtained Claire's 2nd Ability Set."}
        }
        else if mAS_Ability="GAME"
        {
          if global.hasAbilToken[5]>=1 or global.hasAbilToken[6]>=1
            menuInfoText="Does not seem to be linked to any specific game. Looks to be some prototype abilities in alpha stages of the program."
          else {menuInfoText="You have not obtained this Ability Set."}
        }
      }
    }
    if mAS_Ability="GAME"
    {
      if global.hasAbilToken[5]>0 or global.hasAbilToken[6]>0 {menuGate6Set()}
    }
    else {menuAbilitySet()}
  }
  else if mainCurPos=6 //------------------------------ RECORDS / RECOGNITIONS ------------------------------
  {
    if mR_Tab=1
    {
      draw_text(contentMenuX+8,contentMenuY,"RECORDS")
      menuInfoText="View your battle records as well as other pointless records.#Press [Left] or [Right] to view Recognitions."
    }
    else
    {
      draw_text(contentMenuX+8,contentMenuY,"TOKEN RECOGNITIONS")
      menuInfoText="Wait what? There are Achieveme... err Recognitions in this game?!#Press [Left] or [Right] to view Records, but you uh... you probably knew that.#Press [Confirm] to check Recognition info."
    }
    menuRecords()
  }
  else if mainCurPos=7 //------------------------------ OPTIONS ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"OPTIONS")
    menuInfoText="Change various game options to your liking."
    menuOptions()
  }
  else if mainCurPos=8 //------------------------------ TELEPORT ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"TELEPORT")
    menuInfoText="Teleport out of an area."

    if global.gameProgress>=510 //Explain teleport function
    {
      draw_set_alpha(1)
      draw_set_halign(fa_left)
      draw_set_font(fnt_PauseMenuText)
      textDropShadowExt("Hey guys, Jeremy here. I'm pretty sure I can teleport you out of completed Access Gates, as well as most completed overworld dungeons.",contentMenuX+20,contentMenuY+30,textColorMain,textColorShadow,4,14,290)
    }

    if subMenu=8
    {
      menuInfoText="No teleport location available."
      if global.mapTeleport=0 //Not usable
        menuInfoText=string("Not available.")
      else if global.mapTeleport=1 //Gate A
        menuInfoText=string("Teleport to - Stratum Steppe")
      else if global.mapTeleport=2 //Gate B
        menuInfoText=string("Teleport to - Greatest Stretch - North")
      else if global.mapTeleport=3 //Gate C
        menuInfoText=string("Teleport to - Magical Canopy")
      else if global.mapTeleport=4 //Gate D
        menuInfoText=string("Teleport to - Begonia - Floating Isles")
      else if global.mapTeleport=5 //Gate E
        menuInfoText=string("Teleport to - Farreaches - Vault Entrance")
      else if global.mapTeleport=6 //Gate F
        menuInfoText=string("Teleport to - Barrens - Oasis")
      else if global.mapTeleport=7 //Gate G
        menuInfoText=string("Teleport to - Burning Stretch - Land's End")
      else if global.mapTeleport=8 //Gate H
        menuInfoText=string("Teleport to - ?????")
      else if global.mapTeleport=9 //Gate 3 (Megapolis)
      {
        if global.gameProgress>=1840
          menuInfoText=string("Teleport to - Megapolis Map")
        else
          menuInfoText=string("Teleport to - Gate 4 Entrance")
      }
      else if global.mapTeleport=14 //Vault Shift Maze
        menuInfoText=string("Teleport to - Vault Shift Maze Entrance")
      else if global.mapTeleport=15 //Vault (After completing Chapter 10)
        menuInfoText=string("Teleport to - Farreaches - Vault Entrance")
      else if global.mapTeleport=16 //Main_45
        menuInfoText=string("Teleport to - Barrens - Lower Waste")
      else if global.mapTeleport=17 //Gate 6 - Earth Temple
        menuInfoText=string("Teleport to - Gate 6: Earth Temple Entrance")
      else if global.mapTeleport=18 //Gate 6 - Fire Temple
        menuInfoText=string("Teleport to - Gate 6: Fire Temple Entrance")
      else if global.mapTeleport=19 //Gate 6 - Wind Temple
        menuInfoText=string("Teleport to - Gate 6: Wind Temple Entrance")
      else if global.mapTeleport=20 //Gate 6 - Paradise Island
        menuInfoText=string("Teleport to - Gate 6: Paradise Island Entrance")
      else if global.mapTeleport=21 //Gate 6 - Watery Cave
        menuInfoText=string("Teleport to - Gate 6: Watery Cave Entrance")
      else if global.mapTeleport=22 //Subconscious Filter
        menuInfoText=string("Teleport to - Gate 6: Subconscious Filter Exit")
      else if global.mapTeleport=23 //Gate 6 - Doom Castle
        menuInfoText=string("Teleport to - Gate 6: Doom Castle Entrance")
      else if global.mapTeleport=24 //Mountain Temple
        menuInfoText=string("Teleport to - Mountain Temple Entrance")
      else if global.mapTeleport=25 //Displaced Construction Site
        menuInfoText=string("Teleport to - Displaced Construction Site Entrance")
      else if global.mapTeleport=26 //Magical Castle
        menuInfoText=string("Teleport to - Magical Castle Entrance")
      else if global.mapTeleport=27 //Hidden Program Facility
        menuInfoText=string("Teleport to - Hidden Program Facility Entrance")
      else if global.mapTeleport=28 //Bubble Tower
        menuInfoText=string("Teleport to - Bubble Tower Entrance")
      else if global.mapTeleport=29 //Path to the Truth
        menuInfoText=string("Teleport to - Path to the Truth Entrance")
      else if global.mapTeleport=31 //Gate 1
        menuInfoText=string("Teleport to - Gate 1: Entrance")
      else if global.mapTeleport=32 //Gate 2
        menuInfoText=string("Teleport to - Gate 2: Entrance")
      else if global.mapTeleport=33 //Gate 3
        menuInfoText=string("Teleport to - Gate 3: Entrance")
      else if global.mapTeleport=34 //Gate 4
        menuInfoText=string("Teleport to - Gate 4: Entrance")
      else if global.mapTeleport=35 //Gate 5
        menuInfoText=string("Teleport to - Gate 5: Entrance")
      else if global.mapTeleport=36 //Gate 6
        menuInfoText=string("Teleport to - Gate 6: Entrance")
      else if global.mapTeleport=41 //Bubble Tower B
        menuInfoText=string("Teleport to - Bubble Tower B HUB")
    }
  }
  else if mainCurPos=9 //------------------------------ SAVE ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"SAVE")
    menuInfoText="Save your game progress and do other stuff."
    if subMenu=9
    {
      if mS_CurPos=1
        menuInfoText="Save your progress."
      else if mS_CurPos=2
        menuInfoText="Force a Game Over on yourself."
      else if mS_CurPos=3
        menuInfoText="Revert back to last time the game was saved."
      else if mS_CurPos=4
        menuInfoText="Return to the title screen."
    }

    if global.bCanSave=true
      textDropShadow("Save Progress",contentMenuX+19,contentMenuY+24,textColorMain,textColorShadow,1)
    else
    {
      textDropShadow("Save Progress",contentMenuX+19,contentMenuY+24,make_color_rgb(190,190,190),textColorShadow,1)
      textDropShadow("[Disabled]",contentMenuX+117,contentMenuY+24,make_color_rgb(255,128,128),textColorShadow,1)
    }
    if global.bCanForceGO=true
      textDropShadow("Force Game Over",contentMenuX+19,contentMenuY+50,textColorMain,textColorShadow,1)
    else
    {
      textDropShadow("Force Game Over",contentMenuX+19,contentMenuY+50,make_color_rgb(190,190,190),textColorShadow,1)
      textDropShadow("[Disabled]",contentMenuX+137,contentMenuY+50,make_color_rgb(255,128,128),textColorShadow,1)
    }
    textDropShadow("Load From Last Save Data",contentMenuX+19,contentMenuY+76,textColorMain,textColorShadow,1)
    textDropShadow("Return To Title Screen",contentMenuX+19,contentMenuY+102,textColorMain,textColorShadow,1)
    if subMenu=9 //Display cursor
      draw_sprite(sPauseM_AbilArrow,0,contentMenuX+mS_CurX,contentMenuY+mS_CurY)

    if confirmationMenu>0 //Confirmation menu
    {
      var tConfirmMenuX,tConfirmMenuY;
      tConfirmMenuX=contentMenuX+90
      tConfirmMenuY=contentMenuY+48
      draw_sprite(sMenu_ConfirmMenu,0,tConfirmMenuX,tConfirmMenuY)
      draw_sprite(sPauseM_AbilArrow,0,tConfirmMenuX+15,tConfirmMenuY+14+(confirmMenuPos*19))
    }
  }

  if subMenu=11 //------------------------------ CONTROLS ------------------------------
  {
    draw_sprite(sPauseM_ControlMain,0,contentMenuX+122,contentMenuY+17)
    menuInfoText="Change the control setup. This is for keyboard controls only. It only changes gamepad controls if you're using 3rd party software to bind keys to controller inputs."
    //Display cursor
    draw_sprite(sPauseM_AbilArrow,0,contentMenuX+122+mCon_CurX,contentMenuY+17+mCon_CurY)
    //Display current controls
    draw_set_halign(fa_center)
    textDropShadow(global.ctrlUp,contentMenuX+259,contentMenuY+33,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlDown,contentMenuX+259,contentMenuY+45,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlLeft,contentMenuX+259,contentMenuY+57,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlRight,contentMenuX+259,contentMenuY+69,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlJump,contentMenuX+259,contentMenuY+81,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlCharSwap,contentMenuX+259,contentMenuY+93,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlAbilSwap,contentMenuX+259,contentMenuY+105,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlActA,contentMenuX+259,contentMenuY+117,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlActB,contentMenuX+259,contentMenuY+129,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlActC,contentMenuX+259,contentMenuY+141,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlDashLeft,contentMenuX+259,contentMenuY+153,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlDashRight,contentMenuX+259,contentMenuY+165,textColorMain,textColorShadow,1)
  }
  else if subMenu=12 //------------------------------ ITEM LIST ------------------------------
  {
    menuInfoText=""
    var tItemMX,iItemMY;
    iItemMX=1
    iItemMY=2
    draw_set_color(make_color_rgb(0,120,104))
    draw_rectangle(contentMenuX+iItemMX,contentMenuY+iItemMY,contentMenuX+iItemMX+319,contentMenuY+iItemMY+133,0)
    draw_set_color(make_color_rgb(224,128,40))
    draw_rectangle(contentMenuX+iItemMX,contentMenuY+iItemMY,contentMenuX+iItemMX+319,contentMenuY+iItemMY+133,1)
    //Display slots
    var i,ii; for(i=0;i<4;i+=1)
    {
      for(ii=0;ii<10;ii+=1)
      {
        draw_sprite(sPauseM_ItemSlot,0,contentMenuX+iItemMX+7+(ii*31),contentMenuY+iItemMY+7+(i*31))
      }
    }
    //Display item icons
    draw_set_halign(fa_left)
    draw_set_font(fnt_PauseMenuMain)
    for(i=0;i<10;i+=1)
    {
      if items[i]!=0
      {
        draw_sprite(sEquipItemIcons,items[i]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+20)
        if eCheck[i]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+20,textColorMain,make_color_rgb(12,16,15),4)
      }
      if items[i+10]!=0
      {
        draw_sprite(sEquipItemIcons,items[i+10]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+51)
        if eCheck[i+10]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+51,textColorMain,make_color_rgb(12,16,15),4)
      }
      if items[i+20]!=0
      {
        draw_sprite(sEquipItemIcons,items[i+20]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+82)
        if eCheck[i+20]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+82,textColorMain,make_color_rgb(12,16,15),4)
      }
      if items[i+30]!=0
      {
        draw_sprite(sEquipItemIcons,items[i+30]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+113)
        if eCheck[i+30]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+113,textColorMain,make_color_rgb(12,16,15),4)
      }
    }

    equipCheck[1]=""
    equipCheck[3]=""
    if mItem_CurY=1
    {
      if items[mItem_CurX-1]!=0
        equipmentInit(2,mItem_CurX)
    }
    else if mItem_CurY=2
    {
      if items[mItem_CurX+9]!=0
        equipmentInit(2,mItem_CurX+10)
    }
    else if mItem_CurY=3
    {
      if items[mItem_CurX+19]!=0
        equipmentInit(2,mItem_CurX+20)
    }
    else if mItem_CurY=4
    {
      if items[mItem_CurX+29]!=0
        equipmentInit(2,mItem_CurX+30)
    }

    menuInfoText=equipCheck[3]
    //Display item slot info
    if equipCheck[1]!=""
    {
      draw_set_font(fnt_PauseMenuText)
      draw_set_halign(fa_left)
      draw_set_color(textColorMain)
      draw_text(infoMenuX+87,infoMenuY+2,">>" +string(equipCheck[1]))
    }

    mSAP_FrameCount+=1
    if mSAP_FrameCount mod 8=0
    {
      if mSAP_CurFrame=0 {mSAP_CurFrame=1}
      else {mSAP_CurFrame=0}
    }
    //Display cursor
    draw_sprite(sPauseM_APCursor,mSAP_CurFrame,contentMenuX+iItemMX+20+((mItem_CurX-1)*mItem_CurInc),contentMenuY+iItemMY+20+((mItem_CurY-1)*mItem_CurInc))
  }
  else if subMenu=13 //------------------------------ RECOGNITIONS ------------------------------
  {
    //Display cursor
    draw_sprite(sPauseM_Cursor,0,contentMenuX+7,contentMenuY+9+(mR_RecCurPos*24))
  }
  else if subMenu=14 //------------------------------ GAMEPAD SETUP ------------------------------
  {
    var tGamepadMenuX,tGamepadMenuY;
    tGamepadMenuX=contentMenuX-32
    tGamepadMenuY=contentMenuY-20
    draw_sprite(sPauseM_GamepadSetup,0,tGamepadMenuX,tGamepadMenuY)
    menuInfoText="Change the gamepad control setup. This is only if you're using the built in gamepad controls. Keep in mind this is suited to the X-Box controller. Some gamepads, such as those with the face buttons as [1,2,3,4] may have a different configuration than shown."

    //Display number of gamepad profiles
    draw_set_font(fnt_PauseMenuText)
    draw_set_halign(fa_left)
    draw_set_alpha(1)
    draw_set_color(c_white)
    draw_text(contentMenuX+146,contentMenuY-19,string(global.optGamepadSetup) +string("/") +string(mO_OptConMax))

    //Display stick dead zone
    draw_set_halign(fa_center)
    draw_text(tGamepadMenuX+185,tGamepadMenuY+53,string(round(global.optStickDeadZone*100)) +string("%"))

    //Display current controls
    if global.optGamepadSetup=1 //----- 1.0 JERRY -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.0 JERRY")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Dash Left")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Dash Right")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Character Swap")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Ability Swap")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Action A")
    }
    else if global.optGamepadSetup=2 //----- 1.1 JEREMY -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.1 JEREMY")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Dash Left")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Dash Right")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Action A")
    }
    else if global.optGamepadSetup=3 //----- 1.2 CLAIRE -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.2 CLAIRE")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Dash Left")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Dash Right")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Character Swap")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Ability Swap")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Jump")
    }
    else if global.optGamepadSetup=4 //----- 1.3 CHAO -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.3 CHAO")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Dash Left")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Dash Right")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Jump")
    }
    else if global.optGamepadSetup=5 //----- 2.0 SWITCH PRO CONTROLLER -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"2.0 SWITCH PRO CONTROLLER")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Dash Left")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Dash Right")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Character Swap")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Ability Swap")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Action A")
    }
    else if global.optGamepadSetup=6 //----- 2.1 HITBOX CONTROLLER -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"2.1 HITBOX CONTROLLER")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Action C")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Dash Right")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Dash Left")
    }
    else if global.optGamepadSetup=7 //----- 2.2 DS4 CONTROLLER -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"2.2 DS4 CONTROLLER")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Jump")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Dash Left")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Dash Right")
    }
  }

  //---------- Menu Info ----------
  draw_set_alpha(1)
  draw_set_halign(fa_left)
  draw_set_font(fnt_PauseMenuText)
  textDropShadowExt(menuInfoText,infoMenuX+8,infoMenuY+15,textColorMain,textColorShadow,1,12,426)

  /*
  for(i=0;i<3;i+=1)
  {
    textDropShadow(global.equipJerry[i],contentMenuX-96,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
    textDropShadow(global.equipClaire[i],contentMenuX-80,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
  }
  for(i=0;i<24;i+=1)
  {
    textDropShadow(eCheck[i],contentMenuX-64,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
    textDropShadow(items[i],contentMenuX-48,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
  }
  textDropShadow(global.equipItems,contentMenuX-32,contentMenuY-32,textColorMain,make_color_rgb(12,16,15),4)
  */
}
