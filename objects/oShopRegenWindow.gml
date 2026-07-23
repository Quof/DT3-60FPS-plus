#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
cursorPos=1
cursorX=54
cursorY=57
cursorInc=69
cursorMax=2
bWindowClose=0

colorBack=make_color_rgb(0,248,0)
colorBorderA=make_color_rgb(0,168,0)
colorBorderB=make_color_rgb(0,96,0)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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

if oKeyCodes.kCodePressed[5]=1
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

        var tEquipA,tEquipB,tEquipC;
        tEquipA=0; tEquipB=0; tEquipC=0
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

if oKeyCodes.kCodePressed[6]=1 //Close shop window
  bWindowClose=1

if bWindowClose=1
{
  io_clear()
  resetKeyCodes()
  playSound(global.snd_MenuCancel,0,1,1)
  global.gamePaused=false
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
shopWinX=view_xview[0]+152
shopWinY=view_yview[0]+112

draw_set_alpha(1)
draw_set_color(colorBack)
draw_rectangle(shopWinX,shopWinY,shopWinX+175,shopWinY+95,0)
draw_set_color(colorBorderB)
draw_rectangle(shopWinX,shopWinY,shopWinX+175,shopWinY+95,1)
draw_set_color(colorBorderA)
draw_rectangle(shopWinX+1,shopWinY+1,shopWinX+174,shopWinY+94,1)

draw_line(shopWinX+1,shopWinY+78,shopWinX+175,shopWinY+78)
draw_line(shopWinX+1,shopWinY+80,shopWinX+175,shopWinY+80)
draw_set_color(colorBorderB)
draw_line(shopWinX+1,shopWinY+79,shopWinX+175,shopWinY+79)

draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text_ext(shopWinX+5,shopWinY+1,string("Would you like a Cookie? It's ") +string(healCost) +string(" Internet and fully restores all your life and ammo!"),-1,170)

draw_sprite_ext(sYoshiGreenStand,0,shopWinX+161,shopWinY+76,-1,1,0,c_white,1)
draw_set_halign(fa_center)
draw_text(shopWinX+55,shopWinY+65,"Sure")
draw_text(shopWinX+124,shopWinY+65,"I'm fine")
draw_sprite(sYoshiCookie,0,shopWinX+cursorX,shopWinY+cursorY)

draw_set_halign(fa_left)
draw_text(shopWinX+50,shopWinY+81,"Internetz:")
draw_text(shopWinX+108,shopWinY+81,oPlayer1.currentMoney)
