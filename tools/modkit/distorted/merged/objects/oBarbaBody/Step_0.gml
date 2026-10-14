if global.gamePaused=false
{
  x+=sin(oGame.time30/2.5+waveOffset)*gDeltaTime
  image_xscale=oBarba.image_xscale
  image_blend=oBarba.image_blend
  
  //spsp ns
  if shoot=1
  {
    var Fire;
    Fire=instance_create(x,y,oBarbaFire)
    //Fire.direction=player_sprite_center()
    Fire._direction=player_sprite_center() //60fps change: DT3+'s oBarbaFire moves by its own _direction
    Fire.bulletSpeed=5 //6.5
    shoot=0
}
}
