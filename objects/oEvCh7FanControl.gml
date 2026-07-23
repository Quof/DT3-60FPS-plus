#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fanTime=0
currFan=0

if room=rMountTemple_F
{
  fanDelay=30
  maxFans=3
  fanID[0]=(208097)
  fanID[1]=(207995)
  fanID[2]=(207996)
}
if room=rMountTemple_G
{
  fanDelay=70
  maxFans=1
  fanID[0]=(209022)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  fanTime+=1
  if fanTime=fanDelay
  {
    if fanID[currFan].spinning=1 {fanID[currFan].spinning=0}
    else {fanID[currFan].spinning=1}
    currFan+=1
    if currFan=maxFans {currFan=0}
    fanTime=0
  }
}
