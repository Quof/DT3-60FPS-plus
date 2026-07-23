locationCheck(10)

if global.zEncZone=2
{
  with oEnemyBase
    instance_destroy()
  instance_create(128,288,oGreenSlime)
  instance_create(336,128,oDeeler)
  instance_create(384,288,oOctorok)
  instance_create(816,128,oDeeler)
  instance_create(1088,288,oOctorok)
}
else if global.zEncZone=3
{
  with oEnemyBase
    instance_destroy()

  instance_create(336,128,oDeeler)
  instance_create(352,288,oWolfos)
  instance_create(448,128,oDeeler)
  instance_create(976,288,oWolfos)
  instance_create(960,128,oDeeler)
}
else if global.zEncZone=4
{
  with oEnemyBase
    instance_destroy()

  instance_create(336,128,oDeeler)
  instance_create(352,288,oGreenOrc)
  instance_create(448,128,oDeeler)
  instance_create(976,288,oTektile)
  instance_create(960,128,oDeeler)
}

global.bCanSave=false
gameScene=instance_create(0,0,oEvCh4MainA)

var tempMplay;
tempMplay=findMusic(203)
playMusic(tempMplay,0,0)
