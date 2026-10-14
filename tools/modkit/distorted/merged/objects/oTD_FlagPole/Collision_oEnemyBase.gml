var tFlash,tEffect;
tFlash=instance_create(0,0,oScreenFlash)
tFlash.image_alpha=0.8; tFlash.image_blend=c_red; tFlash.fadeSpeed=0.2
var tEffect;
tEffect=instance_create(x,y+32,oEffect)
tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=2; tEffect.image_yscale=2
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
if object_is_ancestor(other,oTD_Ground) or object_is_ancestor(other,oTD_Flyer)      //spsp
{
oTD_HUD.tdStat_Stability-=other.stabilityDmg
}
else {oTD_HUD.tdStat_Stability-=1}
with other
{
  instance_destroy()
}
