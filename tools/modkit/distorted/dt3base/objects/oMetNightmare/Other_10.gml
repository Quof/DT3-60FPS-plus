var tEffect,tAtk;
tEffect=instance_create(x-(gunX*facing),y+gunY,oEffect)
tEffect.sprite_index=sMetNightGunEffect; tEffect.image_speed=0.5
tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=6
tEffect.followID=id; tEffect.xFollow=-gunX*facing; tEffect.yFollow=gunY

tAtk=instance_create(x-(gunX*facing),y+gunY,oPassBullet)
tAtk.sprite_index=sMetNightGunEffect; tAtk.atkPower=atkPower; tAtk.bulletSpeed=5; tAtk.decayTime=-100
tAtk.image_xscale=0.75; tAtk.image_yscale=0.75; tAtk.image_speed=0; tAtk.depth=6
if facing=1 {tAtk._direction=0}
else {tAtk._direction=180}
