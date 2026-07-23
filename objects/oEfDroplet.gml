#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lifeTime=0
ySpd=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lifeTime+=1
y+=ySpd
if ySpd<5 {ySpd+=0.1}
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>10
{
  if checkScreenArea(x,y,32)=1
  {
    playSound(global.snd_Drip,0,0.95,22050+random(9000))
    var myParticles;
    for(i=0;i<6;i+=1)
    {
      myParticles=instance_create(x+random_range(-4,4),y+random_range(-4,4),oEffectGrav)
      myParticles.sprite_index=sBelmontWepEffect; myParticles.xSpd=random_range(-2,2); myParticles.ySpd=-1-random(1); myParticles.rotation=0
      myParticles.type=2; myParticles.fadeSpd=0.065; myParticles.grav=0.15; myParticles.newBlend=-1; myParticles.followID=-1
    }
  }
  instance_destroy()
}
#define Collision_oWaterVolume
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>10
{
  if checkScreenArea(x,y,32)=1
  {
    playSound(global.snd_Drip,0,0.95,22050+random(9000))
    var myParticles;
    for(i=0;i<6;i+=1)
    {
      myParticles=instance_create(x+random_range(-4,4),y+random_range(-4,4),oEffectGrav)
      myParticles.sprite_index=sBelmontWepEffect; myParticles.xSpd=random_range(-2,2); myParticles.ySpd=-1-random(1); myParticles.rotation=0
      myParticles.type=2; myParticles.fadeSpd=0.065; myParticles.grav=0.15; myParticles.newBlend=-1; myParticles.followID=-1
    }
  }
  instance_destroy()
}
