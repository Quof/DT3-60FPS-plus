#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
parent="projectile"
event_inherited()
weight=10000
size=1
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=58 or global.location=76 or global.location=107
{
  if collision_circle(x,y,4,oJerryParryWindow,1,1)
  {
    if bCanBeBlocked=1 and bParryOpp=1
    {
      oPlayer1.extraBulletCheck=3
      playSound(global.snd_MMBulletDeflect,0,1,10000)
      global.hudGame_WeaponEn[0]+=3
      if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
      awardAwesome(50)
      global.recParried+=1
      oPlayer1.blockForceTime=0
      instance_create(x,y,oJCBulletKill)
      global.stJGame_C[0]=5000
      var tEffect;
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-2,oEffect); tEffect.image_blend=c_blue; tEffect.image_speed=0.5
      tEffect.sprite_index=sAirDashWave; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-2
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=-oPlayer1.image_xscale
      if size=1
      {
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_destroy()
      }
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=58 or global.location=76 or global.location=107
{
  if bCanBeBlocked=1 and bParryOpp=1 {oPlayer1.extraBulletCheck=2}
}

event_inherited()
#define Collision_oPlayerShieldBubble
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if size=1
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  instance_destroy()
}
#define Collision_oJCGameFlameShield
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if size=1
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  with other {instance_destroy()}
  instance_destroy()
}
#define Collision_oJCBulletKill
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if size=1
{
  if global.location=76
  {
    global.hudGame_WeaponEn[0]+=2
    if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
  }

  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  instance_destroy()
}
#define Collision_oJMechShield
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if size=1
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  instance_destroy()
}
#define Collision_oJerryParryWindow
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if global.location=58 or global.location=76 or global.location=107
{
  if bCanBeBlocked=1 and bParryOpp=1
  {
    oPlayer1.extraBulletCheck=3
    playSound(global.snd_MMBulletDeflect,0,1,10000)
    global.hudGame_WeaponEn[0]+=3
    if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
    awardAwesome(50)
    global.recParried+=1
    oPlayer1.blockForceTime=0
    instance_create(x,y,oJCBulletKill)
    global.stJGame_C[0]=5000
    var tEffect;
    tEffect=instance_create(oPlayer1.x,oPlayer1.y-2,oEffect); tEffect.image_blend=c_blue; tEffect.image_speed=0.5
    tEffect.sprite_index=sAirDashWave; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-2
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=-oPlayer1.image_xscale
    if size=1
    {
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
}
