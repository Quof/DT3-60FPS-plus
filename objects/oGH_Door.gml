#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bOpened=0
mySide=0
doorDist=40

helpTextInner=make_color_rgb(159,132,105)
helpTextOuter=make_color_rgb(28,16,3)
showKeyType=0
keyType=""
keySide=0

myDoor=instance_create(x-32,y,oGH_DummyDoor)

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("myType")
{
  keyType=myType
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Only mother can open the door
{
  if point_distance(x,0,oPlayer1.x,0)<doorDist and oPlayer1.y>y
  {
    showKeyType=2
    if x<oPlayer1.x {keySide=1}
    else {keySide=2}
  }

  if instance_exists(oClaireMother) //If Claire's mother is around
  {
    if point_distance(x,0,oClaireMother.x,0)<doorDist
    {
      sprite_index=sNull
      if mySide=0
      {
        if point_distance(x,0,oClaireMother.x,0)<=240 {playSound(global.snd_DoorOpen,0,0.9,1)}
        else {playSound(global.snd_DoorOpen,0,0.8,1)}
        if x<oClaireMother.x {mySide=1}
        else {mySide=2}
      }
      bOpened=1
    }
    else
    {
      sprite_index=sGateHDoorClosed
      if mySide>0
      {
        if point_distance(x,0,oClaireMother.x,0)<=240 {playSound(global.snd_DoorClose,0,0.9,1)}
        else {playSound(global.snd_DoorClose,0,0.8,1)}
        mySide=0
      }
      bOpened=0
    }
  }
}
else if type=1 //Player/Mother can open the door
{
  if instance_exists(oClaireMother) //If Claire's mother is around
  {
    if point_distance(x,0,oPlayer1.x,0)<doorDist and oPlayer1.y>y
    {
      sprite_index=sNull
      if mySide=0
      {
        playSound(global.snd_DoorOpen,0,0.9,1)
        if x<oPlayer1.x {mySide=1}
        else {mySide=2}
      }
      bOpened=1
    }
    else if point_distance(x,0,oClaireMother.x,0)<doorDist
    {
      sprite_index=sNull
      if mySide=0
      {
        if point_distance(x,0,oClaireMother.x,0)<=240 {playSound(global.snd_DoorOpen,0,0.9,1)}
        else {playSound(global.snd_DoorOpen,0,0.8,1)}
        if x<oClaireMother.x {mySide=1}
        else {mySide=2}
      }
      bOpened=1
    }
    else
    {
      sprite_index=sGateHDoorClosed
      if mySide>0
      {
        if point_distance(x,0,oClaireMother.x,0)<=240 {playSound(global.snd_DoorClose,0,0.9,1)}
        else {playSound(global.snd_DoorClose,0,0.8,1)}
        mySide=0
      }
      bOpened=0
    }
  }
  else
  {
    if point_distance(x,0,oPlayer1.x,0)<doorDist and oPlayer1.y>y
    {
      sprite_index=sNull
      if mySide=0
      {
        playSound(global.snd_DoorOpen,0,0.9,1)
        if x<oPlayer1.x {mySide=1}
        else {mySide=2}
      }
      bOpened=1
    }
    else
    {
      sprite_index=sGateHDoorClosed
      if mySide>0
      {
        playSound(global.snd_DoorClose,0,0.9,1)
        mySide=0
      }
      bOpened=0
    }
  }
}

//Control dummy door for room visibility
if sprite_index=sGateHDoorClosed
{
  myDoor.sprite_index=sNull
  myDoor.y=y+128
}
else
{
  myDoor.sprite_index=sGateHDoorOpen
  myDoor.y=y
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bOpened=0
{
  image_xscale=1
  draw_sprite(sGateHDoorClosed,0,x,y)
}
else if bOpened=1
{
  if mySide=1 {image_xscale=-1}
  else {image_xscale=1}
  draw_sprite_ext(sGateHDoorOpen,0,x,y,image_xscale,1,0,c_white,1)
}

if showKeyType>0
{
  showKeyType-=1
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_middle)
  var tCheckKeyX;
  if keySide=1 {tCheckKeyX=48}
  else {tCheckKeyX=-48}
  textDropShadow(keyType,x+tCheckKeyX,317,helpTextInner,helpTextOuter,4)
}
