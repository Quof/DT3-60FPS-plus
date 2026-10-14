//Desperation Attack

if desperationProg=1 //--------------------------------------------------
{
  if gDeltaDoTicks y-=1
  if y<=96
  {
    desperationProg+=1
    if true          //spsp
    {
        desperationProg=3
        desperationTime=480
    }
  }
}
else if desperationProg=2 //--------------------------------------------------
{
  desperationTime+=1*gDeltaTime
  if desperationTime=45
  {
    var tScnFlash,tZapTrap;
    tScnFlash=instance_create(0,0,oScreenFlash)
    tScnFlash.image_alpha=0.75; tScnFlash.fadeSpeed=0.05
    for(i=0;i<4;i+=1)
    {
      tZapTrap=instance_create(304+(96*i),32,oZapTrap)
      tZapTrap.image_angle=270; tZapTrap.image_xscale=8
    }
  }

  if desperationTime<=1030
  {
    //Top loop
    despTopLoop+=1*gDeltaTime
    if despTopLoop=50
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
      }
    }
    else if despTopLoop=100
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
      }
    }
    else if despTopLoop=150
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
      }
    }
    else if despTopLoop=200
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk._direction=270
      }
    }
    else if despTopLoop=250
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
      }
    }
    else if despTopLoop=300
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
      }
      despTopLoop=0
    }
  }

  //Side bullets
  if desperationTime=120
  {
    var tAtk;
    for(i=0;i<4;i+=1)
    {
      tAtk=instance_create(xCenter+roomSpan+8,yGround-8-(16*i),oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100; tAtk._direction=180
    }
  }
  else if desperationTime=180
  {
    var tAtk;
    for(i=0;i<4;i+=1)
    {
      tAtk=instance_create(xCenter-roomSpan-8,yGround-72-(16*i),oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
    }
  }
  else if desperationTime=310
  {
    var tAtk;
    for(i=0;i<12;i+=1)
    {
      tAtk=instance_create(xCenter+roomSpan+8,yGround-8-(16*i),oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=1; tAtk.decayTime=-100; tAtk._direction=180
    }
  }
  else if desperationTime=660
  {
    var tAtk;
    for(i=0;i<40;i+=1)
    {
      tAtk=instance_create(40+(16*i),32,oPassBullet)
      tAtk.sprite_index=sHFight_DespBulletA; tAtk.atkPower=atkPower
      tAtk.bulletSpeed=1; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk._direction=270
    }
  }
  else if desperationTime=1030 {instance_create(xCenter-roomSpan+24,yGround-24,oTempWarningSymbol)}
  else if desperationTime>=1080
  {
    with oZapTrap {instance_destroy()}
    var tScnFlash;
    tScnFlash=instance_create(0,0,oScreenFlash)
    tScnFlash.image_alpha=0.75; tScnFlash.fadeSpeed=0.05
    bHexFlame=1
    despTopLoop=0
    desperationTime=0
    desperationProg+=1
  }
}
else if desperationProg=3 //--------------------------------------------------
{
  desperationTime+=1*gDeltaTime
  if desperationTime<=480
  {
    if desperationTime mod 8=0 //Bullet line
    {
      var tAtk;
      tAtk=instance_create(xCenter-roomSpan-8,yGround-24,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100
    }

    if desperationTime>=30
    {
      if desperationTime mod 14=0 //Bullet circle
      {
        var tAtk,tDir;
        tDir=0
        for(i=0;i<15;i+=1)
        {
          tAtk=instance_create(x,y,oHF_HexBulletRed)
          tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=tDir+despSpin
          tDir+=360/15
        }
        despSpin+=5
      }
    }

    if desperationTime>=60
    {
      if desperationTime mod 35=0
      {
        var tAtk;
        for(i=0;i<4;i+=1)
        {
          tAtk=instance_create(304+(96*i),32,oHF_HexBulletRed)
          tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270
          tAtk.image_xscale=0.8; tAtk.image_yscale=0.8; tAtk.image_blend=make_color_rgb(200,200,255)
        }
      }
    }

    //Seeking bullets
    despTopLoop+=1*gDeltaTime
    if despTopLoop=50
    {
      tAtk=instance_create(x,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk._direction=point_direction(x,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
    }
    else if despTopLoop=100
    {
      tAtk=instance_create(x-128,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk._direction=point_direction(x-128,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
    }
    else if despTopLoop=150
    {
      tAtk=instance_create(x+128,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk._direction=point_direction(x+128,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
      despTopLoop=0
    }
  }

  if desperationTime>=480 //End desperation attack
  {
    if gDeltaDoTicks y+=1
    if y>=160
    {
      var tHeartDrop;
      for(i=0;i<2;i+=1)
      {
        tHeartDrop=instance_create(xCenter-roomSpan+64+(i*12),280,oHealthPickup)
        tHeartDrop=instance_create(xCenter+roomSpan-64-(i*12),280,oHealthPickup)
      }
      bSliceAtk=1; bHexHands=1; bSwapDeter=1
      despBubbleShield=0; bHexFlame=0
      bCanTakeDamage=true
      shieldProg+=1
      desperationProg=10
    }
  }
}
