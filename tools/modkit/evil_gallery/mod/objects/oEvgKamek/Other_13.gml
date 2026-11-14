//Evil Boss Gallery: Evil Kamek's evil moves (his Step runs this in his own step's place while evgMove isn't 0; stage
//0 is a move's first frame)
evgT+=1*gDeltaTime
if evgMove=1 //---------- DECOYS ----------
{
  if evgStage=0
  {
    sprite_index=sKamekHandsUp
    playSound(global.snd_DemonLaugh,0,0.8,16000)
    //(at the two thirds of the arena furthest from him)
    var tP,k,tD,tNear;
    tP[0]=176; tP[1]=272; tP[2]=368
    tNear=0
    for(k=1;k<3;k+=1) {if abs(tP[k]-x)<abs(tP[tNear]-x) {tNear=k}}
    for(k=0;k<3;k+=1)
    {
      if k!=tNear
      {
        tD=instance_create(tP[k],yGround,oEvgKamDecoy)
        tD.atkPower=atkPower
      }
    }
    evgStage=1
    evgT=0
  }
  else if evgT>=30
  {
    sprite_index=sKamekIdle
    evgMove=0
  }
}
else if evgMove=2 //---------- MEGA ORB ----------
{
  if evgStage=0
  {
    sprite_index=sKamekHandsUp
    var tO;
    tO=instance_create(x+(12*image_xscale),y-34,oEvgKamMegaOrb)
    tO.owner=id
    tO.atkPower=atkPower
    tO.rollSpd=2.6
    if life<=3 {tO.rollSpd=3.2}
    playSound(global.snd_Magic,0,0.9,16000)
    evgStage=1
    evgT=0
  }
  else if evgT>=38
  {
    sprite_index=sKamekIdle
    evgMove=0
  }
}
else if evgMove=3 //---------- SWOOP ----------
{
  if evgStage=0 //(up and over to the side away from the player)
  {
    sprite_index=sKamekHandsUp
    playSound(global.snd_OrbThrow,0,0.9,14000)
    swX=xCenter-roomSpan+24
    if oPlayer1.x<xCenter {swX=xCenter+roomSpan-24}
    swY=yGround-138
    evgStage=1
    evgT=0
  }
  else if evgStage=1
  {
    x+=median(-6*gDeltaTime,swX-x,6*gDeltaTime)
    y+=median(-6*gDeltaTime,swY-y,6*gDeltaTime)
    if gDeltaDoTicks
    {
      var tEffect;
      tEffect=instance_create(x-8+random(16),y-random(30),oEffect)
      tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.25; tEffect.newBlend=-1
      tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0.5
    }
    if (x=swX and y=swY) or evgT>=60
    {
      x=swX; y=swY
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
      //(the line: at where the player is now, never flatter than 20 degrees below level, so it always comes down)
      swDir=point_direction(x,y-22,oPlayer1.x,oPlayer1.y-22)
      if image_xscale=1
      {
        if swDir<180 {swDir=340}
        swDir=median(270,swDir,340)
      }
      else
      {
        if swDir<180 {swDir=200}
        swDir=median(200,swDir,270)
      }
      playSound(global.snd_DashWarn,0,1,1)
      evgStage=2
      evgT=0
    }
  }
  else if evgStage=2 //(the line shows, 20 ticks)
  {
    if evgT>=20
    {
      playSound(global.snd_OrbThrow,0,1,22050)
      evgStage=3
      evgT=0
    }
  }
  else if evgStage=3 //(down it)
  {
    x+=lengthdir_x(swSpd,swDir)*gDeltaTime
    y+=lengthdir_y(swSpd,swDir)*gDeltaTime
    if gDeltaDoTicks
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index
      tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
      tAfterI.imageFade=0.15; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
      tAfterI.depth=depth+0.1
    }
    if y>=yGround or x<=xCenter-roomSpan+8 or x>=xCenter+roomSpan-8 or evgT>=60
    {
      x=median(xCenter-roomSpan+16,x,xCenter+roomSpan-16)
      y=yGround
      playSound(global.snd_HardHit2,0,0.9,1)
      var tEffect;
      tEffect=instance_create(x,y-4,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.4
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5
      sprite_index=sKamekIdle
      evgStage=4
      evgT=0
    }
  }
  else if evgT>=15 //(a moment to get up)
  {
    if x<xCenter {image_xscale=1}
    else {image_xscale=-1}
    evgMove=0
  }
}
else {evgMove=0}
