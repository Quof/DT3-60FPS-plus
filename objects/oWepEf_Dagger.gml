#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_vspeed=-3
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale=1
{
  _hspeed=-1.25
  image_angle+=30*gDeltaTime
}
else
{
  _hspeed=1.25
  image_angle-=30*gDeltaTime
}

//was vspeed+=0.3*gDeltaTime: GM's built-in vspeed is applied in full every frame (and _vspeed, which correctHSpeedVSpeed
//moves, never changed), so the falling dagger dropped too fast above 30fps. yGravBias: gravity arc correction (see moveTo)
{_vspeed+=0.3*gDeltaTime; yGravBias=0.3}
image_alpha-=0.06*gDeltaTime

if image_alpha<=0
  instance_destroy()
correctHSpeedVSpeed(self)
