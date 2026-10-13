if gDeltaDoTicks != 1 { exit; }
if oKeyCodes.kCodePressed[1]=1
{
  playSound(global.snd_MenuCursor,0,1,1)
  if cursorPos=1
  {
    cursorPos=cursorMax
    cursorX+=cursorInc*(cursorMax-1)
  }
  else
  {
    cursorPos-=1
    cursorX-=cursorInc
  }
}
else if oKeyCodes.kCodePressed[2]=1
{
  playSound(global.snd_MenuCursor,0,1,1)
  if cursorPos=cursorMax
  {
    cursorPos=1
    cursorX-=cursorInc*(cursorMax-1)
  }
  else
  {
    cursorPos+=1
    cursorX+=cursorInc
  }
}

//if oKeyCodes.kCodePressed[5]=1
if oKeyCodes.kCodePressed[15]=1 //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
{
  if cursorPos=1
  {
    if oPlayer1.currentMoney!=404
    {
      if oPlayer1.currentMoney>=healCost
      {
        playSound(global.snd_MenuConfirm,0,1,1)

        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,4)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNoticeSS)
          tAchievement.myAchievement="A Cookie For You"; tAchievement.checkNum=4
        }

        oPlayer1.currentMoney-=healCost //Take money
        global.pMoney-=healCost
        global.recInterSpent+=healCost

        global.pLife=global.pMaxLife
        oPlayer1.life=oPlayer1.maxLife
        global.pGreenLife=0

        var tEquipA,tEquipB,tEquipC;
        tEquipA=0; tEquipB=0; tEquipC=0
        if global.alterEquip=0
        {
        for(i=0;i<3;i+=1)
        {
          if global.equipJerry[i]=23
          {
            tEquipA=15
            break;
          }
        }
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=21
          {
            tEquipB=10
            break;
          }
        }
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=22
          {
            tEquipC=10
            break;
              }
          }
        }
        global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
        global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-tEquipA
        global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
        global.hudMega_BusterEn[0]=32
        global.hudMega_ShotIceEn[0]=32
        global.hudMega_GravityEn[0]=32
        global.hudSamus_CannonEn[0]=0
        global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
        global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
        bWindowClose=1
      }
      else //Not enough internetz
      {
        if global.bNightmareMode=0
        {
          playSound(global.snd_Error,0,1,1)
          msgCreate(120,120,"","Wow, you don't even have 1 Internet? Haha, you're such a loser.",7,1,oMessagePerson,0)
          newMessage.fadingTime=55
        }
        else
        {
          playSound(global.snd_Error,0,1,1)
          msgCreate(120,120,"","Whoa there, you have negative money... NEGATIVE MONEY!! HOW DID YOU EVEN DO THAT?!",7,2,oMessagePerson,0)
          newMessage.fadingTime=55
        }
      }
    }
    else //Money count is 404
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","There is an error with your current Internetz balance. Please check your balance and try again later.",7,2,oMessagePerson,0)
      newMessage.fadingTime=55
    }
  }
  else if cursorPos=2 //Close shop window
  {
    bWindowClose=1
  }
}

//if oKeyCodes.kCodePressed[6]=1 //Close shop window
if oKeyCodes.kCodePressed[16]=1 //Close shop window //gamepad change: menu Confirm/Back (15/16: on a gamepad always A/B)
  bWindowClose=1

if bWindowClose=1
{
  io_clear()
  scrKeyCarryClear() //key carry change (added): the left/right keys carried through a screen transition are cleared too
  resetKeyCodes()
  playSound(global.snd_MenuCancel,0,1,1)
  global.gamePaused=false
  instance_destroy()
}
