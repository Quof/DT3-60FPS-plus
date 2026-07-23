#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
init=0
cursorPos=1
cursorX=15
cursorY=32
cursorInc=39

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<5;i+=1)
{
  equipmentInit(1,inventory[i])
  stock[i,0]=equipCheck[0]
  stock[i,1]=equipCheck[1]
  stock[i,2]=equipCheck[2]
  stock[i,3]=equipCheck[3]
  stock[i,4]=equipCheck[4]
}

for(i=0;i<5;i+=1)
{
  bCanBuy[i]=string_char_at(global.extraItems,stock[i,0])
  if stock[i,0]=0
    bCanBuy[i]="0"
}
init=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1
{
  playSound(global.snd_MenuCursor,0,1,1)
  if cursorPos=1
  {
    cursorPos=cursorMax
    cursorY+=cursorInc*(cursorMax-1)
  }
  else
  {
    cursorPos-=1
    cursorY-=cursorInc
  }
}
else if oKeyCodes.kCodePressed[4]=1
{
  playSound(global.snd_MenuCursor,0,1,1)
  if cursorPos=cursorMax
  {
    cursorPos=1
    cursorY-=cursorInc*(cursorMax-1)
  }
  else
  {
    cursorPos+=1
    cursorY+=cursorInc
  }
}

if oKeyCodes.kCodePressed[5]=1
{
  if oPlayer1.currentMoney!=404
  {
    if bCanBuy[cursorPos-1]="0" //In stock
    {
      if oPlayer1.currentMoney>=stock[cursorPos-1,2] //Item bought
      {
        if stock[cursorPos-1,0]=7 or stock[cursorPos-1,0]=8 //Fill potion
        {
          var tBottleCheck;
          for(i=0;i<3;i+=1)
          {
            tBottleCheck=string_char_at(global.extraItems,i+1)
            if tBottleCheck="1"
            {
              playSound(global.snd_MenuConfirm,0,1,1)
              global.recItemBought+=1
              oPlayer1.currentMoney-=stock[cursorPos-1,2] //Take money
              global.pMoney-=stock[cursorPos-1,2]
              global.recInterSpent+=stock[cursorPos-1,2]
              var tNewString;
              tNewString=string_delete(global.extraItems,i+1,1)
              if stock[cursorPos-1,0]=7
              {
                oPlayer1.pBottles[i]="2"
                oPauseMenu.bottles[i]="2"
                tNewString=string_insert("2",tNewString,i+1)
              }
              else if stock[cursorPos-1,0]=8
              {
                oPlayer1.pBottles[i]="3"
                oPauseMenu.bottles[i]="3"
                tNewString=string_insert("3",tNewString,i+1)
              }
              global.extraItems=tNewString
              break;
            }

            if i=2 and tBottleCheck="0"
            {
              playSound(global.snd_Error,0,1,1)
              msgCreate(120,120,"","No empty bottles to put this in.",7,1,oMessagePerson,0)
              newMessage.fadingTime=35
            }
          }
        }
        else //Buy item
        {
          playSound(global.snd_MenuConfirm,0,1,1)
          global.recItemBought+=1
          oPlayer1.currentMoney-=stock[cursorPos-1,2] //Take money
          global.pMoney-=stock[cursorPos-1,2]
          global.recInterSpent+=stock[cursorPos-1,2]
          //Put item in player stock
          var tNewString;
          tNewString=string_delete(global.extraItems,stock[cursorPos-1,0],1)
          tNewString=string_insert("1",tNewString,stock[cursorPos-1,0])
          global.extraItems=tNewString
          bCanBuy[cursorPos-1]="1"
          //Set player bottle slots if those are bought
          if stock[cursorPos-1,0]>=1 and stock[cursorPos-1,0]<=3
          {
            //oPlayer1.pBottles[cursorPos-1]="1"
            oPlayer1.pBottles[1]="1"
          }
          //Set player equip slots if those are bought
          if stock[cursorPos-1,0]>=4 and stock[cursorPos-1,0]<=6
          {
            global.equipJerry[stock[cursorPos-1,0]-4]=0
            global.equipClaire[stock[cursorPos-1,0]-4]=0
          }
        }
      }
      else //Not enough internetz
      {
        playSound(global.snd_Error,0,1,1)
        msgCreate(120,120,"","Not enough Internetz.",7,1,oMessagePerson,0)
        newMessage.fadingTime=35
      }
    }
    else //Item out of stock
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","That item is out of stock.",7,1,oMessagePerson,0)
      newMessage.fadingTime=35
    }
  }
  else //Money count is 404
  {
    playSound(global.snd_Error,0,1,1)
    msgCreate(120,120,"","There is an error with your current Internetz balance. Please check your balance and try again later.",7,2,oMessagePerson,0)
    newMessage.fadingTime=55
  }
}

if oKeyCodes.kCodePressed[6]=1 //Close shop window
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
if init=1
{
  displayShopWindow()
}
