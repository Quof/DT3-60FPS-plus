#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mapProg=0
mapTime=0
spikeTrap=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if mapProg=0
  {
    if oPlayer1.x>=2848
    {
      for(i=0;i<2;i+=1)
      {
        mySpike[i]=instance_create(2864+(i*16),320,oStaticSpikeRed)
      }
      mapProg+=1
    }
  }
  else if mapProg=1
  {
    mapTime+=1
    if mapTime>=12 {mapTime=0; mapProg+=1}
    for(i=0;i<2;i+=1)
    {
      mySpike[i].y-=32
    }
  }
  else if mapProg=2
  {
    if oPlayer1.x>=3024
    {
      for(i=0;i<2;i+=1)
      {
        mySpike[i]=instance_create(3040+(i*16),320,oStaticSpikeRed)
      }
      mapProg+=1
    }
  }
  else if mapProg=3
  {
    mapTime+=1
    if mapTime>=12 {mapTime=0; mapProg+=1}
    for(i=0;i<2;i+=1)
    {
      mySpike[i].y-=32
    }
  }
  else if mapProg=4
  {
    if oPlayer1.x>=3328
    {
      for(i=0;i<2;i+=1)
      {
        mySpike[i]=instance_create(3344+(i*16),320,oStaticSpikeRed)
      }
      mapProg+=1
    }
  }
  else if mapProg=5
  {
    mapTime+=1
    if mapTime>=12 {mapTime=0; mapProg+=1}
    for(i=0;i<2;i+=1)
    {
      mySpike[i].y-=32
    }
  }
}
