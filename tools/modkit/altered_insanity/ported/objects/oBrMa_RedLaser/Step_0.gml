if global.gamePaused=false
{
  x=oBrainMachine.x
  //image_blend=make_color_rgb(150+random(50),150+random(50),150+random(50))
  if gDeltaDoTicks {image_blend=make_color_rgb(150+random(50),150+random(50),150+random(50))} //60fps change: new random tint once per 30fps tick, not every frame
}
