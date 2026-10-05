#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_yscale=4

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
atkPower=12

phase=0
atkProg=0
atkTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  if atkProg=0 //Warn player
  {
    var tEffect;
    if gDeltaDoTicks //60fps change (added): one warning particle per 30fps tick (was every frame, 4x at 120fps)
    {
    tEffect=instance_create(x+random_range(-6,6),256-random(2),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sDefParticle; tEffect.newBlend=-1; tEffect.image_alpha=0.75
    tEffect.direction=random_range(70,110); tEffect.speed=random(1)+2; tEffect.friction=random(0.02)+0.02
    tEffect.fadeSpd=0.03; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    } //60fps change (added)
    if atkTime>=40
    {
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=1 //Slight wait
  {
    if atkTime>=10
    {
      bCanDealDamage=true
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=2 //Destroy
  {
    if atkTime>=65 {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg=2
{
  //phase+=0.04
  phase+=0.04*gDeltaTime //60fps change: Draw runs every frame, so the lightning wave moved 2x/4x as fast
  for(i=0;i<4;i+=1)
  {
    draw_sprite_wave(sprite_index,image_index,x,y+(i*64),1,4,2,phase)
  }
}
