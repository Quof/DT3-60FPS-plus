//Evil Boss Gallery: an Evil Bowser fireball (in his instance), from his mouth the way he faces: Bowser's (oBowserFire,
//which rises or drops to its height and then flies straight on), in his fire's colour. argument0: 0 at the player's
//chest height (Bowser's), 1 at their feet (the bursts' others: a short hop takes it)
var tNewAttack,tXOffset,tDir;
if image_xscale=1 {tXOffset=8; tDir=0}
else {tXOffset=-8; tDir=180}
playSound(global.snd_Fireball,0,0.99,1)
tNewAttack=instance_create(x+tXOffset,y-28,oBowserFire)
tNewAttack.sprite_index=sEvgBowserFire1; tNewAttack.atkPower=atkPower
tNewAttack.bulletSpeed=3.5; tNewAttack.baseDir=tDir
if argument0=1 {tNewAttack.targetY=oPlayer1.y-8}
