#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true

//Enemy base statistics
eName="Molten Rock"
eLevel=40
maxLife=350
life=maxLife
if room=rWarshipZ_E3 {atkPower=12}
else {atkPower=10}
resType[0]=2
resType[1]=1
resType[3]=2
resType[5]=3
bIsBoss=true
bNoBonus=true
dieEffect=0
dieSound=0
bossProgress=0
activateBoss=0

var tEffect;
for(i=0;i<8;i+=1)
{
  tEffect=instance_create(x+random_range(-12,12),y-random(46),oEffect)
  tEffect.sprite_index=sMMSmokeCloud; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.image_speed=0.5
  tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-random(1); tEffect.image_blend=make_color_rgb(255,200,200)
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<8;i+=1)
{
  tEffect=instance_create(x+random_range(-12,12),y+random(-36),oEffectGrav)
  tEffect.type=2; tEffect.sprite_index=sWarmasterB_MR_Particle; tEffect.newBlend=-1; tEffect.depth=24
  tEffect.fadeSpd=0.06; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
  tEffect.xSpd=random_range(-1,1); tEffect.ySpd=-1-random(1); tEffect.followID=-1; tEffect.rotation=0; tEffect.grav=0.2
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and life>0
  {

  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  playSound(global.snd_BoxBreak,0,1,1)
  instance_destroy()
}
