//Evil Boss Gallery: the decoy's fade in, shots and fade out (see Create)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if x<oPlayer1.x {image_xscale=1}
  else {image_xscale=-1}
  if t<15 {image_alpha=0.6*(t/15)}
  else if t<100 {image_alpha=0.6; bCanDealDamage=true}
  else
  {
    image_alpha=0.6*max(0,1-((t-100)/15))
    bCanDealDamage=false
    if t>=115 {instance_destroy()}
  }
  if (t>=30 and shots=0) or (t>=70 and shots=1)
  {
    shots+=1
    sprite_index=sKamekHandsUp
    playSound(global.snd_Magic,0,0.9,1)
    var tAtk;
    tAtk=instance_create(x+(12*image_xscale),y-26,oKamBounceBall)
    tAtk.sprite_index=sKamekShape; tAtk._direction=point_direction(x+(12*image_xscale),y-26,oPlayer1.x,returnPlayerYCenter())
    tAtk.atkPower=atkPower; tAtk.projType=1; tAtk.bulletSpeed=5; tAtk.image_index=irandom_range(0,2)
  }
  if (t>=40 and t<70) or t>=80 {sprite_index=sKamekIdle}
  enemyStepEvent()
}
