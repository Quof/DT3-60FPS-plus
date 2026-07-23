#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
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
indexCheck=string_char_at(global.weaponLevels,objectNum)

if indexCheck="1"
  instance_destroy()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGame.time mod 3=0 //Flash sprite
  {
    if image_blend=c_white {image_blend=c_orange}
    else {image_blend=c_white}
  }
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
  if oIdentifier.bChaoActive=1 {showEmote(oIdentifier,0,-6,sEmHappy)}
  if image_index=0
  {
    playSound(global.snd_HeartPiece,0,1,1)
    global.stLink_Sword[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Master Sword] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=1
  {
    playSound(global.snd_HeartPiece,0,1,1)
    global.stLink_Arrow[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Bow & Arrow] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=2
  {
    playSound(global.snd_HeartPiece,0,1,1)
    global.stLink_Bomb[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Fuse Bomb] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=3
  {
    playSound(global.snd_CVItemGet,0,1,1)
    global.stBelmont_HairWhip[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Hair Whip] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=4
  {
    playSound(global.snd_CVItemGet,0,1,1)
    global.stBelmont_Dagger[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Dagger] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=5
  {
    playSound(global.snd_CVItemGet,0,1,1)
    global.stBelmont_Holywater[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Holy Water] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=6
  {
    playSound(global.snd_MMItemGet,0,1,1)
    global.stMega_Buster[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[X-Buster] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=7
  {
    playSound(global.snd_MMItemGet,0,1,1)
    global.stMega_ShotIce[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Shotgun Ice] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=8
  {
    playSound(global.snd_MMItemGet,0,1,1)
    global.stMega_Gravity[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Gravity Well] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=9
  {
    playSound(global.snd_MetItemGet,0,1,1)
    global.stSamus_Cannon[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Arm Cannon] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=10
  {
    playSound(global.snd_MetItemGet,0,1,1)
    global.stSamus_Missile[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Missile] level increased by 1!",6,1,oMessagePerson,0)
  }
  else if image_index=11
  {
    playSound(global.snd_MetItemGet,0,1,1)
    global.stSamus_Bomb[0]+=1
    msgCreate(170,100,"","You found a Weapon Upgrade!#[Morph Bomb] level increased by 1!",6,1,oMessagePerson,0)
  }
  newMessage.fadingTime=90
  awardAwesome(2500)

  var tNewString;
  tNewString=string_delete(global.weaponLevels,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.weaponLevels=tNewString
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
  tNewString=string_delete(global.weaponLevels,objectNum,1)
  tNewString=string_insert("1",tNewString,objectNum)
  global.weaponLevels=tNewString
  instance_destroy()
}
