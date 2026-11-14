//Evil Boss Gallery: Evil Thunderbird's evil moves (its Step runs this in its own step's place while evgMove isn't 0;
//stage 0 is a move's first frame). Its wings keep beating; done, its own flying goes on from where it is
evgT+=1*gDeltaTime
if bFrameUp=0
{
  animFrame+=0.2*gDeltaTime
  if animFrame>=3.4-0.001 {bFrameUp=1}
}
else
{
  animFrame-=0.2*gDeltaTime
  if animFrame<=0.6+0.001 {bFrameUp=0}
}
if evgMove=1 //---------- THUNDER ----------
{
  if evgStage=0
  {
    boltRound=0
    playSound(global.snd_KraidRoarA,0,0.7,40000)
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(up to the top of its box)
  {
    y+=median(-4*gDeltaTime,rmBd_Top-y,4*gDeltaTime)
    if y=rmBd_Top or evgT>=20 {evgStage=2; evgT=0}
  }
  else if evgStage=2 //(three bolts: the player's spot and 56 either side; the warnings first)
  {
    var k,tX,tG,tB;
    for(k=-1;k<=1;k+=1)
    {
      tX=median(312,oPlayer1.x+k*56,760)
      tG=320
      if tX>=448 and tX<640 {tG=288}
      if tX>=496 and tX<592 {tG=256}
      tB=instance_create(tX-6,tG,oCackLightning)
      tB.type=1+(k=0)*(-1); tB.warnTime=30; tB.decay=12; tB.atkPower=atkPower
    }
    boltRound+=1
    evgStage=3
    evgT=0
  }
  else if evgStage=3
  {
    if evgT>=44
    {
      if boltRound<1+(bossProgress>=2) {evgStage=2; evgT=0}
      else {evgMove=0}
    }
  }
}
else if evgMove=2 //---------- WING GUST ----------
{
  if evgStage=0
  {
    if x<oPlayer1.x {gustDir=1}
    else {gustDir=-1}
    gustNext=20
    gustNum=0
    playSound(global.snd_WindBlow,0,0.9,1)
    evgStage=1
    evgT=0
  }
  else
  {
    //(the wind: like Gate 6's, a little weaker; the player can walk against it)
    oPlayer1.extForceX=1.6*gustDir
    animFrame+=0.4*gDeltaTime
    if animFrame>3.4 {animFrame=0.6}
    if gDeltaDoTicks
    {
      var tEffect;
      tEffect=instance_create(x+gustDir*20,y-10+random_range(-30,40),oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.3; tEffect.image_alpha=0.4
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=gustDir*5; tEffect.ySpd=0
    }
    //(fireballs on the wind, from its side: low at the player's feet, then high over a ducking player)
    if evgT>=gustNext and evgT<=80
    {
      var tF,tY;
      if gustNum mod 2=0 {tY=oPlayer1.y-8}
      else {tY=oPlayer1.y-34}
      tF=instance_create(x,tY,oPassBullet)
      tF.sprite_index=sFireBroFire; tF.atkPower=atkPower; tF.damageType="ELEMENTAL"
      tF._direction=90-gustDir*90; tF.bulletSpeed=4.5; tF.decayTime=-100
      tF.image_xscale=1.4; tF.image_yscale=1.4
      playSound(global.snd_BombLaunch,0,0.82,30000)
      gustNum+=1
      gustNext+=18
    }
    if evgT>=90 {evgMove=0}
  }
}
else if evgMove=3 //---------- SWOOP ----------
{
  if evgStage=0
  {
    playSound(global.snd_KraidRoarA,0,0.8,50000)
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(its eyes flash, 20 ticks; then the dive is set: through where the player is)
  {
    if evgT>=20
    {
      swX0=x
      swY0=y
      swTX=oPlayer1.x
      swTY=oPlayer1.y-24
      swLen=40
      bCanDealDamage=true
      playSound(global.snd_DashWarn,0,1,1)
      evgStage=2
      evgT=0
    }
  }
  else if evgStage=2 //(down through it and up the other side)
  {
    var s;
    s=min(1,evgT/swLen)
    x=swX0+(swTX-swX0)*2*s
    y=swY0+(swTY-swY0)*sin(pi*s)
    x=median(rmBd_Left-60,x,rmBd_Right+60)
    if gDeltaDoTicks
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sThunderbirdBody; tAfterI.image_index=0
      tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
      tAfterI.imageFade=0.15; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
      tAfterI.depth=depth+0.1
    }
    if s>=1
    {
      bCanDealDamage=false
      evgMove=0
    }
  }
}
else {evgMove=0}
