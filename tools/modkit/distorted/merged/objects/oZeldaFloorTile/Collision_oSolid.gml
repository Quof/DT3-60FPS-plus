if atkProg=2 and atkTime>5 and (room!=rDCS_G or other.y>115) //spsp ns
{
  playSound(global.snd_MarioBlockBreak,0,1,1)
  tEffect=instance_create(x+4,y-4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=1; tEffect.ySpd=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  tEffect=instance_create(x-4,y-4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=-1; tEffect.ySpd=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  tEffect=instance_create(x-4,y+4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=-1; tEffect.ySpd=1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  tEffect=instance_create(x+4,y+4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=1; tEffect.ySpd=1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  instance_destroy()
}
