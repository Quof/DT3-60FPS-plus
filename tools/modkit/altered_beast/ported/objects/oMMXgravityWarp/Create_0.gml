event_inherited()

image_speed=0.4

damageType="SPECIAL"
if global.TrueEnabled=1 and global.XGravTrue=1
{
damageType="TRUE"
}
weaponTag=12
atkLv=global.stMega_Gravity[0]
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
    atkPower=60+round(global.stMega_Gravity[0]*1.5)+global.skillTree[10]
}
else
{
    atkPower=60+round((global.stMega_Gravity[0]-10)*1.5)
}

atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_Gravity[2]+=1
stunTime=5
bCanPierce=1
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

lifeTime=90
special=1

image_xscale = 19
image_yscale = 15
weaponRehitTime=1000
oPlayer1.grav/=3
