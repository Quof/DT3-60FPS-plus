#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
pulsate=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=29 or global.location=104 //Gate 4
{
  sprite_index=sMMBreakCapsule
  image_speed=0.25
}
else if global.location=40 //Vault
{
  sprite_index=sVaultBreakPot
  image_alpha=0.8
}
else if global.location>=79 and global.location<=84 //Highlands
{
  sprite_index=sHighlandsPot
}
else if global.location=99 //CHAOS Warship
{
  sprite_index=sWS_BreakCrate
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sVaultBreakPot
{
  pulsate+=1
  if pulsate>=1 and pulsate<=30 {image_alpha-=0.015}
  else if pulsate>=31 and pulsate<=60
  {
    image_alpha+=0.015
    if pulsate=60 {pulsate=0}
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recObjectsBroken+=1
awardAwesome(10)
if sprite_index=sZeldaBreakPot or sprite_index=sHighlandsPot
{
  playSound(global.snd_PotShatter,0,1,1)
  for(i=0;i<5;i+=1)
  {
    tEffect=instance_create(x+1+random(sprite_width-2),y+1+random(sprite_height-2),oEffect)
    tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
}
else if sprite_index=sMMBreakCapsule or sprite_index=sCopier or sprite_index=sWS_BreakCrate
{
  playSound(global.snd_BombExplode,0,0.94,1)
  tEffect=instance_create(bbox_left+(sprite_width/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sMMExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
if sprite_index=sVaultBreakPot
{
  playSound(global.snd_PotShatter,0,0.95,1)
  for(i=0;i<6;i+=1)
  {
    tEffect=instance_create(x+random(16),y+random(16),oEffectB)
    tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
    tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  }
}
/*if global.bossTrack=0
{
  if oPlayer1.life=oPlayer1.maxLife //Drop money if player is at full health
  {
    var tIndexCheck,tWalNum;
    moneyWorth=10
    tWalNum=0
    for(i=0;i<20;i+=1)
    {
      tIndexCheck=string_char_at(global.walletBoost,i+1); if tIndexCheck="1" {tWalNum+=1}
    }
    moneyWorth*=(1+tWalNum*0.1)
    tMoneyDrop=instance_create(x,y,oMoneyPickup)
    tMoneyDrop.moneyType=1; tMoneyDrop.moneyWorth=moneyWorth
  }
  else //Only hearts during boss fights
  {
    tHeartDrop=instance_create(bbox_left+(sprite_width/2),bbox_top+(sprite_height/2),oHealthPickup)
  }
  tHeartDrop=instance_create(bbox_left+(sprite_width/2),bbox_top+(sprite_height/2),oHealthPickup)
}
else
{
  tHeartDrop=instance_create(bbox_left+(sprite_width/2),bbox_top+(sprite_height/2),oHealthPickup)
}*/
tHeartDrop=instance_create(bbox_left+(sprite_width/2),bbox_top+(sprite_height/2),oHealthPickup)
instance_destroy()
