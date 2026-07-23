//Create the swap effect
var tEffect;
tEffect=instance_create(oPlayer1.x+10,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
tEffect.sprite_index=sEfAbilSwap; tEffect.image_speed=0.5; tEffect.xSpd=-0.5
tEffect.followID=other.id; tEffect.xFollow=10; tEffect.yFollow=-(oPlayer1.sprite_height/2)
tEffect.newBlend=-1; tEffect.decay=-100; tEffect.ySpd=0
tEffect=instance_create(oPlayer1.x-10,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
tEffect.sprite_index=sEfAbilSwap; tEffect.image_xscale=-1; tEffect.image_speed=0.5; tEffect.xSpd=0.5
tEffect.followID=other.id; tEffect.xFollow=-10; tEffect.yFollow=-(oPlayer1.sprite_height/2)
tEffect.newBlend=-1; tEffect.decay=-100; tEffect.ySpd=0

if global.optAtkTShow=1
{
  with oAbilSwapNotice {instance_destroy()}
  with oXWepSwapNotice {instance_destroy()}
  instance_create(0,0,oAbilSwapNotice)
}
