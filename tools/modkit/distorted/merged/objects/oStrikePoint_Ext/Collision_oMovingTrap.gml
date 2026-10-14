//if room!=rLowFacK and room!=rLowFacL {touchFrames+=1} //spsp ns
if room!=rLowFacK and room!=rLowFacL {touchFrames+=1*gDeltaTime} //spsp ns. 60fps change: per frame
if touchFrames>=7
{
  playSound(global.snd_EnemyDieMM,0,0.97,1)

  for(i=0;i<4;i+=1)
  {
    var tEffect;
    tEffect=instance_create(x+irandom_range(-4,4),y+irandom_range(-4,4),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sStrikeChainPole; tEffect.newBlend=-1;
    tEffect.direction=random(360); tEffect.speed=random(1)+2; tEffect.fadeSpd=0.05
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-3,3)
  }

  instance_destroy()
}
