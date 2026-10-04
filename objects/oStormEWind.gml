#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //raw 30fps value (the player's movement scales it); xVelSetExt makes pMoveToWrapNew use the 30fps formula for a velocity set every frame
  oPlayer1.xVel=windPower*oStormEagle.image_xscale; oPlayer1.xVelSetExt=1
  if oGame.time mod (3/gDeltaTime)=0
  {
    var tEffect;
    tEffect=instance_create(oStormEagle.x+(random(256)*oStormEagle.image_xscale),266-random(12),oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_xscale=oStormEagle.image_xscale
    tEffect.image_speed=0.33; tEffect.xSpd=(2.5+random(0.5))*oStormEagle.image_xscale
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.ySpd=0
  }
}
