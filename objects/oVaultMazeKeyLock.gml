#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck="0"
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 {sprite_index=sVaultMazeLock}
if objectNum=1 {image_blend=c_red}
else if objectNum=2 {image_blend=c_blue}
else if objectNum=3 {image_blend=c_green}
else if objectNum=4 {image_blend=c_orange}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
indexCheck=string_char_at(global.gameVaultProg,objectNum)
if type=0 //Key
{
  if indexCheck="0" //Player does not have key
  {
    image_alpha=1
  }
  else if indexCheck="1" //Player has key
  {
    image_alpha=0.35
  }
  else if indexCheck="9" //Sequence complete
  {
    instance_destroy()
  }
}
else if type=1 //Lock
{
  if indexCheck="8" //Key brought to lock (Unlock sequence)
  {
    var tNewString;
    tNewString=string_delete(global.gameVaultProg,objectNum,1)
    tNewString=string_insert("9",tNewString,objectNum)
    global.gameVaultProg=tNewString
  }
  else if indexCheck="9" //Sequence complete
  {
    instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Key
{
  if indexCheck="0"
  {
    var tKeyChk;
    tKeyChk=0
    for(i=0;i<4;i+=1)
    {
      if oEvCh10VaultRoomMap.vaultMaze[i]="1" {tKeyChk=1}
    }
    if tKeyChk=0
    {
      playSound(global.snd_SkillGet,0,0.95,29000)
      global.tempAction[2]=1800
      var tNewString;
      tNewString=string_delete(global.gameVaultProg,objectNum,1)
      tNewString=string_insert("1",tNewString,objectNum)
      global.gameVaultProg=tNewString
    }
  }
}
else if type=1 //Lock
{
  if indexCheck="1"
  {
    playSound(global.snd_DoorUnlock,0,1,1)
    global.tempAction[2]=0
    for(i=0;i<20;i+=1)
    {
      myDir=choose(-1,1)
      tEffect=instance_create(x+random(24),y+random(24),oEffect)
      tEffect.sprite_index=sBlackCrowFly; tEffect.image_speed=0.25+random(0.1); tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.image_xscale=myDir; tEffect.newBlend=-1; tEffect.decay=180; tEffect.xSpd=random(4*myDir); tEffect.ySpd=-2-random(3)
    }
    var tNewString;
    tNewString=string_delete(global.gameVaultProg,objectNum,1)
    tNewString=string_insert("8",tNewString,objectNum)
    global.gameVaultProg=tNewString
  }
}
