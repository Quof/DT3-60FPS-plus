if gDeltaDoTicks != 1 { exit; }
//global.recTimeInMenu+=1
if titleMode=0 {global.recTimeInMenu+=1} //title options change: a game record
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

  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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

  //if oKeyCodes.kCodePressed[5]=1 //Goto item menu or use potion
  if oKeyCodes.kCodePressed[15]=1 //Goto item menu or use potion //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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

  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    //dark omen change (added): no skills are learned while the New Dark Omen is on (scrOmenState: the skill tree is
    //Nightmare Mode's then, and the real one comes back when it's taken off)
    if global.omenActive=1 and info_Index!=-1
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","Skills can't be learned while the Dark Omen is equipped.",7,2,oMessagePerson,0)
      newMessage.fadingTime=45
    }
    //if global.pAP>=info_Cost and info_Index!=-1
    else if global.pAP>=info_Cost and info_Index!=-1 //dark omen change: "else" added
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

    //if oKeyCodes.kCodePressed[5]=1
    if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
    {
      mR_RecCurPos=1
      subMenu=13
    }
  }
}
else if subMenu=7 //---------- OPTIONS ----------
{
  //if mO_OptSubMenu=2
  //if mO_OptSubMenu=2 and titleMode=0 //title options change: "birds seen" is a game record
  if mO_OptSubMenu=3 and titleMode=0 //title options change: "birds seen" is a game record //options move change: the hats are on Display now
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
  //else if oKeyCodes.kCodePressed[9]=1 //Opt Menu Left
  else if oKeyCodes.kCodePressed[17]=1 //Opt Menu Left //options tabs change: always U / L1 (scrController 17), not Swap Character
  {
    playSound(global.snd_MenuCursor,0,1,1)
    mO_CurPos=1
    if mO_OptSubMenu=1 {mO_OptSubMenu=6}
    else {mO_OptSubMenu-=1}
  }
  //else if oKeyCodes.kCodePressed[10]=1 //Opt Menu Right
  else if oKeyCodes.kCodePressed[18]=1 //Opt Menu Right //options tabs change: always I / R1 (scrController 18), not Swap Ability
  {
    playSound(global.snd_MenuCursor,0,1,1)
    mO_CurPos=1
    if mO_OptSubMenu=6 {mO_OptSubMenu=1}
    else {mO_OptSubMenu+=1}
  }

  //if mO_OptSubMenu=1 {mO_OptMax=9} //Control
  //if mO_OptSubMenu=1 {mO_OptMax=10} //Control //gamepad change: + Stick Dead Zone (it was on the old Gamepad Setup screen)
  //if mO_OptSubMenu=1 {mO_OptMax=11} //Control //dt4 dash change: + DT4 Dashing (row 6)
  if mO_OptSubMenu=1 {mO_OptMax=9+(2*global.nicheDashSettings)} //Control //niche dash change: 11 rows with Niche Dash Settings, 9 without (see mO_CtrlItem)
  //else if mO_OptSubMenu=2 {mO_OptMax=10} //Graphics
  //else if mO_OptSubMenu=2 {mO_OptMax=10+mCZ_Show} //Graphics //color zone change: + Color Zone Colors once it's shown (row 9, the hats move to 10/11)
  else if mO_OptSubMenu=2 {mO_OptMax=9+mCZ_Show} //Graphics //options move change: + FPS (row 2), - the hats (on Display now); Color Zone Colors is row 10
  //else if mO_OptSubMenu=3 {mO_OptMax=9} //Display
  else if mO_OptSubMenu=3 {mO_OptMax=11} //Display //options move change: + Jerry's Hat and Claire's Hat (rows 10/11)
  //else if mO_OptSubMenu=4 {mO_OptMax=10} //Gameplay
  else if mO_OptSubMenu=4 {mO_OptMax=11} //Gameplay //dipswitch change: + Customize Remastered Changes
  else if mO_OptSubMenu=5 {mO_OptMax=7} //Unreal Guy
  else if mO_OptSubMenu=6 {mO_OptMax=6} //Audio // music loop

  //niche dash change (added): which Control option is on the cursor's row (mO_CtrlItem; the Control code below checks this).
  //1-11 are the rows with Niche Dash Settings on (D-Pad Dash 4, Right is Forward 5, DT4 Dashing 6). With it off, row 4 is
  //Left/Right Dashing (12) instead of those three, and the rows after it move up two.
  mO_CtrlItem=mO_CurPos
  if global.nicheDashSettings=0
  {
    if mO_CurPos=4 {mO_CtrlItem=12}
    else if mO_CurPos>=5 {mO_CtrlItem=mO_CurPos+2}
  }

  if scrController(1) and cursorRepeatMove mod 2=0 //----- Left -----
  {
    if mO_OptSubMenu=2
    {
      //if mO_CurPos=3 //Window Scaling
      if mO_CurPos=4 //Window Scaling //options move change: a row lower (FPS is row 2)
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
      else if mO_CurPos=2 //FPS //fps option change (added): down a step (120, 60, 30, then around to 120)
      {
        //if oKeyCodes.kCodePressed[1]=1
        if oKeyCodes.kCodePressed[1]=1 and titleMode=1 //fps title only change: only from the title screen
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if global.gameFrameRate>=120 {scrSetFrameRate(60)}
          else if global.gameFrameRate>=60 {scrSetFrameRate(30)}
          else {scrSetFrameRate(120)}
        }
        else if oKeyCodes.kCodePressed[1]=1 {scrFPSLockedMsg()} //fps title only change (added)
      }
      //options move change: the hats are on Display now (below)
      ////else if mO_CurPos=9 or mO_CurPos=10 //Hat cycle
      //else if mO_CurPos=mCZ_HatRow or mO_CurPos=mCZ_HatRow+1 //Hat cycle //color zone change: a row lower when Color Zone Colors is shown
      //{
      //  if oKeyCodes.kCodePressed[1]=1
      //  {
      //    playSound(global.snd_MenuCursor,0,1,1)
      //    //if mO_CurPos=9
      //    if mO_CurPos=mCZ_HatRow //color zone change
      //    {
      //      if global.wearingHatJ=0 {global.wearingHatJ=maxHats}
      //      else {global.wearingHatJ-=1}
      //    }
      //    else
      //    {
      //      if global.wearingHatC=0 {global.wearingHatC=maxHats}
      //      else {global.wearingHatC-=1}
      //    }
      //  }
      //}
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
      else if mO_CurPos=mCZ_HatRow or mO_CurPos=mCZ_HatRow+1 //Hat cycle //options move change (added): from Graphics
      {
        if oKeyCodes.kCodePressed[1]=1
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if mO_CurPos=mCZ_HatRow
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
          if titleMode=1 //title options change (added): the title music isn't global.currentMusic, and findMusic(0) stops all music
          {
            //if global.optMusic>0 {SS_SetSoundVol(global.msc_TitleMenu,global.optMusic*100)}
            if global.optMusic>0 {SS_SetSoundVol(global.msc_TitleMenu,scrMusicVolume(getReplayGain(9000)))} //remastered music change: the same volume as the rest of the music (scrMusicVolume), with the title music's own loudness adjustment
            else {SS_StopSound(global.msc_TitleMenu)}
          }
          else
          {
          var tempMplay;
          tempMplay=findMusic(global.currentMusic)
          //SS_SetSoundVol(tempMplay,global.optMusic*100)
          SS_SetSoundVol(tempMplay,scrMusicVolume(global.currentMusicGain)) //remastered music change: the volume playMusic gives it (scrMusicVolume), not the old formula's
          if global.optMusic=0 {stopAllMusic()}
          }
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
    else if mO_OptSubMenu=1 //gamepad change (added)
    {
      //if mO_CurPos=10 //Stick Dead Zone (20-80%, as on the old Gamepad Setup screen)
      if mO_CtrlItem=11 //Stick Dead Zone (20-80%, as on the old Gamepad Setup screen) //dt4 dash change: a row lower //niche dash change: mO_CtrlItem
      {
        if oKeyCodes.kCodePressed[1]=1
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if global.optStickDeadZone<=0.2 {global.optStickDeadZone=0.8}
          else {global.optStickDeadZone=round((global.optStickDeadZone-0.05)*20)/20}
        }
      }
    }
  }
  else if scrController(2) and cursorRepeatMove mod 2=0 //----- Right -----
  {
    if mO_OptSubMenu=2
    {
      //if mO_CurPos=3 //Window Scaling
      if mO_CurPos=4 //Window Scaling //options move change: a row lower (FPS is row 2)
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
      else if mO_CurPos=2 //FPS //fps option change (added): up a step (30, 60, 120, then around to 30), as F2 does
      {
        //if oKeyCodes.kCodePressed[2]=1
        if oKeyCodes.kCodePressed[2]=1 and titleMode=1 //fps title only change: only from the title screen
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if global.gameFrameRate<60 {scrSetFrameRate(60)}
          else if global.gameFrameRate<120 {scrSetFrameRate(120)}
          else {scrSetFrameRate(30)}
        }
        else if oKeyCodes.kCodePressed[2]=1 {scrFPSLockedMsg()} //fps title only change (added)
      }
      //options move change: the hats are on Display now (below)
      ////else if mO_CurPos=9 or mO_CurPos=10 //Hat cycle
      //else if mO_CurPos=mCZ_HatRow or mO_CurPos=mCZ_HatRow+1 //Hat cycle //color zone change: a row lower when Color Zone Colors is shown
      //{
      //  if oKeyCodes.kCodePressed[2]=1
      //  {
      //    playSound(global.snd_MenuCursor,0,1,1)
      //    //if mO_CurPos=9
      //    if mO_CurPos=mCZ_HatRow //color zone change
      //    {
      //      if global.wearingHatJ=maxHats {global.wearingHatJ=0}
      //      else {global.wearingHatJ+=1}
      //    }
      //    else
      //    {
      //      if global.wearingHatC=maxHats {global.wearingHatC=0}
      //      else {global.wearingHatC+=1}
      //    }
      //  }
      //}
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
      else if mO_CurPos=mCZ_HatRow or mO_CurPos=mCZ_HatRow+1 //Hat cycle //options move change (added): from Graphics
      {
        if oKeyCodes.kCodePressed[2]=1
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if mO_CurPos=mCZ_HatRow
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
          if titleMode=1 //title options change (added): see above
          {
            global.optMusic+=1
            if !SS_IsSoundLooping(global.msc_TitleMenu) {SS_LoopSound(global.msc_TitleMenu)}
            //SS_SetSoundVol(global.msc_TitleMenu,global.optMusic*100)
            SS_SetSoundVol(global.msc_TitleMenu,scrMusicVolume(getReplayGain(9000))) //remastered music change: the same volume as the rest of the music (scrMusicVolume), with the title music's own loudness adjustment
          }
          else
          {
          var prevVol,tempMplay;
          prevVol=global.optMusic
          tempMplay=findMusic(global.currentMusic)
          global.optMusic+=1
          if prevVol=0 {playMusic(tempMplay,0,0)}
          //SS_SetSoundVol(tempMplay,global.optMusic*100)
          SS_SetSoundVol(tempMplay,scrMusicVolume(global.currentMusicGain)) //remastered music change: the volume playMusic gives it (scrMusicVolume), not the old formula's
          }
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
    else if mO_OptSubMenu=1 //gamepad change (added)
    {
      //if mO_CurPos=10 //Stick Dead Zone
      if mO_CtrlItem=11 //Stick Dead Zone //dt4 dash change: a row lower //niche dash change: mO_CtrlItem
      {
        if oKeyCodes.kCodePressed[2]=1
        {
          playSound(global.snd_MenuCursor,0,1,1)
          if global.optStickDeadZone>=0.8 {global.optStickDeadZone=0.2}
          else {global.optStickDeadZone=round((global.optStickDeadZone+0.05)*20)/20}
        }
      }
    }
  }

  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    resetKeyCodes()
    //if mO_OptSubMenu!=5 {playSound(global.snd_MenuConfirm,0,1,1)}
    //if mO_OptSubMenu!=5 and !(mO_OptSubMenu=1 and mO_CtrlItem=6 and global.optRightIsForward=0) {playSound(global.snd_MenuConfirm,0,1,1)} //dt4 dash change: not for DT4 Dashing while it's greyed out
    if mO_OptSubMenu!=5 and !(mO_OptSubMenu=1 and mO_CtrlItem=6 and global.optRightIsForward=0) and !(mO_OptSubMenu=2 and mO_CurPos=2 and titleMode=0) {playSound(global.snd_MenuConfirm,0,1,1)} //dt4 dash change: not for DT4 Dashing while it's greyed out //fps title only change: nor FPS outside the title screen

    if mO_OptSubMenu=1 //---------- CONTROL ----------
    {
      //if mO_CurPos=1 //Change Controls
      if mO_CtrlItem=1 //Change Controls //niche dash change: mO_CtrlItem (the Control rows depend on Niche Dash Settings)
      {
        subMenu=11
      }
      //else if mO_CurPos=2 //Gamepad setup
      else if mO_CtrlItem=2 //Gamepad setup //niche dash change
      {
        subMenu=14
        mGP_Listen=0 //gamepad change (added)
      }
      //else if mO_CurPos=3 //Gamepad input
      else if mO_CtrlItem=3 //Gamepad input //niche dash change
      {
        if global.optGamePad=1 {global.optGamePad=0}
        else {global.optGamePad=1}
      }
      //else if mO_CurPos=4 //D-Pad Dash
      else if mO_CtrlItem=4 //D-Pad Dash //niche dash change
      {
        if global.optDPadDash=1 {global.optDPadDash=0}
        else {global.optDPadDash=1}
      }
      //else if mO_CurPos=5 //Right is Forward
      else if mO_CtrlItem=5 //Right is Forward //niche dash change
      {
        if global.optRightIsForward=1 {global.optRightIsForward=0}
        else {global.optRightIsForward=1}
      }
      else if mO_CtrlItem=6 //DT4 Dashing //dt4 dash change (added): only while Right is Forward is on (it's greyed out otherwise)
      {
        if global.optRightIsForward=1
        {
          if global.optDT4Dash=1 {global.optDT4Dash=0}
          else {global.optDT4Dash=1}
        }
        else {playSound(global.snd_Error,0,1,1)}
      }
      else if mO_CtrlItem=12 //Left/Right Dashing //niche dash change (added): shown in place of rows 4-6 without Niche Dash Settings
      {
        //On: plain left/right dashes (Right is Forward and DT4 Dashing off). Off: Right is Forward with DT4 Dashing, the
        //default. It has no setting of its own (it shows Right is Forward the other way around), so flipping Niche Dash
        //Settings never shows the two disagreeing.
        if global.optRightIsForward=1 {global.optRightIsForward=0; global.optDT4Dash=0}
        else {global.optRightIsForward=1; global.optDT4Dash=1}
      }
      //else if mO_CurPos=6 //Show Key State
      else if mO_CtrlItem=7 //Show Key State //dt4 dash change: a row lower //niche dash change: mO_CtrlItem
      {
        if global.optShowKeyState=1 {global.optShowKeyState=0}
        else {global.optShowKeyState=1}
      }
      //else if mO_CurPos=7 //Cursor Repeat
      else if mO_CtrlItem=8 //Cursor Repeat //dt4 dash change: a row lower //niche dash change: mO_CtrlItem
      {
        global.optCursorRepeat+=1
        if global.optCursorRepeat=6 {global.optCursorRepeat=1}
      }
      //else if mO_CurPos=8 //Keep Menu Position
      else if mO_CtrlItem=9 //Keep Menu Position //dt4 dash change: a row lower //niche dash change: mO_CtrlItem
      {
        if global.optKeepMenuPos>0 {global.optKeepMenuPos=0}
        else {global.optKeepMenuPos=1}
      }
      //else if mO_CurPos=9 //Swap Type
      else if mO_CtrlItem=10 //Swap Type //dt4 dash change: a row lower //niche dash change: mO_CtrlItem
      {
        //global.optSwapType+=1
        //if global.optSwapType>=4 {global.optSwapType=0}
        //standard fixed change: Standard (Fixed) is 4 (so saved settings keep their meaning) but comes right after
        //Standard: 0, 4, 1, 2, 3
        if global.optSwapType=0 {global.optSwapType=4}
        else if global.optSwapType=4 {global.optSwapType=1}
        else {global.optSwapType+=1; if global.optSwapType>=4 {global.optSwapType=0}}
      }
      //else if mO_CurPos=10 //Stick Dead Zone //gamepad change (added)
      else if mO_CtrlItem=11 //Stick Dead Zone //gamepad change (added) //dt4 dash change: a row lower //niche dash change: mO_CtrlItem
      {
        if global.optStickDeadZone>=0.8 {global.optStickDeadZone=0.2}
        else {global.optStickDeadZone=round((global.optStickDeadZone+0.05)*20)/20}
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
      else if mO_CurPos=2 //FPS //fps option change (added): 30, 60, 120, then around to 30, as F2 does
      {
        if titleMode=0 {scrFPSLockedMsg()} //fps title only change (added): only from the title screen
        //if global.gameFrameRate<60 {scrSetFrameRate(60)}
        else if global.gameFrameRate<60 {scrSetFrameRate(60)} //fps title only change: "else" added
        else if global.gameFrameRate<120 {scrSetFrameRate(120)}
        else {scrSetFrameRate(30)}
      }
      //else if mO_CurPos=2 //Set Synchronization
      else if mO_CurPos=3 //Set Synchronization //options move change: a row lower (FPS is row 2)
      {
        if global.optVSync=1 {global.optVSync=0}
        else {global.optVSync=1}
        set_synchronization(global.optVSync)
      }
      //else if mO_CurPos=3 //Window Scaling
      else if mO_CurPos=4 //Window Scaling //options move change: a row lower
      {
        if global.optWindowSize<2 {global.optWindowSize=2}
        else if global.optWindowSize>=2 and global.optWindowSize<3 {global.optWindowSize=3}
        else {global.optWindowSize=1}
        window_set_size(480*global.optWindowSize,352*global.optWindowSize)
        window_center()
      }
      //else if mO_CurPos=4 //Window Resizing
      else if mO_CurPos=5 //Window Resizing //options move change: a row lower
      {
        if global.optCanResizeWindow=1 {global.optCanResizeWindow=0}
        else {global.optCanResizeWindow=1}
        window_set_sizeable(global.optCanResizeWindow)
      }
      //else if mO_CurPos=5 //Low Health Warn
      else if mO_CurPos=6 //Low Health Warn //options move change: a row lower
      {
        if global.optLowHealthWarn=1 {global.optLowHealthWarn=0}
        else {global.optLowHealthWarn=1}
      }
      //else if mO_CurPos=6 //Game Over Settings
      else if mO_CurPos=7 //Game Over Settings //options move change: a row lower
      {
        global.optBitrateExplosion+=1
        if global.optBitrateExplosion>=3 {global.optBitrateExplosion=0}
      }
      //else if mO_CurPos=7 //Player Trail
      else if mO_CurPos=8 //Player Trail //options move change: a row lower
      {
        if global.optPlayerTrail=1 {global.optPlayerTrail=0}
        else {global.optPlayerTrail=1}
      }
      //else if mO_CurPos=8 //Weapon Trail
      else if mO_CurPos=9 //Weapon Trail //options move change: a row lower
      {
        if global.optWeaponTrail=1 {global.optWeaponTrail=0}
        else {global.optWeaponTrail=1}
      }
      //else if mO_CurPos=9 and mCZ_Show=1 //Color Zone Colors //color zone change (added)
      else if mO_CurPos=10 and mCZ_Show=1 //Color Zone Colors //color zone change (added) //options move change: a row lower
      {
        subMenu=16
      }
      //options move change: the hats are on Display now (below)
      ////else if mO_CurPos=9 //Jerry Hat
      //else if mO_CurPos=mCZ_HatRow //Jerry Hat //color zone change: a row lower when Color Zone Colors is shown
      //{
      //  global.wearingHatJ=0
      //}
      ////else if mO_CurPos=10 //Claire Hat
      //else if mO_CurPos=mCZ_HatRow+1 //Claire Hat //color zone change: a row lower when Color Zone Colors is shown
      //{
      //  global.wearingHatC=0
      //}
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
      else if mO_CurPos=mCZ_HatRow //Jerry Hat //options move change (added): from Graphics
      {
        global.wearingHatJ=0
      }
      else if mO_CurPos=mCZ_HatRow+1 //Claire Hat //options move change (added): from Graphics
      {
        global.wearingHatC=0
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
          //oIdentifier.fairyAutoRoam=false
          if instance_exists(oIdentifier) {oIdentifier.fairyAutoRoam=false} //title options change: Chao doesn't exist on the title screen
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
          //oIdentifier.followTarget=oPlayer1
          if instance_exists(oIdentifier) {oIdentifier.followTarget=oPlayer1} //title options change: see Let Chao Roam
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
      else if mO_CurPos=11 //Customize Remastered Changes //dipswitch change (added)
      {
        subMenu=15
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
        if titleMode=1 //title options change (added): mute/max the title music (see the volume code above)
        {
          if global.optMusic=0
          {
            global.optMusic=100
            if !SS_IsSoundLooping(global.msc_TitleMenu) {SS_LoopSound(global.msc_TitleMenu)}
            //SS_SetSoundVol(global.msc_TitleMenu,global.optMusic*100)
            SS_SetSoundVol(global.msc_TitleMenu,scrMusicVolume(getReplayGain(9000))) //remastered music change: the same volume as the rest of the music (scrMusicVolume), with the title music's own loudness adjustment
          }
          else
          {
            global.optMusic=0
            SS_StopSound(global.msc_TitleMenu)
          }
        }
        //if global.optMusic=0
        else if global.optMusic=0 //title options change
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
      else if mO_CurPos=6 // music loop
      {
        if global.optMLoop=1 {global.optMLoop=0}
        else {global.optMLoop=1}
      }
    }
  }
}
else if subMenu=8 //---------- TELEPORT ----------
{
  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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

    //if oKeyCodes.kCodePressed[5]=1
    if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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
          //quick game over change (added): the game over starts here, as the menu closes. It used to start on the player's
          //next Step (its death check, which this is the same as), leaving a frame with neither on screen
          if global.bCanGameOver=1
          {
            if global.BTB_HelmetHead=1
            {
              if !instance_exists(oHelmetHeadEX_GameOver) {stopLoopingSounds(); oPlayer1.gameOver=instance_create(0,0,oHelmetHeadEX_GameOver)}
            }
            else
            {
              if !instance_exists(oGameOver) {stopLoopingSounds(); oPlayer1.gameOver=instance_create(0,0,oGameOver)}
            }
          }
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

  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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
    //else if mCon_CurPos=11 //Dash Back
    else if mCon_CurPos=12 //Dash Back //controls change: Dash Forward is the row above it now
    {
      keyChange=get_string(keyHelpInfo,global.ctrlDashLeft)
      global.ctrlDashLeft=string_upper(keyChange)
    }
    //else if mCon_CurPos=12 //Dash Right
    else if mCon_CurPos=11 //Dash Forward //controls change
    {
      keyChange=get_string(keyHelpInfo,global.ctrlDashRight)
      global.ctrlDashRight=string_upper(keyChange)
    }
    else if mCon_CurPos=13 //Confirm //controls change (added): the menu's Confirm/Cancel, Pause and Cutscene Skip keys
    {
      keyChange=get_string(keyHelpInfo,global.ctrlConfirm)
      global.ctrlConfirm=string_upper(keyChange)
    }
    else if mCon_CurPos=14 //Cancel //controls change (added)
    {
      keyChange=get_string(keyHelpInfo,global.ctrlCancel)
      global.ctrlCancel=string_upper(keyChange)
    }
    else if mCon_CurPos=15 //Pause //controls change (added)
    {
      keyChange=get_string(keyHelpInfo,global.ctrlPause)
      global.ctrlPause=string_upper(keyChange)
    }
    else if mCon_CurPos=16 //Cutscene Skip //controls change (added)
    {
      keyChange=get_string(keyHelpInfo,global.ctrlSkip)
      global.ctrlSkip=string_upper(keyChange)
    }
    //else if mCon_CurPos=13 //Set to default controls
    else if mCon_CurPos=17 //Set to default controls //controls change: the last row is 17 now
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
      global.ctrlConfirm="J" //controls change (added)
      global.ctrlCancel="K" //controls change (added)
      global.ctrlPause="P" //controls change (added)
      global.ctrlSkip="M" //controls change (added)
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
  
  //if oKeyCodes.kCodePressed[5]=1 //Equip item
  if oKeyCodes.kCodePressed[15]=1 //Equip item //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
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
      
      //if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1
      if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1 and scrNormSwordBlocked(mItem_CurX+tIndAdj)=0 //normalized gallery change: no sword equipment in the boss gallery with its lever on
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
      else if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1 //normalized gallery change (added): a sword item while it's blocked
      {
        playSound(global.snd_Error,0,1,1)
        msgCreate(120,120,"","Sword equipment can't be put on in the Boss Gallery while NORMALIZED mode is on.",7,2,oMessagePerson,0)
        newMessage.fadingTime=55
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

      //if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1
      if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1 and scrNormSwordBlocked(mItem_CurX+tIndAdj)=0 //normalized gallery change: no sword equipment in the boss gallery with its lever on
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
      else if eCheck[mItem_CurX-1+tIndAdj]="1" and tIndAdj>-1 //normalized gallery change (added): a sword item while it's blocked
      {
        playSound(global.snd_Error,0,1,1)
        msgCreate(120,120,"","Sword equipment can't be put on in the Boss Gallery while NORMALIZED mode is on.",7,2,oMessagePerson,0)
        newMessage.fadingTime=55
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
  //gamepad change: the preset layouts are replaced by the GAMEPAD list (laid out like CONTROLS): pick an action, then
  //press the button for it on the pad (scrGamepadCapture). The dead zone moved to the Control options. The old code is
  //kept here, commented out.
  /*
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
  */
  var tGPCode,tGPAct,tGPOld;
  if mGP_Listen=1 //---------- Waiting for a button on the pad ----------
  {
    //mGP_ListenTime+=1
    //mGP_ListenTime+=1*gDeltaTime //controls change: 30fps ticks, so the 5 seconds below aren't 2.5/1.25 at 60/120fps
    mGP_ListenTime+=1 //controls change: the Step only runs on 30fps ticks (its first line), so this already counts ticks; *gDeltaTime made the 5 seconds 10/20 at 60/120fps
    if global.gpDevice<0 {mGP_Listen=0; playSound(global.snd_Error,0,1,1)} //the pad was unplugged
    else if mGP_WaitRelease=1 //everything on the pad has to be let go first (the button that picked the action is usually still held)
    {
      if scrGamepadCapture()=0 {mGP_WaitRelease=0}
    }
    else
    {
      tGPCode=scrGamepadCapture()
      if tGPCode>0
      {
        tGPAct=global.gpRowAct[mGP_CurPos]
        tGPOld=global.gpBind[tGPAct]
        //an action that already had this button gets this one's old button, so nothing ends up on two actions
        //for(i=1;i<=14;i+=1) {if global.gpBind[i]=tGPCode and i!=tGPAct {global.gpBind[i]=tGPOld}}
        //global.gpBind[tGPAct]=tGPCode
        //controls change: with Confirm/Cancel, Pause and Cutscene Skip in the list, only actions that can't share a
        //button move (scrControlClash: Confirm/Cancel may share one with a game action). One that moves gets this one's
        //old button, unless something it can't share a button with is on that one too; then it's left without one (-)
        global.gpBind[tGPAct]=tGPCode
        for(i=1;i<=16;i+=1)
        {
          if i!=tGPAct and global.gpBind[i]=tGPCode and scrControlClash(i,tGPAct)
          {
            global.gpBind[i]=tGPOld
            for(ii=1;ii<=16;ii+=1) {if ii!=i and tGPOld>0 and global.gpBind[ii]=tGPOld and scrControlClash(i,ii) {global.gpBind[i]=0}}
          }
        }
        mGP_Listen=0
        playSound(global.snd_MenuConfirm,0,1,1)
        //the button is still held and may now be Confirm or Back: count it as already held, so it doesn't act in the menu
        scrGamepadPoll()
        scrKeyCodesSync()
      }
    }
    //Cancel: the keyboard's Back key, or 5 seconds of nothing (Esc would also bring up the quit question)
    //if mGP_Listen=1 and (mGP_ListenTime>=150 or scrKeyboardCheck(ord(global.ctrlActA)))
    if mGP_Listen=1 and (mGP_ListenTime>=150 or scrKeyboardCheck(ord(global.ctrlCancel))) //controls change: the keyboard's Cancel key
    {
      mGP_Listen=0
      playSound(global.snd_MenuCancel,0,1,1)
    }
    exit //nothing else in the menu reacts while the pad's buttons are being read
  }

  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    //if mGP_CurPos=1 {mGP_CurPos=13}
    if mGP_CurPos=1 {mGP_CurPos=global.gpRows+1} //controls change: 16 action rows, then Set to Default
    else {mGP_CurPos-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    //if mGP_CurPos=13 {mGP_CurPos=1}
    if mGP_CurPos=global.gpRows+1 {mGP_CurPos=1} //controls change
    else {mGP_CurPos+=1}
  }

  //if oKeyCodes.kCodePressed[5]=1
  if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    resetKeyCodes()
    //if mGP_CurPos=13 //Set to Default
    if mGP_CurPos=global.gpRows+1 //Set to Default //controls change
    {
      playSound(global.snd_MenuConfirm,0,1,1)
      scrGamepadDefaults()
      scrGamepadPoll()
      scrKeyCodesSync()
    }
    else if global.gpDevice<0 {playSound(global.snd_Error,0,1,1)} //no pad to read the new button from
    else
    {
      playSound(global.snd_MenuConfirm,0,1,1)
      mGP_Listen=1
      mGP_ListenTime=0
      mGP_WaitRelease=1
      for(i=0;i<16;i+=1) {global.gpCapBase[i]=global.gpAxis[i]}
    }
  }
}
else if subMenu=15 //---------- CUSTOMIZE REMASTERED CHANGES ---------- //dipswitch change (added)
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mDS_CurPos=1 {mDS_CurPos=global.dsCount}
    else {mDS_CurPos-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mDS_CurPos=global.dsCount {mDS_CurPos=1}
    else {mDS_CurPos+=1}
  }
  //autosave change (added): Left/Right step Autosave down/up through off, 5, 15 and 30 minutes (scrAutosaveStep); the
  //on/off dipswitches only use Confirm
  else if global.dsVar[mDS_CurPos-1]="autosaveFreq" and oKeyCodes.kCodePressed[1]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    scrAutosaveStep(-1)
  }
  else if global.dsVar[mDS_CurPos-1]="autosaveFreq" and oKeyCodes.kCodePressed[2]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    scrAutosaveStep(1)
  }

  //if oKeyCodes.kCodePressed[5]=1 //Turn the dipswitch on/off (saved with the options: saveOptions)
  if oKeyCodes.kCodePressed[15]=1 //Turn the dipswitch on/off (saved with the options: saveOptions) //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  {
    resetKeyCodes()
    //playSound(global.snd_MenuConfirm,0,1,1)
    if !scrDSLocked(mDS_CurPos-1) {playSound(global.snd_MenuConfirm,0,1,1)} //dark omen change: not for one that can't be changed right now (below)
    //if variable_global_get(global.dsVar[mDS_CurPos-1])=true {variable_global_set(global.dsVar[mDS_CurPos-1],false)}
    //if global.dsVar[mDS_CurPos-1]="autosaveFreq" {scrAutosaveStep(1)} //autosave change (added): up a step (off, 5, 15, 30, around)
    if scrDSLocked(mDS_CurPos-1) //dark omen change (added): New Dark Omen in the boss gallery or a boss fight (scrDSLocked)
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","New Dark Omen can't be changed in the Boss Gallery or during boss fights.",7,2,oMessagePerson,0)
      newMessage.fadingTime=55
    }
    else if global.dsVar[mDS_CurPos-1]="autosaveFreq" {scrAutosaveStep(1)} //autosave change (added): up a step (off, 5, 15, 30, around) //dark omen change: "else" added
    else if variable_global_get(global.dsVar[mDS_CurPos-1])=true {variable_global_set(global.dsVar[mDS_CurPos-1],false)} //autosave change: "else" added
    else {variable_global_set(global.dsVar[mDS_CurPos-1],true)}
    if global.nicheDashSettings=0 {global.optDT4Dash=global.optRightIsForward} //niche dash change (added): hiding the dash options goes back to one of Left/Right Dashing' two setups (see loadOptions)
  }
}
else if subMenu=16 //---------- COLOR ZONE COLORS: the zones ---------- //color zone change (added)
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mCZ_CurPos=1 {mCZ_CurPos=4}
    else {mCZ_CurPos-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mCZ_CurPos=4 {mCZ_CurPos=1}
    else {mCZ_CurPos+=1}
  }

  if oKeyCodes.kCodePressed[15]=1 //change this zone's color
  {
    resetKeyCodes()
    playSound(global.snd_MenuConfirm,0,1,1)
    subMenu=17
    mCZ_EditPos=1
    mCZ_Hold=0
  }
}
else if subMenu=17 //---------- COLOR ZONE COLORS: change one ---------- //color zone change (added)
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mCZ_EditPos=1 {mCZ_EditPos=4}
    else {mCZ_EditPos-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if mCZ_EditPos=4 {mCZ_EditPos=1}
    else {mCZ_EditPos+=1}
  }

  //Red/Green/Blue: left/right changes it by 1; held, it keeps going after a moment and speeds up after a second
  var tCZDir,tCZStep,tCZr,tCZg,tCZb;
  tCZDir=0
  if mCZ_EditPos<=3
  {
    if scrController(1) {tCZDir=-1}
    else if scrController(2) {tCZDir=1}
  }
  if tCZDir=0 {mCZ_Hold=0}
  else
  {
    mCZ_Hold+=1
    tCZStep=0
    if mCZ_Hold=1 {tCZStep=1; playSound(global.snd_MenuCursor,0,1,1)}
    else if mCZ_Hold>8 and mCZ_Hold<=30 {tCZStep=1}
    else if mCZ_Hold>30 {tCZStep=5}
    if tCZStep>0
    {
      tCZr=color_get_red(global.czColor[mCZ_CurPos])
      tCZg=color_get_green(global.czColor[mCZ_CurPos])
      tCZb=color_get_blue(global.czColor[mCZ_CurPos])
      if mCZ_EditPos=1 {tCZr=median(0,tCZr+(tCZDir*tCZStep),255)}
      else if mCZ_EditPos=2 {tCZg=median(0,tCZg+(tCZDir*tCZStep),255)}
      else {tCZb=median(0,tCZb+(tCZDir*tCZStep),255)}
      global.czColor[mCZ_CurPos]=make_color_rgb(tCZr,tCZg,tCZb)
    }
  }

  if oKeyCodes.kCodePressed[15]=1 and mCZ_EditPos=4 //Default
  {
    resetKeyCodes()
    playSound(global.snd_MenuConfirm,0,1,1)
    global.czColor[mCZ_CurPos]=global.czDefault[mCZ_CurPos]
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
  global.ctrlConfirm="J" //controls change (added)
  global.ctrlCancel="K" //controls change (added)
  global.ctrlPause="P" //controls change (added)
  global.ctrlSkip="M" //controls change (added)
}

