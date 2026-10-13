if global.gamePaused=false
{
  if atkProg=0
  {
    if oPlayer1.x>=128 and room=rGame6_DLC
    {
      
      with oExit {instance_destroy()}
      var tempMplay;
      tempMplay=findMusic(835)
      playMusic(tempMplay,0,0)
      y=128
      activateBoss=1
      atkProg=1
    }
    else if room=rC5_Arena8
    {
      activateBoss=1
      atkProg=1
    }
  }

  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
    oPlayer1.dashEnergy+=40

    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    atkTime+=1*gDeltaTime
    if atkTime mod 14=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<8;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=6; tFeather.image_blend=c_red; tFeather._direction=tDir
        tDir+=45
      }
    }
    if atkTime mod 27=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter()); tDir-=4
      for(i=0;i<3;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=13; tFeather.image_blend=c_red; tFeather._direction=tDir
        tDir+=4
      }
    }
    if atkTime mod 42=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<64;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=2; tFeather.image_blend=c_red; tFeather._direction=tDir
        tDir+=5.625
      }
    }
    if atkTime mod 59=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<32;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=7; tFeather.image_blend=c_red; tFeather._direction=tDir
        tDir+=11.25
      }
    }
    if atkTime mod 150=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<32;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=7; tFeather._direction=tDir
        tFeather.bCanBeBlocked=1; tFeather.blockCost=300; tFeather.bParryOpp=1
        tDir+=11.25
      }
    }
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  //var tempMplay;
  //tempMplay=findMusic(0)
  //playMusic(tempMplay,0,0)
  instance_destroy()
}
