if hasBomb=1
{
    if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.92,20000)}
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=3.5; tExpLight.image_yscale=3.5
      instance_create(x+lengthdir_x(15,image_angle),y+lengthdir_y(15,image_angle),oLinkBExplosion)
}