//if oKeyCodes.kCodePressed[6]=1 //Go back to a specific submenu
if oKeyCodes.kCodePressed[16]=1 //Go back to a specific submenu //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
{
  resetKeyCodes()
  if titleMode=1 and subMenu=7 //title options change (added): backing out of Options goes back to the title screen
  {
    io_clear()
    scrKeyCarryClear() //key carry change (added): the left/right keys carried through a screen transition are cleared too
    playSound(global.snd_MenuClose,0,1,1)
    saveOptions()
    instance_destroy()
    exit
  }
  if subMenu>0 and subMenu<11 {subMenu=0} //From main submenus to main menu
  //else if subMenu=11 or subMenu=14 {subMenu=7} //From (Control or Gamepad Setup) to Options
  //else if subMenu=11 or subMenu=14 or subMenu=15 {subMenu=7} //From (Control, Gamepad Setup or Remastered Changes) to Options //dipswitch change
  else if subMenu=11 or subMenu=14 or subMenu=15 or subMenu=16 {subMenu=7} //From (Control, Gamepad Setup, Remastered Changes or Color Zone Colors) to Options //color zone change
  else if subMenu=17 {subMenu=16} //From changing a color zone's color back to the zones //color zone change (added)
  else if subMenu=12 {subMenu=2} //From Item list to Equipment
  else if subMenu=13 {subMenu=6} //From Recognitions to Records
  mapDetails=0
}
if keyboard_check_pressed(curInfo) //Show game info
{
  io_clear()
  scrKeyCarryClear() //key carry change (added): the left/right keys carried through a screen transition are cleared too
  show_info()
}

if oKeyCodes.kCodePressed[12]=1 //Close menu
{
  io_clear()
  scrKeyCarryClear() //key carry change (added): the left/right keys carried through a screen transition are cleared too
  resetKeyCodes()
  playSound(global.snd_MenuClose,0,1,1)
  //title options change (added): on the title screen there's no game to unpause and no HUD; save the options and go back
  if titleMode=1 {saveOptions(); instance_destroy(); exit}
  global.gamePaused=false
  oHUD.menuOpen=false
  if global.optKeepMenuPos>0 {global.optKeepMenuPos=mainCurPos+10}
  with oPauseMenu {instance_destroy()}
  instance_destroy()
  exit;
}
