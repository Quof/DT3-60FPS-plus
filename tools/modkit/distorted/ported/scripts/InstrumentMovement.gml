//room dim: 480,704
//camera room: 480,352
var PhaseNumber;
PhaseNumber=argument0

if InstMoveOn
{
    // Phase 1
    if PhaseNumber=0
    {
      //PhaseOneYTime+=1
      PhaseOneYTime+=1*gDeltaTime //60fps change: per frame
      if frac(PhaseOneYTime)=0 //60fps change (added): the bob moves whole pixels once per 30fps tick, counted from PhaseOneYTime
      {
      PhaseOneY+=PhaseOneYIncrement*((PhaseOneYTime<=PhaseOneWaveDuration/2)-(PhaseOneYTime>PhaseOneWaveDuration/2))
      for(i=0;i<8;i+=1)
      {
        myInstrument[i].y=PhaseOneY
      }
      if PhaseOneYTime>PhaseOneWaveDuration {PhaseOneYTime=0}
      } //60fps change (added)
    }
    else if PhaseNumber=1
    {
      //nothing
    }
    else if PhaseNumber=2
    {
      //PhaseThreeInstruTimer+=2
      PhaseThreeInstruTimer+=2*gDeltaTime //60fps change: per frame
      PhaseThreeInstruTimer-=(PhaseThreeInstruTimer>360)*360
      for(i=0;i<4;i+=1)
      {
        for(j=0;j<2;j+=1)
        {
          myInstrument[2*i+j].x=PhaseThreeX[i]+lengthdir_x(PhaseThreeRadius,PhaseThreeInstruTimer+j*180)
          myInstrument[2*i+j].y=PhaseThreeY[i]+lengthdir_y(PhaseThreeRadius,PhaseThreeInstruTimer+j*180)
        }
      }
    }
    else if PhaseNumber=3
    {
      //nothing yet
    }

    if PhaseNumber=2 or PhaseNumber=3
    {
      //need water block spawns here
      //PhaseThreeTimer+=1
      PhaseThreeTimer+=1*gDeltaTime //60fps change: per frame
      if PhaseThreeTimer=PhaseThreeDelay {instance_create(70,-32,oDesertWaterVol)}
      else if PhaseThreeTimer=PhaseThreeDelay*2 {instance_create(325,-32,oDesertWaterVol)}
      else if PhaseThreeTimer=PhaseThreeDelay*3 {instance_create(155,-32,oDesertWaterVol)}
      else if PhaseThreeTimer=PhaseThreeDelay*4 {instance_create(410,-32,oDesertWaterVol)}
      else if PhaseThreeTimer>=PhaseThreeDelay*5
      {
        instance_create(240,-32,oDesertWaterVol)
        PhaseThreeTimer=0
      }
    }
}

//music and vulnerability handling
instrumentActNum=0
for(i=0;i<8;i+=1)
{
  instrumentActNum+=(myInstrument[i].bCanTakeDamage=0)
}

if instrumentActNum>=instrumentReq //Set the music that is playing
{
  if musicPlaying=0
  {
    var tempMplay;
    tempMplay=findMusic(1019)
    playMusic(tempMplay,0,0)
    musicPlaying=1
  }
}
else
{
  if musicPlaying=1
  {
    var tempMplay;
    tempMplay=findMusic(822)
    playMusic(tempMplay,0,0)
    musicPlaying=0
  }
}
