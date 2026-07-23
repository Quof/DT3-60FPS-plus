#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hitWaterPlat=0
direction=90
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  if bulletSpeed>6
    bulletSpeed-=0.9

  if hitWaterPlat>0
  {
    idToLift.yVel=-bulletSpeed
    tEffect=instance_create(x-20+random(40),y-20,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1
    tEffect.image_alpha=0.8; tEffect.image_speed=0; tEffect.image_angle=90
    tEffect.image_blend=c_teal; tEffect.direction=270; tEffect.speed=random(0.4)+0.1
    tEffect.AccelY=0.1; tEffect.fadeSpd=0.0075
    tEffect.AccelX=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0

    hitWaterPlat+=1
    if hitWaterPlat=12
      instance_destroy()
  }
  else
  {
    if oGame.time mod 2=0
    {
      tEffect=instance_create(x-8+random(16),y+random(8),oEffectB)
      tEffect.type=1; tEffect.sprite_index=sSamusSMissileEffect; tEffect.depth=26
      tEffect.image_alpha=0.75; tEffect.image_speed=0.3; tEffect.image_blend=c_teal
      tEffect.direction=random_range(260,280); tEffect.speed=random(0.75)+0.75
      tEffect.friction=random(0.005)+0.005
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
  }
}
else
  speed=0
#define Collision_oWaterFloatPlatform
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hitWaterPlat=0
{
  playSound(global.snd_Splash,0,1,42000)
  visible=0
  bulletSpeed=16
  hitWaterPlat=1

  tEffect=instance_create(other.x+24,other.y+12,oEffect)
  tEffect.sprite_index=sGroundDust; tEffect.image_speed=0.3+random(0.2)
  tEffect.image_xscale=1.5; tEffect.image_yscale=-1.5; tEffect.image_blend=c_teal
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  idToLift=other.id
}
