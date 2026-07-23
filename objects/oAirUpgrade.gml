#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
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
indexCheck=string_char_at(global.airUpgrade,objectNum)

if indexCheck="1"
  instance_destroy()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oGame.time mod 3=0
{
  if image_blend=c_white
    image_blend=c_orange
  else
    image_blend=c_white
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
if bCanPickUp=1
{
  playSound(global.snd_HeartPiece,0,1,1)
  if oIdentifier.bChaoActive=1 {showEmote(oIdentifier,0,-6,sEmHappy)}
  msgCreate(140,80,"","You found an Air Upgrade!#Your air capacity has been increased by 1 second!",6,2,oMessagePerson,0)
  newMessage.fadingTime=80

  awardAwesome(2500)
  global.pBreathMax+=30
  global.pCurrBreath+=30

  var tNewString;
  tNewString=string_delete(global.airUpgrade,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.airUpgrade=tNewString
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
  tNewString=string_delete(global.airUpgrade,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.airUpgrade=tNewString
  instance_destroy()
}
