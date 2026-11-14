//Evil Boss Gallery: Evil Cackletta's evil moves (her Step runs this in her own step's place while evgMove isn't 0;
//stage 0 is a move's first frame). Done, the phone call she was about to make goes on (evgDone)
evgT+=1*gDeltaTime
if evgMove=1 //---------- THUNDER CAGE ----------
{
  if evgStage=0
  {
    sprite_index=sCacklettaArmSwing
    evgRow=0
    evgNext=0
    evgWarn=40
    if life<=2 {evgWarn=34}
    evgRows=3
    if bossProgress>=1 {evgRows=4}
    if life<=2 {evgRows=5}
    evgStage=1
    evgT=0
  }
  else
  {
    if evgT>=4 and sprite_index=sCacklettaArmSwing {sprite_index=sCacklettaWings}
    //a row: bolts every 24px across the arena (centres 300-636), none within 24 of its gap (M 464, L 320, R 608: on
    //solid ground once the floor's gone, and never more than 144 apart from one row to the next); the next row's
    //warnings come up as this row's bolts go out (evgWarn to strike, 12 striking). Each cage goes left first, the next
    //right first (evgCage)
    if evgRow<evgRows and evgT>=evgNext
    {
      var tGap,tC,tB,tCh;
      tCh=string_char_at("MLMRM",evgRow+1)
      if evgCage mod 2=1
      {
        if tCh="L" {tCh="R"}
        else if tCh="R" {tCh="L"}
      }
      if tCh="L" {tGap=320}
      else if tCh="R" {tGap=608}
      else {tGap=464}
      tB=noone
      for(tC=300;tC<=636;tC+=24)
      {
        if abs(tC-tGap)>=24
        {
          tB=instance_create(tC-6,yGround,oCackLightning)
          tB.type=1; tB.warnTime=evgWarn; tB.decay=12
        }
      }
      if tB!=noone {tB.type=0}
      evgRow+=1
      evgNext+=evgWarn+12
    }
    if evgRow>=evgRows and evgT>=evgNext+10
    {
      sprite_index=sCacklettaIdle
      evgCage+=1
      evgMove=0
      evgDone=1
    }
  }
}
else if evgMove=2 //---------- BAT BARRAGE ----------
{
  if evgStage=0
  {
    sprite_index=sCacklettaLaugh; image_index=0
    playSound(global.snd_DemonLaugh,0,0.8,30000)
    evgBats=0
    evgNext=18
    evgStage=1
    evgT=0
  }
  else
  {
    var tMax;
    tMax=5
    if life<=2 {tMax=6}
    if evgBats<tMax and evgT>=evgNext
    {
      sprite_index=sCacklettaWings
      var tBat;
      tBat=instance_create(x,y-30,oEvgCackBat)
      tBat.dir=point_direction(x,y-30,oPlayer1.x,returnPlayerYCenter())
      tBat.spd=4.5
      if life<=2 {tBat.spd=5.5}
      tBat.atkPower=atkPower
      playSound(global.snd_OrbThrow,0,0.85,30000)
      evgBats+=1
      evgNext+=12
    }
    if evgBats>=tMax and evgT>=evgNext+24
    {
      sprite_index=sCacklettaIdle
      evgMove=0
      evgDone=1
    }
  }
}
else {evgMove=0; evgDone=1}
