#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
instance_create(x,y,oBombBWave)
image_speed=0.75
damageType="EXPLOSION"
weaponTag=2
atkLv=global.stLink_Bomb[0]
//atkPower=220+(global.stLink_Bomb[0]*4)+(global.skillTree[9]*2)
atkPower=220+(scrOmenLv(global.stLink_Bomb[0])*4)+(global.skillTree[9]*2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(0,atkPower)
//stunTime=22+round(global.stLink_Bomb[0]/2)
stunTime=22+round(scrOmenLv(global.stLink_Bomb[0])/2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
bCanPierce=1
image_xscale=1+(global.linkBombUpgrade*0.04)
image_yscale=1+(global.linkBombUpgrade*0.04)
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
