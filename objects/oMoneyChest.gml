#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
indexCheck="0"
specialChest=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck=string_char_at(global.chestMoney,objectNum)
if indexCheck="1"
{
  newChestDummy=instance_create(x,y,oChestOpenDummy)
  newChestDummy.image_yscale=image_yscale
  instance_destroy()
}

if variable_local_exists("newItem")
  specialChest=newItem
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if specialChest=1
{
  tEffect=instance_create(x-9+random(18),y-random(6),oEffect)
  if random(4)>2 {tEffect.sprite_index=sMMshotgunIceEffect}
  else {tEffect.sprite_index=sBelmontWepEffect}
  tEffect.image_speed=0.2+random(0.1); tEffect.ySpd=-1-random(2); tEffect.depth=49
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Pickup script.
objectNum relates to which global flag to write to.
0 = has not been obtained.
1 = has been obtained.
*/
if global.difficulty>=2
{
  if oKeyCodes.kCodePressed[3]=1 and indexCheck="0" and global.gamePaused=false
  {
    if image_yscale>=1
    {
      playSound(global.snd_ChestOpen,0,1,1)
      if specialChest=0 //Money
      {
        msgCreate(170,100,"","You found " +string(objectAmt) +string(" Internetz!"),6,1,oMessagePerson,1)
        newMessage.fadingTime=70

        global.recInterEarnTotal+=objectAmt
        global.recInterEarnChest+=objectAmt
        oPlayer1.currentMoney+=objectAmt
        global.pMoney+=objectAmt
        if oPlayer1.currentMoney>global.pMoneyMax {oPlayer1.currentMoney=global.pMoneyMax}
        if global.pMoney>global.pMoneyMax {global.pMoney=global.pMoneyMax}
      }
      else if specialChest=1
      {
        var tItemName;
        tItemName=""
        if objectAmt=3 {tItemName="Power Glove"}
        else if objectAmt=10 {tItemName="Cursed Helm"}
        else if objectAmt=11 {tItemName="Cursed Ring"}
        else if objectAmt=12 {tItemName="Cursed Pendant"}
        else if objectAmt=18 {tItemName="Plot Armor"}

        msgCreate(170,100,"","You found the " +string(tItemName) +string("!"),6,1,oMessagePerson,1)
        newMessage.fadingTime=70

        var tNewString;
        tNewString=string_delete(global.equipItems,objectAmt,1)
        tNewString=string_insert("1",tNewString,objectAmt)
        global.equipItems=tNewString
      }
      awardAwesome(3000)
      var tNewString;
      tNewString=string_delete(global.chestMoney,objectNum,1)
      tNewString=string_insert("1",tNewString,objectNum)
      global.chestMoney=tNewString
      indexCheck="1"
      image_index=1

      //----- SPECIAL MAP SCENARIOS -----
      if room=rMain_25ExtA {(210894).spinning=1}
    }
    else if image_yscale=-1 //Forest Temple upside-down chest
    {
      msgCreate(170,100,"","You can't open a chest that is upside-down... which is weird.",6,1,oMessagePerson,1)
      newMessage.fadingTime=80
    }
  }
}

if global.bNightmareMode=1
{
  if oKeyCodes.kCodePressed[3]=1 and indexCheck="0" and global.gamePaused=false
  {
    if image_yscale>=1
    {
      playSound(global.snd_ChestOpen,0,1,1)
      if specialChest=0 //Money
      {
        msgCreate(170,100,"","You found a piece of Nightmare Cheese inside!",6,1,oMessagePerson,1)
        newMessage.fadingTime=70
      }
      else if specialChest=1
      {
        var tItemName;
        tItemName=""
        if objectAmt=3 {tItemName="Power Glove"}
        else if objectAmt=10 {tItemName="Cursed Helm"}
        else if objectAmt=11 {tItemName="Cursed Ring"}
        else if objectAmt=12 {tItemName="Cursed Pendant"}
        else if objectAmt=18 {tItemName="Plot Armor"}

        msgCreate(170,100,"","You found the " +string(tItemName) +string("!"),6,1,oMessagePerson,1)
        newMessage.fadingTime=70

        var tNewString;
        tNewString=string_delete(global.equipItems,objectAmt,1)
        tNewString=string_insert("1",tNewString,objectAmt)
        global.equipItems=tNewString
      }
      awardAwesome(3000)
      var tNewString;
      tNewString=string_delete(global.chestMoney,objectNum,1)
      tNewString=string_insert("1",tNewString,objectNum)
      global.chestMoney=tNewString
      indexCheck="1"
      image_index=1

      //----- SPECIAL MAP SCENARIOS -----
      if room=rMain_25ExtA {(210894).spinning=1}
    }
    else if image_yscale=-1 //Forest Temple upside-down chest
    {
      msgCreate(170,100,"","You can't open a chest that is upside-down... which is weird.",6,1,oMessagePerson,1)
      newMessage.fadingTime=80
    }
  }
}
