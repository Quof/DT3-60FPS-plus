#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="NORMAL" and other.bCanHitSwitch=1 and other.weaponTag<100
{
  awardAwesome(500)
  if type=1 //Gate 2 - Water Temple
  {
    playSound(global.snd_PotShatter,0,0.9,1)
    var tGateCheck;
    tGateCheck=string_char_at(global.gameGate2Prog,key)
    if tGateCheck="6"
    {
      var tNewString;
      tNewString=string_delete(global.gameGate2Prog,key,1)
      tNewString=string_insert("7",tNewString,key)
      global.gameGate2Prog=tNewString
    }
  }
  else if type=2 //Gate 6 - Castle of Doom
  {
    playSound(global.snd_PotShatter,0,0.9,1)
    var tNewString;
    tNewString=string_delete(global.gameGate6Prog,key,1)
    tNewString=string_insert("1",tNewString,key)
    global.gameGate6Prog=tNewString
  }
  tFlash=instance_create(0,0,oScreenFlash)
  tFlash.fadeSpeed=0.2

  for(i=0;i<32;i+=1)
  {
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMshotgunIceEffect
    tEffect.image_speed=0.5; tEffect.speed=random(4); tEffect.direction=random(360)
    tEffect.image_angle=random(360); tEffect.friction=random(0.1)+0.1; tEffect.fadeSpd=0.045
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  }
  instance_destroy()
}
