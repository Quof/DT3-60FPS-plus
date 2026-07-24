#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.25
indexCheck="0"
bCanPickUp=1
if global.difficulty=1 {bCanPickUp=0}
textColorMain=make_color_rgb(240,240,240)
textColorShadow=make_color_rgb(0,120,72)
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.bNightmareMode=1 {sprite_index=sNightmareCheese}
indexCheck=string_char_at(global.apBoost,objectNum)

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
  playSound(global.snd_SkillGet,0,1,1)
  if oIdentifier.bChaoActive=1 {showEmote(oIdentifier,0,-6,sEmHappy)}
  msgCreate(0,0,"","Oh snap!#You earned 1 Skill Point!",6,1,oMessagePerson,1)
  newMessage.fadingTime=80/gDeltaTime

  awardAwesome(2500)
  global.pAP+=1

  var tNewString;
  tNewString=string_delete(global.apBoost,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.apBoost=tNewString
  instance_destroy()
}

if global.bNightmareMode=1
{
  showEmote(oIdentifier,0,-6,sEmThinking)
  playSound(global.snd_MetItemGet,0,0.98,17000)
  msgCreate(170,100,"","You found a piece of Nightmare Cheese! It does nothing.",6,1,oMessagePerson,0)
  newMessage.fadingTime=90/gDeltaTime
  awardAwesome(20000)
  var tNewString;
  tNewString=string_delete(global.apBoost,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.apBoost=tNewString
  instance_destroy()
}
