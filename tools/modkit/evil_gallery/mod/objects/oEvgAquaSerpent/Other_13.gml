//Evil Boss Gallery: Evil Aqua Serpent's evil moves (its Step runs this in its own step's place while evgMove isn't 0,
//with it off the arena after a swim; stage 0 is a move's first frame). Done, its next swim starts (moveProg 0)
evgT+=1*gDeltaTime
var tBase;
tBase=272
if floorSeq>=3 {tBase=oWaterVolume.y}
if evgMove=1 //---------- TIDAL WAVE ----------
{
  if evgStage=0
  {
    waveNum=0
    waveLeft=1
    if bossProgress>=2 {waveLeft=2}
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(a wave: from the platform end further from the player, then the other)
  {
    var tW,tDir;
    if waveNum=0
    {
      if oPlayer1.x<432 {tDir=-1}
      else {tDir=1}
    }
    else {tDir=-pullDir}
    pullDir=tDir
    tW=instance_create(432-tDir*150,tBase,oEvgTidalWave)
    tW.dir=tDir
    tW.atkPower=atkPower
    playSound(global.snd_Splash,0,1,14000)
    waveNum+=1
    evgStage=2
    evgT=0
  }
  else if evgStage=2
  {
    if waveNum<waveLeft and evgT>=50 {evgStage=1}
    else if waveNum>=waveLeft and !instance_exists(oEvgTidalWave) {moveProg=0; evgMove=0}
  }
}
else if evgMove=2 //---------- SPIRAL RINGS ----------
{
  if evgStage=0
  {
    x=432
    y=room_height+48
    direction=90
    sprite_index=sAquaSer_HeadA
    ringNum=0
    ringGap=irandom(2)
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(up out of the water under the platform)
  {
    y-=3*gDeltaTime
    if y<=328 {y=328; sprite_index=sAquaSer_HeadC; evgStage=2; evgT=0}
  }
  else if evgStage=2 //(a ring every 40 ticks: 11 shots over the upper half, 3 of them left out where the gap is)
  {
    if evgT>=10+ringNum*40 and ringNum<3+(bossProgress>=3)
    {
      playSound(global.snd_RidleyFire,0,1,22000)
      var k,tF,tG;
      tG=1+((ringGap+ringNum*3) mod 7)
      for(k=0;k<11;k+=1)
      {
        if k<tG or k>tG+2
        {
          tF=instance_create(x,y-6,oPassBullet)
          tF._direction=15+k*15; tF.sprite_index=sWolfHeadShot
          tF.image_xscale=1.5; tF.image_yscale=1.5
          tF.atkPower=atkPower; tF.bulletSpeed=3; tF.decayTime=-100
        }
      }
      ringNum+=1
    }
    if ringNum>=3+(bossProgress>=3) and evgT>=10+ringNum*40+20 {sprite_index=sAquaSer_HeadA; evgStage=3; evgT=0}
  }
  else if evgStage=3 //(back down)
  {
    y+=4*gDeltaTime
    if y>=room_height+64
    {
      moveProg=0
      evgMove=0
    }
  }
}
else if evgMove=3 //---------- UNDERTOW ----------
{
  if evgStage=0
  {
    if oPlayer1.x<432 {pullDir=1}
    else {pullDir=-1}
    spoutNum=0
    playSound(global.snd_WindBlow,0,0.8,14000)
    evgStage=1
    evgT=0
  }
  else
  {
    oPlayer1.extForceX=1.4*pullDir
    if gDeltaDoTicks
    {
      var tEffect;
      tEffect=instance_create(304+random(256),tBase+2+random(6),oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.3; tEffect.image_alpha=0.35; tEffect.image_blend=c_teal
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=pullDir*4; tEffect.ySpd=0
    }
    //(a spout every 30 ticks, from deep under where the player is)
    if evgT>=20+spoutNum*30 and spoutNum<3+(bossProgress>=2)
    {
      var tS;
      playSound(global.snd_Splash,0,1,10000)
      tS=instance_create(oPlayer1.x,room_height+24,oAquaSer_WaterShot)
      tS.bulletSpeed=3
      spoutNum+=1
    }
    if evgT>=110
    {
      moveProg=0
      evgMove=0
    }
  }
}
else {evgMove=0}
