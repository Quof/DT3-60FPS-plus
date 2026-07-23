#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck="0"
alarm[0]=1
writingAlpha=1
wA_Phase=0
writingBlend=c_white
bCanUse=1

if global.gameProgress>=4930 and global.gameProgress<=4960
{
  image_blend=c_purple
  bCanUse=0
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if area=0 {indexCheck=string_char_at(global.warpMain,gateNum)}
else if area=1 {indexCheck=string_char_at(global.warpGate1,gateNum)}
else if area=2 {indexCheck=string_char_at(global.warpGate2,gateNum)}
else if area=3 {indexCheck=string_char_at(global.warpGate3,gateNum)}
else if area=4 {indexCheck=string_char_at(global.warpGate4,gateNum)}
else if area=5 {indexCheck=string_char_at(global.warpGate5,gateNum)}
else if area=6 {indexCheck=string_char_at(global.warpGate6,gateNum)}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if indexCheck="1"
{
  wA_Phase+=1
  if wA_Phase>=1 and wA_Phase<=60
    writingAlpha-=0.01
  else if wA_Phase>=61 and wA_Phase<=120
  {
    writingAlpha+=0.01
    if wA_Phase=120
      wA_Phase=0
  }

  writingBlend=c_white
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanUse=1
{
  if indexCheck="0"
  {
    playSound(global.snd_NewGateTransport,0,1,44100)
    awardAwesome(500)
    var tNewString;
    if area=0
    {
      tNewString=string_delete(global.warpMain,gateNum,1)
      tNewString=string_insert("1",tNewString,gateNum)
      global.warpMain=tNewString
    }
    else if area=1
    {
      tNewString=string_delete(global.warpGate1,gateNum,1)
      tNewString=string_insert("1",tNewString,gateNum)
      global.warpGate1=tNewString
    }
    else if area=2
    {
      tNewString=string_delete(global.warpGate2,gateNum,1)
      tNewString=string_insert("1",tNewString,gateNum)
      global.warpGate2=tNewString
    }
    else if area=3
    {
      tNewString=string_delete(global.warpGate3,gateNum,1)
      tNewString=string_insert("1",tNewString,gateNum)
      global.warpGate3=tNewString
    }
    else if area=4
    {
      tNewString=string_delete(global.warpGate4,gateNum,1)
      tNewString=string_insert("1",tNewString,gateNum)
      global.warpGate4=tNewString
    }
    else if area=5
    {
      tNewString=string_delete(global.warpGate5,gateNum,1)
      tNewString=string_insert("1",tNewString,gateNum)
      global.warpGate5=tNewString
    }
    else if area=6
    {
      tNewString=string_delete(global.warpGate6,gateNum,1)
      tNewString=string_insert("1",tNewString,gateNum)
      global.warpGate6=tNewString
    }
    var tEffect;
    for(i=0;i<24;i+=1)
    {
      tEffect=instance_create(x,y-42,oKillEffect)
      tEffect.speed=5
      tEffect.direction=random(360)
      tEffect.friction=0.1+random(0.3)
      tEffect.fadeAlpha=0.04+random(0.02)
      tEffect.imageRot=random_range(-5,5)
    }
    indexCheck="1"
  }
  if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
  {
    resetKeyCodes()
    global.gamePaused=true
    var tNewTele;
    tNewTele=instance_create(0,0,oTeleportMenu)
    tNewTele.area=area
    tNewTele.gateNum=gateNum
    tNewTele.telePos=gateNum
  }
}
else
{
  if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
  {
    resetKeyCodes()
    msgCreate(0,0,"","Something has deactivated the Teleporting Stones.",7,1,oMessagePerson,0)
    newMessage.fadingTime=90
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if indexCheck="1"
{
  draw_sprite_ext(sWarpSWriting,image_index,x,y-39,image_xscale,image_yscale,image_angle,writingBlend,writingAlpha)
}
