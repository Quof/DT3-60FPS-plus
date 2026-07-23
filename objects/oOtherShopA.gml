#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bShopOpen=0

cursorPos=1
cursorMax=5

cursorPulse=0
cursorTime=0

bNotInStock=0
bNotEnoughMoney=0

textColor=make_color_rgb(190,160,112)

//---------- Item check ----------
heartCheck=string_char_at(global.heartPiece,27)
arrowCheck=string_char_at(global.arrowQuiver,21)
energyCheck=string_char_at(global.heartEnergy,26)
missileCheck=string_char_at(global.missilePack,12)
apCheck=string_char_at(global.apBoost,42)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShopOpen=0
{
  if x<=oPlayer1.x {image_xscale=1}
  else {image_xscale=-1}
}
else
{
  cursorTime+=1
  if cursorTime mod 15=0
  {
    if cursorPulse=0 {cursorPulse=1}
    else {cursorPulse=0}
  }

  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorPos=1 {cursorPos=cursorMax}
    else {cursorPos-=1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorPos=cursorMax {cursorPos=1}
    else {cursorPos+=1}
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    if oPlayer1.currentMoney!=404
    {
      if cursorPos=1 //-------------------- HEART PIECE --------------------
      {
        if heartCheck="0" //In stock
        {
          if (global.bNightmareMode=0 and oPlayer1.currentMoney>=5000) or (global.bNightmareMode=1) //Item bought
          {
            playSound(global.snd_MenuConfirm,0,1,1)
            global.recItemBought+=1
            oPlayer1.currentMoney-=5000 //Take money
            global.pMoney-=5000
            global.recInterSpent+=5000
            //Item message
            if global.bNightmareMode=0
            {
              playSound(global.snd_HeartPiece,0,1,1)
              global.pHeartPieces+=1
              if global.pHeartPieces=4
              {
                msgCreate(170,100,"","Your Max Heart Capacity increased by 1!",6,1,oMessagePerson,0)
                newMessage.fadingTime=70
                global.pMaxLife+=4
                global.pLife+=4
                oPlayer1.maxLife+=4
                oPlayer1.life+=4
                global.pHeartPieces=0
              }
              else
              {
                var tHeartsLeft;
                tHeartsLeft=4-global.pHeartPieces
                msgCreate(170,100,"","You found a Heart Piece!#Only " +string(tHeartsLeft) +string(" more for a full heart!"),6,1,oMessagePerson,0)
                newMessage.fadingTime=70
              }
            }
            else
            {
              playSound(global.snd_MetItemGet,0,0.98,17000)
              msgCreate(170,100,"","You bought a piece of Nightmare Cheese with no money... somehow.",6,1,oMessagePerson,0)
              newMessage.fadingTime=70
            }
            //Put item in player stock
            heartCheck="1"
            var tNewString;
            tNewString=string_delete(global.heartPiece,27,1)
            tNewString=string_insert("1",tNewString,27)
            global.heartPiece=tNewString
          }
          else {bNotEnoughMoney=1}
        }
        else {bNotInStock=1}
      }
      else if cursorPos=2 //-------------------- ARROW QUIVER --------------------
      {
        if arrowCheck="0" //In stock
        {
          if (global.bNightmareMode=0 and oPlayer1.currentMoney>=2000) or (global.bNightmareMode=1) //Item bought
          {
            playSound(global.snd_MenuConfirm,0,1,1)
            global.recItemBought+=1
            oPlayer1.currentMoney-=2000 //Take money
            global.pMoney-=2000
            global.recInterSpent+=2000
            //Item message
            if global.bNightmareMode=0
            {
              playSound(global.snd_HeartPiece,0,1,1)
              global.hudLink_Arrows[0]+=1
              global.hudLink_Arrows[1]+=1
            }
            else
            {
              playSound(global.snd_MetItemGet,0,0.98,17000)
              msgCreate(170,100,"","You bought a piece of Nightmare Cheese with no money... somehow.",6,1,oMessagePerson,0)
              newMessage.fadingTime=70
            }
            //Put item in player stock
            arrowCheck="1"
            var tNewString;
            tNewString=string_delete(global.arrowQuiver,21,1)
            tNewString=string_insert("1",tNewString,21)
            global.arrowQuiver=tNewString
          }
          else {bNotEnoughMoney=1}
        }
        else {bNotInStock=1}
      }
      else if cursorPos=3 //-------------------- HEART ENERGY --------------------
      {
        if energyCheck="0" //In stock
        {
          if (global.bNightmareMode=0 and oPlayer1.currentMoney>=2000) or (global.bNightmareMode=1) //Item bought
          {
            playSound(global.snd_MenuConfirm,0,1,1)
            global.recItemBought+=1
            oPlayer1.currentMoney-=2000 //Take money
            global.pMoney-=2000
            global.recInterSpent+=2000
            //Item message
            if global.bNightmareMode=0
            {
              playSound(global.snd_CVItemGet,0,1,1)
              global.hudBelmont_WeaponEn[0]+=5
              global.hudBelmont_WeaponEn[1]+=5
            }
            else
            {
              playSound(global.snd_MetItemGet,0,0.98,17000)
              msgCreate(170,100,"","You bought a piece of Nightmare Cheese with no money... somehow.",6,1,oMessagePerson,0)
              newMessage.fadingTime=70
            }
            //Put item in player stock
            energyCheck="1"
            var tNewString;
            tNewString=string_delete(global.heartEnergy,26,1)
            tNewString=string_insert("1",tNewString,26)
            global.heartEnergy=tNewString
          }
          else {bNotEnoughMoney=1}
        }
        else {bNotInStock=1}
      }
      else if cursorPos=4 //-------------------- MISSILE PACK --------------------
      {
        if missileCheck="0" //In stock
        {
          if (global.bNightmareMode=0 and oPlayer1.currentMoney>=2000) or (global.bNightmareMode=1) //Item bought
          {
            playSound(global.snd_MenuConfirm,0,1,1)
            global.recItemBought+=1
            oPlayer1.currentMoney-=2000 //Take money
            global.pMoney-=2000
            global.recInterSpent+=2000
            //Item message
            if global.bNightmareMode=0
            {
              playSound(global.snd_MetItemGet,0,1,1)
              global.hudSamus_Missiles[0]+=1
              global.hudSamus_Missiles[1]+=1
            }
            else
            {
              playSound(global.snd_MetItemGet,0,0.98,17000)
              msgCreate(170,100,"","You bought a piece of Nightmare Cheese with no money... somehow.",6,1,oMessagePerson,0)
              newMessage.fadingTime=70
            }
            //Put item in player stock
            missileCheck="1"
            var tNewString;
            tNewString=string_delete(global.missilePack,12,1)
            tNewString=string_insert("1",tNewString,12)
            global.missilePack=tNewString
          }
          else {bNotEnoughMoney=1}
        }
        else {bNotInStock=1}
      }
      else if cursorPos=5 //-------------------- SKILL POINT --------------------
      {
        if apCheck="0" //In stock
        {
          if (global.bNightmareMode=0 and oPlayer1.currentMoney>=1000) or (global.bNightmareMode=1) //Item bought
          {
            playSound(global.snd_MenuConfirm,0,1,1)
            global.recItemBought+=1
            oPlayer1.currentMoney-=1000 //Take money
            global.pMoney-=1000
            global.recInterSpent+=1000
            //Item message
            if global.bNightmareMode=0
            {
              playSound(global.snd_HeartPiece,0,1,1)
              global.pAP+=1
            }
            else
            {
              playSound(global.snd_MetItemGet,0,0.98,17000)
              msgCreate(170,100,"","You bought a piece of Nightmare Cheese with no money... somehow.",6,1,oMessagePerson,0)
              newMessage.fadingTime=70
            }
            //Put item in player stock
            apCheck="1"
            var tNewString;
            tNewString=string_delete(global.apBoost,42,1)
            tNewString=string_insert("1",tNewString,42)
            global.apBoost=tNewString
          }
          else {bNotEnoughMoney=1}
        }
        else {bNotInStock=1}
      }


      if bNotInStock=1 //Item out of stock
      {
        playSound(global.snd_Error,0,1,1)
        msgCreate(120,120,"","That item is out of stock.",7,1,oMessagePerson,0)
        newMessage.fadingTime=35
        bNotInStock=0
      }
      else if bNotEnoughMoney=1 //Not enough internetz
      {
        playSound(global.snd_Error,0,1,1)
        msgCreate(120,120,"","Stop trying to bum items off the shopkeeper.",7,1,oMessagePerson,0)
        newMessage.fadingTime=35
        bNotEnoughMoney=0
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
    depth=50
    bShopOpen=0
    global.gamePaused=false
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  global.recPeopleTalkNum+=1
  io_clear()
  resetKeyCodes()
  depth=-99
  bShopOpen=1
  global.gamePaused=true
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShopOpen=0 {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
else if bShopOpen=1
{
  var myX,myY;
  myX=view_xview[0]+158
  myY=view_yview[0]+72
  draw_sprite(sOtherShopWindowA,0,myX,myY)
  draw_set_color(textColor)
  draw_set_alpha(1)
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_center)
  draw_text(myX+82,myY+36,oPlayer1.currentMoney)
  draw_set_halign(fa_left)
  draw_text(myX+43,myY+64,"Heart Piece")
  draw_text(myX+43,myY+94,"Arrow Quiver")
  draw_text(myX+43,myY+124,"Heart Energy")
  draw_text(myX+43,myY+154,"Missile Pack")
  draw_text(myX+43,myY+184,"Skill Point")

  if heartCheck="0" {tHeartText="5000"} else if heartCheck="1" {tHeartText="Sold Out"}
  if arrowCheck="0" {tArrowText="2000"} else if arrowCheck="1" {tArrowText="Sold Out"}
  if energyCheck="0" {tEnergyText="2000"} else if energyCheck="1" {tEnergyText="Sold Out"}
  if missileCheck="0" {tMissileText="2000"} else if missileCheck="1" {tMissileText="Sold Out"}
  if apCheck="0" {tApText="1000"} else if apCheck="1" {tApText="Sold Out"}

  draw_text(myX+43,myY+74,tHeartText)
  draw_text(myX+43,myY+104,tArrowText)
  draw_text(myX+43,myY+134,tEnergyText)
  draw_text(myX+43,myY+164,tMissileText)
  draw_text(myX+43,myY+194,tApText)

  draw_rectangle(myX+10+cursorPulse,myY+64+cursorPulse+((cursorPos-1)*30),myX+35-cursorPulse,myY+89-cursorPulse+((cursorPos-1)*30),1)
}
