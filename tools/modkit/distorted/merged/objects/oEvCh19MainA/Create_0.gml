event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0
backgroundSpin=0
serenityEntry=100

if true {stored=0; invact=0}   //spsp

if room=rTS_A and global.gameProgress=4550
{
  fadeAlpha=1
  global.gamePaused=true
}
else if room=rHiddenVillage
{
  if global.newMapX=104 and global.newMapY=1216
  {
    serenityEntry=0
    fadeAlpha=1
  }
  if global.gameProgress=4710
  {
    serenityEntry=100
    fadeColor=c_black
    fadeAlpha=1
  }
}
else if room=rDiscoA or room=rDiscoB or room=rDiscoC
{
  invertTime=1000
  if global.gameProgress=4580 {fadeAlpha=1}
  if room=rDiscoC
  {
    var tNewMace,tDir;
    tDir=0
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(496,56,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=30
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(624,48,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=-3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=0
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(624,336,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=30
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(768,320,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=-3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=0
    for(i=0;i<8;i+=1)
    {
      tNewMace=instance_create(784,120,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=3
      tNewMace.chainLinks=4
      tNewMace.image_blend=c_black
      tDir+=360/8
    }
    tDir=0
    for(i=0;i<12;i+=1)
    {
      tNewMace=instance_create(1072,112,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=-4
      tNewMace.chainLinks=5
      tNewMace.image_blend=c_black
      tDir+=360/12
    }
    tDir=0
    for(i=0;i<16;i+=1)
    {
      tNewMace=instance_create(1904,224,oMarioChainBall)
      tNewMace.dir=tDir
      tNewMace.swingSpeed=4
      tNewMace.chainLinks=6
      tNewMace.image_blend=c_black
      tDir+=360/16
    }
  }
}
else if room=rDiscoD {backgroundSpin=1}
else if room=rDiscoH and global.gameProgress<=4660 {playerRunSpeed=7}
else if room=rDiscoI and global.gameProgress=4670
{
  global.hasShoes[1]=1
  kirbyFade=0
}
else if room=rMain_92 and global.gameProgress=4930
{
  fadeAlpha=1
  global.gamePaused=true
}
else if room=rHiddenVillage_Destroyed and global.gameProgress=4940
{
  if global.Ch19WIn=15
  {
    fadeColor=c_black
    fadeAlpha=1
    global.gamePaused=true
  }
}
else if room=rHiddenVillage_Destroyed and global.gameProgress>=4950
{
  fadeAlpha=0.2
  fadeColor=c_red
}
else if room=rMC_L //Jump player up
{
  jumpTime=0
  if global.gameProgress=5000 {jumpProg=0}
  else {jumpProg=10}
}

//----------------------------------- BACKGROUND SPIN -----------------------------------
if backgroundSpin=1
{
  backFollow[0]=instance_create(0,0,oBackSpriteRotate)
  backFollow[0].backSet=sEfEnergyRip; backFollow[0].image_xscale=5; backFollow[0].image_yscale=5
  backFollow[0].image_speed=0; backFollow[0].image_alpha=0.025; backFollow[0].rotateSpeed=0.5
  backFollow[0].xx=256; backFollow[0].yy=176
  backFollow[1]=instance_create(0,0,oBackSpriteRotate)
  backFollow[1].backSet=sEfEnergyRip; backFollow[1].image_xscale=5; backFollow[1].image_yscale=5
  backFollow[1].image_speed=0; backFollow[1].image_alpha=0.025; backFollow[1].rotateSpeed=-0.5
  backFollow[1].xx=256; backFollow[1].yy=176
}
