#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
if room=rLink2_PalaceF_3
{
  if global.mySegmentCheck[0]=1 {image_index=1}
}
else if room=rLink2_PalaceF_5
{
  if global.mySegmentCheck[1]=1 {image_index=1}
}
else if room=rLink2_PalaceF_7
{
  if global.mySegmentCheck[2]=1 {image_index=1}
}

hitTime=0

gameProgCheck=string_char_at(global.gameGate2Prog,2)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if hitTime>0 {hitTime-=1}
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="NORMAL" and other.bCanHitSwitch=1 and other.weaponTag<100 and hitTime=0
{
  if gameProgCheck="2" //Reset Dylan Puzzle
  {
    msgCreate(0,0,"Dylan, the Poe","YOU FAILED MY TEST BY FLIPPING THE PALACE!!#Come back to me to start again.#Remember, you have to get from where I am to a room with a powerful weapon, I left some skeleton guards there.",6,3,oMessagePerson,0)
    newMessage.fadingTime=200
    var tNewString;
    tNewString=string_delete(global.gameGate2Prog,2,1)
    tNewString=string_insert("1",tNewString,2)
    global.gameGate2Prog=tNewString
    gameProgCheck="1"
  }

  for(i=0;i<128;i+=1)
  {
    var tEffect;
    tEffect=instance_create(random(room_width),random(room_height),oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_alpha=0.5+random(0.5)
    tEffect.image_speed=0.15+random(0.25); tEffect.ySpd=-1-random(2)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0
  }

  msgCreate(170,256,"","Something happened in the next room.",6,1,oMessagePerson,0)
  newMessage.fadingTime=90

  playSound(global.snd_SwitchHit,0,0.9,1)
  playSound(global.snd_HardHit1,0,1,12500)
  var tMyShake;
  tMyShake=instance_create(0,0,oViewShaker)
  tMyShake.shakeAmt=2; tMyShake.shakeTime=20
  if room=rLink2_PalaceF_3
  {
    if global.mySegmentCheck[0]=0
    {
      image_index=1
      oExit.newMapX=1392
      oExit.newMapY=224
      oExit.toRoom=rLink2_PalaceF_2b
      global.mySegmentCheck[0]=1
    }
    else
    {
      image_index=0
      oExit.newMapX=1392
      oExit.newMapY=544
      oExit.toRoom=rLink2_PalaceF_2a
      global.mySegmentCheck[0]=0
    }
  }
  else if room=rLink2_PalaceF_5
  {
    if global.mySegmentCheck[1]=0
    {
      image_index=1
      oExit.newMapX=1392
      oExit.newMapY=640
      oExit.toRoom=rLink2_PalaceF_4b
      global.mySegmentCheck[1]=1
    }
    else
    {
      image_index=0
      oExit.newMapX=1392
      oExit.newMapY=128
      oExit.toRoom=rLink2_PalaceF_4a
      global.mySegmentCheck[1]=0
    }
  }
  else if room=rLink2_PalaceF_7
  {
    if global.mySegmentCheck[2]=0
    {
      image_index=1
      oExit.newMapX=48
      oExit.newMapY=256
      oExit.toRoom=rLink2_PalaceF_6b
      global.mySegmentCheck[2]=1
    }
    else
    {
      image_index=0
      oExit.newMapX=48
      oExit.newMapY=512
      oExit.toRoom=rLink2_PalaceF_6a
      global.mySegmentCheck[2]=0
    }
  }
  hitTime=20
}
