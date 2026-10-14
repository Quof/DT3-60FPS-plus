if global.gamePaused=false
{
  //Size control
  var tMySize;
  tMySize=1
  for(i=0;i<23;i+=1)
  {
    if !collision_line(x,y,x+lengthdir_x(8*i,image_angle),y+lengthdir_y(8*i,image_angle),oSolid,1,1)
    {
      tMySize+=8
    }
    else
    {
      if oGame.time mod (2/gDeltaTime)=0 and checkScreenArea(x,y,224)=1
      {
        var tEffect;
        tEffect=instance_create(x+lengthdir_x(8*i,image_angle)+random_range(-2,2),y+lengthdir_y(8*i,image_angle)+random_range(-2,2),oEffect)
        tEffect.sprite_index=sSamusCannonHit; tEffect.depth=9
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      break;
    }
  }
  image_xscale=tMySize

  //Color change
  if colPhase=0
  {
    colTime-=5*gDeltaTime
    if colTime<=135 {colPhase=1}
  }
  else if colPhase=1
  {
    colTime+=5*gDeltaTime
    if colTime>=255 {colPhase=0}
  }

  //Rotate
  rotTime+=1*gDeltaTime
  if rotatePhase=0
  {
    image_angle+=rotSpd*gDeltaTime
    if rotTime>=rotMax
    {
      myDir=image_angle
      rotTime=0; rotatePhase+=1
    }
  }
  else if rotatePhase=1
  {
    if rotTime>=15
    {
      image_angle=myDir
      rotTime=0; rotatePhase+=1
    }
  }
  else if rotatePhase=2
  {
    image_angle-=rotSpd*gDeltaTime
    if rotTime>=rotMax
    {
      myDir=image_angle
      rotTime=0; rotatePhase+=1
    }
  }
  else if rotatePhase=3
  {
    if rotTime>=15
    {
      image_angle=myDir
      rotTime=0; rotatePhase=0
    }
  }
}
