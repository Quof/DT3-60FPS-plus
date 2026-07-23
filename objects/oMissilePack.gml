#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.5
indexCheck="0"
bCanPickUp=1
if global.difficulty=1 {bCanPickUp=0}
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.bNightmareMode=1 {sprite_index=sNightmareCheese}
indexCheck=string_char_at(global.missilePack,objectNum)

if indexCheck="1"
  instance_destroy()
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
if bCanPickUp=1
{
  playSound(global.snd_MetItemGet,0,1,1)
  if oIdentifier.bChaoActive=1 {showEmote(oIdentifier,0,-6,sEmHappy)}
  if global.hasAbilToken[4]=0
  {
    msgCreate(150,90,"","You found a Missile Expansion!#Missile capacity increased by 1!#Too bad you can't use it yet...",6,2,oMessagePerson,0)
    newMessage.fadingTime=90
  }
  else
  {
    msgCreate(170,100,"","You found a Missile Expansion!#Missile capacity increased by 1!",6,1,oMessagePerson,0)
    newMessage.fadingTime=70
  }

  awardAwesome(2500)
  global.hudSamus_Missiles[0]+=1
  global.hudSamus_Missiles[1]+=1

  var tNewString;
  tNewString=string_delete(global.missilePack,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.missilePack=tNewString
  instance_destroy()
}

if global.bNightmareMode=1
{
  showEmote(oIdentifier,0,-6,sEmThinking)
  playSound(global.snd_MetItemGet,0,0.98,17000)
  msgCreate(170,100,"","You found a piece of Nightmare Cheese! It does nothing.",6,1,oMessagePerson,0)
  newMessage.fadingTime=90
  awardAwesome(20000)
  var tNewString;
  tNewString=string_delete(global.missilePack,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.missilePack=tNewString
  instance_destroy()
}
