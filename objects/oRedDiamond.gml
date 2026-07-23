#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2
if global.location=59 {depth=110}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
awardAwesome(70)
playSound(global.snd_MMVictoryShine,0,0.7,1)
for(i=0;i<8;i+=1)
{
  tEffect=instance_create(x,y,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sMMshotgunIceEffect
  tEffect.image_speed=0.5; tEffect.speed=random(4); tEffect.direction=random(360)
  tEffect.image_angle=random(360); tEffect.friction=random(0.1)+0.1; tEffect.fadeSpd=0.045
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
}

if room=rBT_BrianA
{
  if instance_exists(oBTB_GetOnYoshi)
  {
    showEmote(oBTB_GetOnYoshi,0,-30,sEmLove)
  }
}

instance_destroy()
