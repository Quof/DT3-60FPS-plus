locationCheck(10)

if global.zEncZone=2
{
  with oEnemyBase
    instance_destroy()
  instance_create(128,288,oMegmet)
  instance_create(384,288,oMegmet)
  instance_create(880,288,oMegmet)
  instance_create(1088,288,oMegmet)
}
else if global.zEncZone=3
{
  with oEnemyBase
    instance_destroy()
  instance_create(128,288,oMegmet)
  instance_create(512,256,oOctorok)
  instance_create(880,288,oOctorok)
  instance_create(1088,288,oMegmet)
}
else if global.zEncZone=4
{
  with oEnemyBase
    instance_destroy()
  instance_create(128,272,oTektile)
  instance_create(384,272,oTektile)
  instance_create(880,272,oTektile)
  instance_create(1088,272,oTektile)
}

global.bCanSave=false
gameScene=instance_create(0,0,oEvCh4MainA)

var tempMplay;
tempMplay=findMusic(203)
playMusic(tempMplay,0,0)
