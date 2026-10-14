if global.gamePaused=false
{
  event_inherited()
  if bActive=true and life>0
  {
    image_angle+=spinSpd*gDeltaTime
    _speed=moveSpd
  }
  else if life<=0
  {
    if type=1 or type=2 //Break into smaller asteroids
    {
      playSound(global.snd_BombExplode,0,0.98,43000)
      var tAst;
      for(i=0;i<4;i+=1)
      {
        tAst=instance_create(x,y,oBreakableAsteroid); tAst.type=type+1; tAst._direction=30+(i*90)
        instance_destroy()
      }
    }
    else //Is already a small asteroid, so get it the fuck out
    {
      playSound(global.snd_BombExplode,0,1,15000)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sEfAstExplode; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else {_speed=0}


correctSpeedDirection(self)
