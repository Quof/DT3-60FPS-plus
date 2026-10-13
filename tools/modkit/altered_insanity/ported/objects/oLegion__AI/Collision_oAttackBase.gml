//bone fix (added): the bones only come off on a hit that lands. This used to run whenever an attack touched him while he
//wasn't flashing, including attacks that had already hit him (oDamagableBase skips those), so a lingering or piercing
//attack threw 4 bones every frame (4x as many at 120fps) and they piled up into the hundreds
var tWasHit;
tWasHit=bTakingDamage
event_inherited()
//if bTakingDamage=false and other.bCanDealDamage=true and bActive=true
if tWasHit=false and bTakingDamage=true //bone fix: the hit just landed (takeDamage set bTakingDamage)
{
  var tEffect,txSpd,tLen,tDir;
  for(i=0;i<4;i+=1)
  {
    txSpd=random_range(-3,3)
    tLen=random(60)
    tDir=random(360)
    tEffect=instance_create(x,y,oEffectGrav)
    tEffect.x=x+lengthdir_x(tLen,tDir); tEffect.y=y+lengthdir_y(tLen,tDir); tEffect.type=2
    tEffect.sprite_index=sLegionBones; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.fadeSpd=0.015
    tEffect.xSpd=txSpd; tEffect.ySpd=-4-random(3); tEffect.grav=0.4; tEffect.rotation=-8*txSpd
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
  }
}
//event_inherited() //bone fix: before the bones now (above)
