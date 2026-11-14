//Evil Boss Gallery: Evil Barba's evil moves (its Step runs this in its own step's place while evgMove isn't 0, with it
//under the lava; stage 0 is a move's first frame). Done, its own cycle goes on from its short wait (atkCycle 5)
evgT+=1*gDeltaTime
if evgMove=1 //---------- SERPENT LUNGE ----------
{
  if evgStage=0
  {
    lungeLeft=1
    if bossProgress>=3 {lungeLeft=2}
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(a lunge chosen: from the pit furthest from the player, low and high in turn)
  {
    if abs(oPlayer1.x-atkSpot[0])>abs(oPlayer1.x-atkSpot[2]) {lungeX=atkSpot[0]; lungeDir=1}
    else {lungeX=atkSpot[2]; lungeDir=-1}
    lungeLow=1-(lungeNum mod 2)
    lungeNum+=1
    playSound(global.snd_Splash,0,0.9,20000)
    evgStage=2
    evgT=0
  }
  else if evgStage=2 //(the eyes glow in the pit, 24 ticks)
  {
    if evgT>=24
    {
      playSound(global.snd_ShipMovement,0,1,30000)
      var tL;
      tL=instance_create(lungeX,288,oEvgBarbaLunge)
      tL.dir=lungeDir
      tL.low=lungeLow
      tL.atkPower=atkPower
      evgStage=3
      evgT=0
    }
  }
  else if evgStage=3 //(it crosses; the next, or done)
  {
    if !instance_exists(oEvgBarbaLunge) or evgT>=60
    {
      lungeLeft-=1
      if lungeLeft>0 {evgStage=1; evgT=0}
      else
      {
        atkTime=0
        evgMove=0
      }
    }
  }
}
else if evgMove=2 //---------- LAVA GEYSERS ----------
{
  if evgStage=0
  {
    gyRound=0
    gyNum=0
    gyNext=0
    evgStage=1
    evgT=0
  }
  else
  {
    var tRounds;
    tRounds=1
    if bossProgress>=2 {tRounds=2}
    if gyNum<3*tRounds and evgT>=gyNext
    {
      var tOrder,k,tG;
      tOrder="012210102120"
      k=real(string_char_at(tOrder,((gyRound*3+gyNum) mod 12)+1))
      tG=instance_create(atkSpot[k],336,oEvgLavaGeyser)
      tG.atkPower=atkPower
      gyNum+=1
      gyNext+=22
    }
    if gyNum>=3*tRounds and evgT>=gyNext+60
    {
      gyRound+=1
      atkTime=0
      evgMove=0
    }
  }
}
else if evgMove=3 //---------- CAVE-IN ----------
{
  if evgStage=0
  {
    playSound(global.snd_KraidRoarA,0,0.8,30000)
    playSound(global.snd_Earthquake,0,1,1)
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.image_blend=make_color_rgb(120,60,30); tFlash.image_alpha=0.3; tFlash.fadeSpeed=0.04
    rockNum=0
    rockNext=10
    evgStage=1
    evgT=0
  }
  else
  {
    var tMax;
    tMax=5
    if bossProgress>=3 {tMax=7}
    if rockNum<tMax and evgT>=rockNext
    {
      //(the first at the player, the rest on the islands in turn)
      var tX,tR;
      if rockNum mod 2=0 {tX=median(260,oPlayer1.x,572)}
      else
      {
        tR=(rockNum div 2) mod 3
        if tR=0 {tX=336+random(16)}
        else if tR=1 {tX=436+random(24)}
        else {tX=552+random(16)}
      }
      instance_create(tX,128,oEvgFallRock)
      rockNum+=1
      rockNext+=14
    }
    if rockNum>=tMax and evgT>=rockNext+50
    {
      atkTime=0
      evgMove=0
    }
  }
}
else {evgMove=0}
