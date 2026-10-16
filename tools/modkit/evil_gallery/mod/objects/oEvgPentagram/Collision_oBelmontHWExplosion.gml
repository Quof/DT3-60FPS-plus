//Evil Boss Gallery: holy water's fire on Evil Death's pentagram shield breaks it, as the vial does
//(Collision_oBelmontHolyWater)
if atkProg<10
{
  var tEffect;
  for(i=0;i<5;i+=1)
  {
    tEffect=instance_create(x,y-20+(i*10),oEffect)
    tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=(i-2)*0.4; tEffect.ySpd=-0.5
  }
  with (oEvgDeath) {event_user(4)}
}
