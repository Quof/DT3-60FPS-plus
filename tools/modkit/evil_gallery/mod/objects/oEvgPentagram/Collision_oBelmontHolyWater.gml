//Evil Boss Gallery: holy water on Evil Death's pentagram shield (Death's, raised against daggers) breaks it, and him: he
//staggers (his user event 4, which takes the shield away)
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
