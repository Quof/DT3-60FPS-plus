locationCheck(34)
global.mapTeleport=41

var tNewEnemy,tDir;
tDir=0
for(i=0;i<12;i+=1)
{
  tNewEnemy=instance_create(328+lengthdir_x(16,tDir),216+lengthdir_y(16,tDir),oCV_BonePillar)
  tNewEnemy.image_angle=tDir
  tDir+=360/12
}
for(i=0;i<24;i+=1)
{
  tNewEnemy=instance_create(520+lengthdir_x(16,tDir),184+lengthdir_y(16,tDir),oCV_BonePillar)
  tNewEnemy.image_angle=tDir
  tDir+=360/24
}
for(i=0;i<48;i+=1)
{
  tNewEnemy=instance_create(872+lengthdir_x(16,tDir),168+lengthdir_y(16,tDir),oCV_BonePillar)
  tNewEnemy.image_angle=tDir
  tDir+=360/48
}

var tempMplay;
tempMplay=findMusic(304)
playMusic(tempMplay,0,0)
