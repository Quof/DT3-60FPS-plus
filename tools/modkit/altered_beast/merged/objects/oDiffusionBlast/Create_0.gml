event_inherited()
setCollisionBounds(-6,-2,6,2)
image_speed=0.5

tRailGun=0
if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipClaire[i]=34 //Equipment: Rail Gun
      {
        tRailGun=1
        break;
      }
    }
}

if tRailGun=1
{
    damageType="ELEMENTAL"
}
else
{
damageType="SPECIAL"
}

if global.TrueEnabled=1 and global.SamusMissileTrue=1
{
	damageType="TRUE"
}
weaponTag=41
atkLv=global.stSamus_Missile[0]
tAlterOmen=0
if global.alterEquip=1
{
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=27 {tAlterOmen=1}
      if global.equipClaire[i]=27 {tAlterOmen=1}
    }
}
if tAlterOmen=0
{
//atkPower=75+global.stSamus_Missile[0]+global.skillTree[13]
atkPower=75+scrOmenLv(global.stSamus_Missile[0])+global.skillTree[13] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=75+(global.stSamus_Missile[0]-10)
}

atkPower=weaponDmgMod(1,atkPower)
stunTime=12
weaponRehitTime=30
bCanPierce=1
blastDamage=0

_speed=0
_direction=0
_hspeed=0
_vspeed=0
