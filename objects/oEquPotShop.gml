#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sPauseM_ExtraItemIcons
visible=0
image_speed=0
showMyText=0
helpTextInner=make_color_rgb(219,192,235)
helpTextOuter=make_color_rgb(28,16,3)
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Bottle
{
  if objectNum=1
  {
    indexCheck=string_char_at(global.extraItems,1)
    myCost=250
  }
  else if objectNum=2
  {
    indexCheck=string_char_at(global.extraItems,2)
    otherIndex=string_char_at(global.extraItems,1)
    myCost=4500
  }
}
if type=1 //Equipment slot
{
  image_index=3
  if objectNum=1
  {
    indexCheck=string_char_at(global.extraItems,5)
    myCost=5000
  }
  else if objectNum=2
  {
    indexCheck=string_char_at(global.extraItems,6)
    otherIndex=string_char_at(global.extraItems,5)
    myCost=12500
  }
}
visible=1

if indexCheck!="0" {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if showMyText>0 {showMyText-=1}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMyText=2
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  resetKeyCodes()
  if oPlayer1.currentMoney!=404
  {
    if oPlayer1.currentMoney>=myCost
    {
      bOkayToTakeMoney=0
      //Put item in player stock
      if type=0 //BOTTLES
      {
        if objectNum=1
        {
          oPlayer1.pBottles[0]="2"
          numToUse=1
          bOkayToTakeMoney=1
        }
        else if objectNum=2
        {
          if otherIndex!="0"
          {
            oPlayer1.pBottles[1]="1"
            numToUse=2
            bOkayToTakeMoney=1
          }
        }
      }
      else if type=1 //EQUIPMENT SLOTS
      {
        if objectNum=1
        {
          global.equipJerry[1]=0
          global.equipClaire[1]=0
          numToUse=5
          bOkayToTakeMoney=1
        }
        else if objectNum=2
        {
          if otherIndex!="0"
          {
            global.equipJerry[2]=0
            global.equipClaire[2]=0
            numToUse=6
            bOkayToTakeMoney=1
          }
        }
      }

      if bOkayToTakeMoney=1
      {
        playSound(global.snd_MenuConfirm,0,1,1)
        global.recItemBought+=1
        oPlayer1.currentMoney-=myCost //Take money
        global.pMoney-=myCost
        global.recInterSpent+=myCost

        var tNewString;
        tNewString=string_delete(global.extraItems,numToUse,1)
        tNewString=string_insert("1",tNewString,numToUse)
        global.extraItems=tNewString
        instance_destroy()
      }
    }
    else //Not enough internetz
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","Not enough Internetz. Though one questions why you can't simply take it.",7,2,oMessagePerson,0)
      newMessage.fadingTime=55
    }
  }
  else //Money count is 404
  {
    playSound(global.snd_Error,0,1,1)
    msgCreate(120,120,"","There is an error with your current Internetz balance. Please check your balance and try again later.",7,2,oMessagePerson,0)
    newMessage.fadingTime=55
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if showMyText>0
{
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_middle)
  if type=0 //BOTTLES
  {
    if objectNum=1
    {
      textDropShadow("1 BOTTLE#ONLY 250 INTERNETZ#PRESS UP TO BUY",x,y-70,helpTextInner,helpTextOuter,4)
    }
    else if objectNum=2
    {
      if otherIndex="0"
      {
        textDropShadow("THIS BOTTLE IS NOT#FOR SALE JUST YET",x,y-70,helpTextInner,helpTextOuter,4)
      }
      else
      {
        textDropShadow("1 BOTTLE#ONLY 4500 INTERNETZ#PRESS UP TO BUY",x,y-70,helpTextInner,helpTextOuter,4)
      }
    }
  }
  else if type=1 //EQUIPMENT SLOTS
  {
    if objectNum=1
    {
      textDropShadow("EXPAND EQUIPMENT SLOTS BY 1#ONLY 5000 INTERNETZ#PRESS UP TO BUY",x,y-70,helpTextInner,helpTextOuter,4)
    }
    else if objectNum=2
    {
      if otherIndex="0"
      {
        textDropShadow("THIS EQUIPMENT SLOT IS NOT#FOR SALE JUST YET",x,y-70,helpTextInner,helpTextOuter,4)
      }
      else
      {
        textDropShadow("EXPAND EQUIPMENT SLOTS BY 1#ONLY 12500 INTERNETZ#PRESS UP TO BUY",x,y-70,helpTextInner,helpTextOuter,4)
      }
    }
  }
}
