newAttack=instance_create(x,y,oDamageExplosion)
newAttack.atkPower=atkPower; newAttack.decayTime=-100
newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
newAttack.image_xscale=1.25; newAttack.image_yscale=1.25
if sprite_index=sSE_DarkBall {newAttack.image_blend=c_purple}
instance_destroy()
