event_inherited()
/*enemyCount=-1
fadeColor=c_white
fadeAlpha=0*/
//global.difficulty=2

//allow "execution time" for each attack, and start with the "empty time" being 3 seconds
ATK=9
dragonSPD=5
dragontime=120
firetime=0
dragondelay=210 //+30
firedelay=210 //+30   <^ both for duration
dragonspread=2
dragonoffset=10
headX=244 //whatever
headdist=180 //150 plus change for movement
headheight=208 //=roomheight/2
headROT=180 //whatever

correction=35

/*if room=rExtGateG_1 or room=rExtGateG_2 or room=rExtGateG_3 or room=rExtGateG_4 or room=rExtGateG_5
{
  backIsleSpawn=0
  for(i=0;i<round(room_width/256);i+=1)
  {
    instance_create(random_range(48,room_width-48),random_range(48,room_height+48),oGG_BackIsle)
  }
  
  if room=rExtGateG_1
  {
    var tTrap,tDir;
    tDir=0
    for(i=0;i<24;i+=1)
    {
      tTrap=instance_create(4808,208,oMovingTrap)
      tTrap.shiftTime=0; tTrap.shiftMax=60; tTrap.moveSpd=3; tTrap.bShowLine=1
      tTrap.direction=tDir
      tDir+=360/24
    }
  }
  else if room=rExtGateG_2
  {
    mapTime=0
    slimeTime=0
  }
  else if room=rExtGateG_3
  {
    var tTrap,tDir;
    tDir=0
    for(i=0;i<24;i+=1)
    {
      tTrap=instance_create(3584,224,oMovingTrap)
      tTrap.shiftTime=0; tTrap.shiftMax=60; tTrap.moveSpd=3; tTrap.bShowLine=1
      tTrap.direction=tDir
      tDir+=360/24
    }
  }
  else if room=rExtGateG_4
  {
    if global.newMapX>=2800
    {
      with (346602) {instance_destroy()}
      with (346605) {instance_destroy()}
      sceneProgress=1
    }
    if global.newMapX>=3600 {sceneProgress=3}
  }
  else if room=rExtGateG_5
  {
    bossCheck=string_char_at(global.eGateProg,7)
    if bossCheck="8" {global.mapTeleport=0}
    else {global.mapTeleport=7}
  }
}*/
