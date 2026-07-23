#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: eventType
viscidTop=1
makeActive()
deathCheck=0
solidIsNearPlayers=0

eventProg=0
eventTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if eventProg=1
{
  eventTime+=1
  if eventTime=1
  {
    for(i=0;i<12;i+=1)
    {
      tEffect=instance_create(x,y-(i*12),oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=random_range(-0.5,0.5)

      tEffect=instance_create(x-(320*image_xscale),y-(i*12),oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=random_range(-0.5,0.5)
    }
  }

  if eventType=1 //Rotate down
  {
    image_angle+=1
    if image_angle>=20 {eventProg=2}
  }
  else if eventType=2 //Move down
  {
    yVel=2
    if eventTime>=eventEnd {yVel=0; eventProg=2}
  }
  else if eventType=3 //Move down and rotate
  {
    yVel=2
    image_angle+=1
    if eventTime>=eventEnd {yVel=0; eventProg=2}
  }
  else if eventType=4 //Move down and rotate (opposite way)
  {
    yVel=2
    image_angle-=1
    if eventTime>=eventEnd {yVel=0; eventProg=2}
  }
}
