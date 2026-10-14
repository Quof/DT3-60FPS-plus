event_inherited()
if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,0.4,1)

  if checkScreenArea(x,y,48)=0 and room!=rDoubleSplit2 {instance_destroy()} //spsp DDLC
  if isCollisionLeft(1)
    bShatter=1
  if isCollisionRight(1)
    bShatter=1
  if isCollisionBottom(1)
    bShatter=1
  if isCollisionTop(1)
    bShatter=1

  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  if global.optWeaponTrail=1 and gDeltaDoTicks {instance_create(x,y,oEfWeaponTrail)} //once per 30fps tick

  if bShatter=1
  {
    if checkScreenArea(x,y,64)=1 {playSound(global.snd_HolyWater,0,0.98,1)}
    var tExpLight;
    tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=1.1; tExpLight.image_yscale=1.1
    var tBelmontExplode;
    tBelmontExplode=instance_create(x,bbox_bottom,oBelmontHWExplosion)
    tBelmontExplode.bTrail=bTrail
    if xVel>0 {tBelmontExplode.myDir=1}
    else {tBelmontExplode.myDir=-1}
    instance_destroy()
  }
}
