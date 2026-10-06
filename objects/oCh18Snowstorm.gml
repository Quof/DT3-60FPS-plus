#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
stormTime=0
stormDelay=195
stormDuration=105
bStorming=0
stormDir=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  stormTime+=1*gDeltaTime
  if bStorming=0
  {
    if stormTime>=stormDelay
    {
      bStorming=1
      stormTime=0
    }
  }
  else
  {
    oPlayer1.extForceX=1*stormDir
    if stormTime>=stormDuration
    {
      bStorming=0
      if stormDir=1 {stormDir=-1}
      else {stormDir=1}
      stormTime=0
    }
  }
}

//if bStorming=1
if bStorming=1 and gDeltaDoTicks //60fps change: snowflakes spawn once per 30fps tick (per frame was 2x/4x as many at 60/120fps)
{
  var tSnow,tRanScl;
  for(i=0;i<3;i+=1)
  {
    tRanScl=0.2+random(0.2)
    tSnow=instance_create(view_xview[0]+random(480),view_yview[0]+random(352),oSnowflake)
    tSnow.type=2; tSnow.image_index=irandom_range(0,2)
    //tSnow.vspeed=random_range(8,11); tSnow.hspeed=random_range(8,12)*stormDir
    tSnow._vspeed=random_range(8,11); tSnow._hspeed=random_range(8,12)*stormDir //60fps change: built-in speed moves per frame, so storm flakes flew 2x/4x too fast at 60/120fps; oSnowflake moves by _hspeed/_vspeed
    tSnow.image_xscale=tRanScl; tSnow.image_yscale=tRanScl
  }
}
