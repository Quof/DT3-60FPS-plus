//Seeker Orb
event_inherited()
image_speed=0.33
image_alpha=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
atkTime=0
currHspd=0
currVspd=0

//chao only shoot stuff
shootMaxInterval = 30
shootSet = 1

if global.activeCharacter!=3
{
    canShoot = false
}
else
{
    canShoot = true
    //alarm[0] = shootMaxInterval
    alarm[0] = shootMaxInterval/gDeltaTime //60fps change: alarms count frames
}
