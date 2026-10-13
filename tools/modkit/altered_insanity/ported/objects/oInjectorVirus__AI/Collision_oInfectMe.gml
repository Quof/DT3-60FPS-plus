if life>0 and type=0
{
  playSound(global.snd_Infect,0,0.95,22050+random(2205))
  with other.myOwner.id
  {
    event_user(0)
  }
  var tEffect,tDir;
  tDir=0
  for(i=0;i<16;i+=1)
  {
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sVirusGel; tEffect.image_alpha=0.75
    tEffect.image_speed=0.15; tEffect.direction=tDir+irandom_range(-4,4); tEffect.friction=0.01
    tEffect.speed=random(1)+1; tEffect.fadeSpd=0.01
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    tDir+=360/16
  }
  instance_destroy()
}
