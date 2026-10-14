if global.gamePaused=false
{
  if life>0
  {
    if atkProg=0 //Rise up
    {
      if gDeltaDoTicks y-=2
      if y<=288 {atkProg+=1}
    }
    else if atkProg=1 //Open hand
    {
      atkTime+=1*gDeltaTime
      if atkTime=15 {image_index=1}
      else if atkTime=20 {image_index=2}
      else if atkTime=25
      {
        image_index=3
        atkTime=0 atkProg+=1
      }
    }
    else if atkProg=2 //Attack
    {
      atkTime+=1*gDeltaTime
      if atkTime=atkDelay
      {
        var tAtk,tDir;
        tDir=point_direction(x-(40*image_xscale),y-119,oPlayer1.x,returnPlayerYCenter())
        tAtk=instance_create(x-(40*image_xscale),y-119,oPassBullet)
        tAtk.sprite_index=sHexShieldConnector; tAtk.atkPower=atkPower; tAtk.image_xscale=2; tAtk.image_yscale=0.5
        tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk._direction=tDir
      }
      else if atkTime=atkDelay+12
      {
        var tAtk,tDir;
        tDir=point_direction(x-(40*image_xscale),y-97,oPlayer1.x,returnPlayerYCenter())
        tAtk=instance_create(x-(40*image_xscale),y-97,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_HandZap; tAtk.atkPower=atkPower; tAtk.bulletSpeed=7
        tAtk.image_speed=0.33; tAtk.decayTime=-100; tAtk._direction=tDir
      }
      else if atkTime=atkDelay+15
      {
        atkCycle+=1
        if atkCycle>=2 {atkCycle=0; atkTime=0; atkProg+=1}
        else {atkTime=5}
      }
    }
    else if atkProg=3 //Close hand
    {
      atkTime+=1*gDeltaTime
      if atkTime=15 {image_index=2}
      else if atkTime=20 {image_index=1}
      else if atkTime=25
      {
        image_index=0
        atkTime=0 atkProg+=1
      }
    }
    else if atkProg=4 //Linger a bit
    {
      atkTime+=1*gDeltaTime
      if atkTime>=20 {atkTime=0 atkProg+=1}
    }
    else if atkProg=5 //Drop down
    {
      y+=4*gDeltaTime
      if y>=560 {instance_destroy()}
    }
    enemyStepEvent()
  }

  if life<=0
  {
    image_blend=c_red
    image_alpha-=0.04*gDeltaTime
    if image_alpha<=0
    {
      if oPlayer1.life<oPlayer1.maxLife
      {
        oHex_Final_Main.heartDrop+=1
        if oHex_Final_Main.heartDrop>=2
        {
          tHeartDrop=instance_create(x,280,oHealthPickup)
          oHex_Final_Main.heartDrop=0
        }
      }
      instance_destroy()
    }
  }
}
