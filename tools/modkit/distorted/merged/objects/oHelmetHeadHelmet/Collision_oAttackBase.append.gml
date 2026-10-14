event_inherited()
if gDeltaDoTicks //60fps change (added): one revenge bullet per 30fps tick of contact, as at 30fps (the collision event runs every frame)
{
var tFire;
tFire=instance_create(x,y-4,oPassBullet)
tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
//tFire.direction=player_sprite_center()
tFire._direction=player_sprite_center() //60fps change: DT3+'s oPassBullet moves by its own _direction
} //60fps change (added)
