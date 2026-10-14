if size=1
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  //spsp ns
  if room=rDistortionF {oPlayer1.hitCombo+=1; oHUD.hitComboFadeTime=60+(global.skillTree[25]*6)}
  instance_destroy()
}
