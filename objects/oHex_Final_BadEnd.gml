#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanDealDamage=0

//Enemy base statistics
eName="Hex"
eLevel=39
maxLife=20000
life=maxLife
atkPower=11
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
bossProgress=0
activateBoss=0

//--------------------
//Animation Data
wingFrm=-1
xJitter=0
jitterMoment=0

//Attack Data
featherAtkTime=0
featherAtkDelay=180
featherAtkDir=20

sliceTime=100
sliceDelay=200
currSlice=0
maxSlice=3

energyCreatorTime=100
energyCreatorDelay=250

desperationProg=0
desperationTime=0
despBubbleShield=0
despWarn=0
despX1=224; despX2=320; despX3=416; despX4=512; despX5=608
despTopLoop=0
despSpin=0

//Dialogue Data
dialogueProg=0
dialogueTime=0
fallingDebris=0
abomImageY=-1000

//Misc Data
xCenter=448
yGround=288
roomSpan=240

jeremyText="Hex is holding back... a lot. He's up to something. There's also a very large presense gathering, which is weirding me out. I don't know where it's coming from."
chaoText="Hex is acting very strange here. As if he's completely confident that he's going to win. He's not even trying to put up a fight with you guys."
devText="No Dev Commentary at this time."

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
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
    if desperationProg=0
    {
      //-------------------- Bring out wings --------------------
      jitterMoment+=1
      if jitterMoment=5 {image_index=1}
      else if jitterMoment=10 {image_index=2}
      else if jitterMoment>=11 and jitterMoment<=26
      {
        if xJitter=1 {xJitter=-1}
        else {xJitter=1}
      }
      else if jitterMoment=27
      {
        wingFrm=0
        xJitter=0
        var tEffect,tXspd;
        for(i=0;i<32;i+=1)
        {
          tXspd=random_range(-4,4)
          tEffect=instance_create(x+random_range(-3,3),y+random_range(-12,12),oEffectGrav)
          tEffect.type=2; tEffect.sprite_index=sHex_A_EfFeather
          tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=-tXspd*9
          tEffect.grav=0.3; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        }
      }
      else if jitterMoment=31 {wingFrm=1}
      else if jitterMoment=35 {wingFrm=2}

      //-------------------- ATTACK: FEATHER SEEK --------------------
      featherAtkTime+=1
      if featherAtkTime=featherAtkDelay {featherAtkDir=20}
      else if featherAtkTime=featherAtkDelay+10
      {
        playSound(global.snd_Wave,0,0.95,1)
        var tFeatherAtk;
        tFeatherAtk=instance_create(x,y,oHF_BE_FeatherSeek)
        tFeatherAtk.atkPower=atkPower
        tFeatherAtk.decayTime=-100; tFeatherAtk.direction=featherAtkDir
        tFeatherAtk=instance_create(x,y,oHF_BE_FeatherSeek)
        tFeatherAtk.atkPower=atkPower
        tFeatherAtk.decayTime=-100; tFeatherAtk.direction=featherAtkDir-180

        featherAtkDir-=20
        if featherAtkDir=-40 {featherAtkTime=0}
        else {featherAtkTime=featherAtkDelay+4}
      }

      //-------------------- ATTACK: SCREEN SLICE --------------------
      sliceTime+=1
      if sliceTime>=sliceDelay and sliceTime mod 7=0
      {
        var tRanX,tRanY,tMyLineAng,tSrnSlice;
        if random(10)>5
        {
          tRanX=oPlayer1.x+random_range(-128,128)
          tRanY=choose(0,room_height)
        }
        else
        {
          tRanX=choose(208,688)
          tRanY=oPlayer1.y+random_range(-96,96)
        }
        tMyLineAng=point_direction(tRanX,tRanY,oPlayer1.x,oPlayer1.y-26)

        tSrnSlice=instance_create(tRanX,tRanY,oHex_First_Slash)
        tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=tMyLineAng

        currSlice+=1
        if currSlice>=maxSlice
        {
          currSlice=0
          sliceTime=0
        }
      }

      //-------------------- ATTACK: ENERGY CREATOR --------------------
      energyCreatorTime+=1
      if energyCreatorTime>=energyCreatorDelay
      {
        playSound(global.snd_RidleyFire,0,0.95,12000)
        var tEnCreate;
        tEnCreate=instance_create(x,y,oHF_BE_EnergyCreator)
        tEnCreate.direction=45; tEnCreate.bulletSpd=4; tEnCreate.atkPower=atkPower
        tEnCreate=instance_create(x,y,oHF_BE_EnergyCreator)
        tEnCreate.direction=135; tEnCreate.bulletSpd=4; tEnCreate.atkPower=atkPower
        if bossProgress>=2
        {
          var tEnCreate;
          tEnCreate=instance_create(x,y,oHF_BE_EnergyCreator)
          tEnCreate.direction=30; tEnCreate.bulletSpd=5
          tEnCreate=instance_create(x,y,oHF_BE_EnergyCreator)
          tEnCreate.direction=150; tEnCreate.bulletSpd=5
        }
        energyCreatorTime=0
      }
    }

    if desperationProg>=1 and desperationProg<=9 //Desperation Attack
    {
      event_user(0)
    }

    //----- Falling Debris -----
    if fallingDebris>0
    {
      var tEffect;
      for(i=0;i<fallingDebris;i+=1)
      {
        tEffect=instance_create(224+random(448),32,oEffectGrav)
        tEffect.type=2; tEffect.sprite_index=sHFight_Debris; tEffect.xSpd=0; tEffect.ySpd=0.5+random(1)
        tEffect.fadeSpd=0.02+random(0.02); tEffect.rotation=0; tEffect.grav=0.3; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        tEffect.image_speed=0; tEffect.image_index=choose(0,1)
      }
    }

    //-------------------- Dialogue --------------------
    dialogueTime+=1
    if dialogueProg=1
    {
      if dialogueTime=1
      {
        msgCreate(0,0,"Hex","I don't even have to try with you.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if dialogueTime=100
      {
        msgCreate(0,0,"Hex","It's really quite silly that you didn't catch it.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
        dialogueProg=2
      }
    }
    else if dialogueProg=3
    {
      if dialogueTime=1
      {
        msgCreate(0,0,"Hex","You know that there's really no way you can win?",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if dialogueTime=110
      {
        msgCreate(0,0,"Hex","It was there the entire time. Just waiting. You didn't even see it.",0,1,oMessagePerson,0)
        newMessage.fadingTime=130
        dialogueProg=4
      }
    }
    else if dialogueProg=5
    {
      if dialogueTime=1
      {
        msgCreate(0,0,"Hex","It's almost time to end this farce. I grow bored of this.",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if dialogueTime=120
      {
        msgCreate(0,0,"Hex","Existence as you know it will end soon.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
        dialogueProg=6
      }
    }
    else if dialogueProg=7
    {
      if dialogueTime=1
      {
        msgCreate(0,0,"Hex","I can't wait any longer, it's time to call it up.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if dialogueTime=110
      {
        msgCreate(0,0,"Jeremy","What are you talking about, call what?",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if dialogueTime=210
      {
        sliceTime=-10000
        var tViewShake;
        tViewShake=instance_create(448,0,oStaticViewShaker)
        tViewShake.shakeAmt=1
        playSound(global.snd_Earthquake,1,0.93,1)
        fallingDebris=1
        msgCreate(0,0,"Hex","The Abomination. Did you really think I let it out of the Vault for no reason?",0,2,oMessagePerson,0)
        newMessage.fadingTime=150
      }
      else if dialogueTime=360
      {
        msgCreate(0,0,"Jeremy","What are you about to do, Hex?",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      else if dialogueTime=460
      {
        msgCreate(0,0,"Hex","That creature will fuse with the Warship. Once it does, it will set about on a rampage like no other.",0,2,oMessagePerson,0)
        newMessage.fadingTime=180
      }
      else if dialogueTime=640
      {
        msgCreate(0,0,"Hex","It is invincible and there are no weaknesses known. You can't stop this one, Jeremy.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150
      }
      else if dialogueTime=790
      {
        msgCreate(0,0,"Jeremy","I can try!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if dialogueTime=850
      {
        oStaticViewShaker.shakeAmt=3
        fallingDebris=2
        msgCreate(0,0,"Hex","It is far too late! The creature is already here!",0,2,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if dialogueTime=900 {featherAtkTime=-10000; energyCreatorTime=-10000}
      else if dialogueTime=960
      {
        global.canPause=0
        abomImageY=830
        oEvCh20MainA.fadeColor=c_black
        oStaticViewShaker.shakeAmt=6
        depth=0
      }
      else if dialogueTime>=961
      {
        abomImageY-=4
        if abomImageY<=448
        {
          oEvCh20MainA.fadeAlpha+=0.025
          if oEvCh20MainA.fadeAlpha>=1
          {
            stopAllMusic()
            stopLoopingSounds()
            dialogueTime=0; dialogueProg=10
            global.gamePaused=1
            global.optShowHUD=0
            room_goto(rBadEnd)
          }
        }
      }
    }
  }
  enemyStepEvent()

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.98 and lifePercent>=0.92 and bossProgress=0
  {
    dialogueTime=0; dialogueProg=1
    bossProgress+=1
  }
  else if lifePercent<=0.91 and lifePercent>=0.88 and bossProgress=1
  {
    dialogueTime=0; dialogueProg=3
    desperationProg=1
    despBubbleShield=1
    bCanTakeDamage=false
    bossProgress+=1
  }
  else if lifePercent<=0.87 and lifePercent>=0.81 and bossProgress=2
  {
    dialogueTime=0; dialogueProg=5
    bossProgress+=1
  }
  else if lifePercent<=0.8 and lifePercent>=0.64 and bossProgress=3
  {
    dialogueTime=0; dialogueProg=7
    bossProgress+=1
  }
  else if lifePercent<=0.63 and lifePercent>=0.08 and bossProgress=4
  {
    for(i=0;i<6;i+=1)
    {
      resType[i]=2
    }
    bossProgress+=1
  }
  else if lifePercent<=0.07 and lifePercent>=0 and bossProgress=5
  {
    life=maxLife
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Desperation Attack

if desperationProg=1 //--------------------------------------------------
{
  y-=1
  if y<=96
  {
    desperationProg+=1
  }
}
else if desperationProg=2 //--------------------------------------------------
{
  desperationTime+=1
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
    despTopLoop+=1
    if despTopLoop=50
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=100
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=150
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=200
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=250
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=300
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
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
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100; tAtk.direction=180
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
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=1; tAtk.decayTime=-100; tAtk.direction=180
    }
  }
  else if desperationTime=660
  {
    var tAtk;
    for(i=0;i<40;i+=1)
    {
      tAtk=instance_create(40+(16*i),32,oPassBullet)
      tAtk.sprite_index=sHFight_DespBulletA; tAtk.atkPower=atkPower
      tAtk.bulletSpeed=1; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=270
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
  desperationTime+=1
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
          tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=tDir+despSpin
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
          tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
          tAtk.image_xscale=0.8; tAtk.image_yscale=0.8; tAtk.image_blend=make_color_rgb(200,200,255)
        }
      }
    }

    //Seeking bullets
    despTopLoop+=1
    if despTopLoop=50
    {
      tAtk=instance_create(x,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk.direction=point_direction(x,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
    }
    else if despTopLoop=100
    {
      tAtk=instance_create(x-128,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk.direction=point_direction(x-128,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
    }
    else if despTopLoop=150
    {
      tAtk=instance_create(x+128,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk.direction=point_direction(x+128,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
      despTopLoop=0
    }
  }

  if desperationTime>=480 //End desperation attack
  {
    y+=1
    if y>=160
    {
      bCanTakeDamage=true
      desperationProg=0
      despBubbleShield=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if wingFrm>=0
{
  draw_sprite_ext(sHex_A_WingsTop,wingFrm,x+xJitter+4,y-9,1,1,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHex_A_WingsTop,wingFrm,x+xJitter-4,y-9,-1,1,image_angle,image_blend,image_alpha)
}

//----- Main body -----
draw_sprite_ext(sprite_index,image_index,x+xJitter,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if wingFrm>=0
{
  draw_sprite_ext(sHex_A_WingsBottom,wingFrm,x+xJitter+2,y-3,1,1,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHex_A_WingsBottom,wingFrm,x+xJitter-2,y-3,-1,1,image_angle,image_blend,image_alpha)
}

//----- Hex Bubble Shield -----
if despBubbleShield=1
{
  draw_sprite_ext(sWaterBarrier,oGame.time/4,x,y,0.75,0.75,image_angle,image_blend,0.3)
}

//----- Abomination -----
if abomImageY>-1000
{
  draw_sprite_ext(sAbom_Base,0,448,abomImageY,2,2,0,c_white,1)
}
