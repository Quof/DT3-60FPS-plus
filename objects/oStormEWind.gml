#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  oPlayer1.xVel=windPower*oStormEagle.image_xscale
  if oGame.time mod 3=0
  {
    var tEffect;
    tEffect=instance_create(oStormEagle.x+(random(256)*oStormEagle.image_xscale),266-random(12),oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=oStormEagle.image_xscale
    tEffect.image_speed=0.33; tEffect.xSpd=(2.5+random(0.5))*oStormEagle.image_xscale
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.ySpd=0
  }
}
