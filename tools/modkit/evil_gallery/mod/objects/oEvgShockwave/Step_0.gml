//Evil Boss Gallery: the shockwave runs on; gone where the floor under it ends, at a wall, or after 150 ticks
if global.gamePaused=false
{
  x+=spd*dir*gDeltaTime
  image_xscale=dir
  image_index+=0.3*gDeltaTime
  waveT+=1*gDeltaTime
  if !position_meeting(x,y+4,oSolid) or position_meeting(x+(10*dir),y-8,oSolid) or waveT>=150
  {
    var tEffect;
    tEffect=instance_create(x,y-4,oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.4
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5
    instance_destroy()
  }
}
