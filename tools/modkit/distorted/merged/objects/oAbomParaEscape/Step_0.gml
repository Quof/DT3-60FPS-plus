if global.gamePaused=false
{
  var tA; //speed changes per tick, decided like at 30fps (scrTickAcc)
  //if xSpd<8 and room!=rMain_76 {xSpd+=0.1} //spsp ns new condition
  tA=0; if xSpd<8 and room!=rMain_76 {tA=0.1} //60fps change: per tick (scrTickAcc)
  xSpd=scrTickAcc(xSpd,tA,0)
  //if ySpd>-3 {ySpd-=0.2}
  //if ySpd<5 and room!=rMain_76 {ySpd+=0.2}
  tA=0; if ySpd<5 and room!=rMain_76 {tA=0.2} //60fps change: per tick (scrTickAcc)
  ySpd=scrTickAcc(ySpd,tA,1)

  x+=(xSpd+scrTickAccB(0))*gDeltaTime
  y+=(ySpd+scrTickAccB(1))*gDeltaTime

  if x>=room_width+128 {instance_destroy()}

  var tEffect,tScale;
  if gDeltaDoTicks for(i=0;i<4;i+=1)
  {
    tScale=random(0.25)
    tEffect=instance_create(x+random_range(-32,32),y+random_range(-32,32),oEffect)
    tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_xscale=0.5+tScale; tEffect.image_yscale=0.5+tScale; tEffect.image_angle=random(360)
  }
}
