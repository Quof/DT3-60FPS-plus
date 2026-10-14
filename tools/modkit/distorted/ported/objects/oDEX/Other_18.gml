///Phase cleanup
global.newMapX+=1
fullheal=instance_create(oPlayer1.x,oPlayer1.y,oHealthPickup)
fullheal.sprite_index=sFullHealthPickup

with oEProjectileBase
{
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
    instance_destroy()
}
with oDEXslash {instance_destroy()}
with oLatchCrystal {instance_destroy()}
with oStaticSpike {instance_destroy()}
//grace period, but so it doesn't happen on respawns?
grace=1
bCanTakeDamage=0; bCanDealDamage=0
maxLife=30000 //only different on the first phase
life=maxLife
oPlayer1.dashEnergy=9999 //needed for Miku
image_alpha=0.5
//speed=0
_hspeed=0; _vspeed=0 //60fps change: the boss moves by _hspeed/_vspeed now

stopAllMusic()
