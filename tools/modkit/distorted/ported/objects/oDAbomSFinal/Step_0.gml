if global.gamePaused=false
{
  if cancer>=1
  {
    //cancer+=1
    cancer+=1*gDeltaTime //60fps change: per frame
    if cancer<7 {image_blend=c_purple}
    else if cancer<12 {image_blend=c_aqua}
    else if cancer<17 {image_blend=c_lime}
    else if cancer<27
    {
      image_blend=c_white
      sprite_index=sAbomSpawnGlitch
      if cancer=17 {playSound(global.snd_Static,0,1,1)}
      image_speed=1
    }
    else
    {
      /*image_blend=c_white
      sprite_index=sAbomSpawn
      playSound(global.snd_Static,0,1,1)*/
      sprite_index=sAbomSpawn
      for(i=0;i<6;i+=1){resType[i]=3}
      cancer=-1
      image_speed=0.2
    }
  }
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      if ddd<10
      {
        dDist+=ddd
        mDist+=ddd
        ddd+=10
      }
      
      if x>oPlayer1.x
        image_xscale=-1
      else
        image_xscale=1

      myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
      myDist=round(myDist/32)
      if myDist>dDist //5
        myDist=dDist //5
      else if myDist<mDist //3
        myDist=mDist //3
      maxSpeed=myDist

      if x>oPlayer1.x
      {
        if currHspd>-maxSpeed
          //currHspd-=currAcc
          currHspd-=currAcc*gDeltaTime //60fps change: per frame, as DT3+'s oAbomSFinal
        else
          currHspd=-maxSpeed
      }
      else if x<oPlayer1.x
      {
        if currHspd<maxSpeed
          //currHspd+=currAcc
          currHspd+=currAcc*gDeltaTime //60fps change: per frame, as DT3+'s oAbomSFinal
        else
          currHspd=maxSpeed
      }
      if y>oPlayer1.y-26
      {
        if currVspd>-maxSpeed
          //currVspd-=currAcc
          currVspd-=currAcc*gDeltaTime //60fps change: per frame, as DT3+'s oAbomSFinal
        else
          currVspd=-maxSpeed
      }
      else if y<oPlayer1.y-26
      {
        if currVspd<maxSpeed
          //currVspd+=currAcc
          currVspd+=currAcc*gDeltaTime //60fps change: per frame, as DT3+'s oAbomSFinal
        else
          currVspd=maxSpeed
      }
      _hspeed=currHspd
      _vspeed=currVspd
    }
    else
    {
      _hspeed=0
      _vspeed=0
    }
  }
  else if life<=0
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      image_speed=0
      _hspeed=0
      _vspeed=0
      baseColor=c_red; image_blend=c_red
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.03*gDeltaTime
    if image_alpha<0
    {
      instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oHealthPickup)
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else
{
  _hspeed=0
  _vspeed=0
}
correctHSpeedVSpeed(self)
