//Evil Boss Gallery: Evil Death staggered: holy water broke his pentagram shield (oEvgPentagram) or his soul siphon (his
//user event 3, oEvgDeathHS). 75 ticks on his knees (his Step counts them down), harmless to touch, every hit on him
//doing double (oEvgDeathHS)
if myHS.life>0 and superProg<=1 and staggerTime<=0
{
  playSound(global.snd_PotShatter,0,1,1)
  staggerTime=75
  evgMove=0; evgStage=0; evgT=0
  shielding=0
  with (oDeathPentagramShield) {instance_destroy()}
  with (oEvgSiphon) {instance_destroy()}
  siphon=noone
  sprite_index=sEvgDeathDuck; image_index=0; image_angle=0
  xVel=0
  fadeA=1
  atkSwingNum=0; atkSwingTime=0; atkSwingType=-1; bSwing=0
  if atkTime>=atkDelay {atkTime=0}
  myHS.bCanTakeDamage=true
  bCanDealDamage=false

  var tFlash,tEffect;
  tFlash=instance_create(0,0,oScreenFlash)
  tFlash.image_blend=make_color_rgb(230,230,255); tFlash.image_alpha=0.45; tFlash.fadeSpeed=0.05
  for(i=0;i<8;i+=1)
  {
    tEffect=instance_create(x,y-40,oKillEffect)
    tEffect.speed=3; tEffect.direction=i*45; tEffect.friction=0.11
    tEffect.fadeAlpha=0.025; tEffect.imageRot=0
  }
}
