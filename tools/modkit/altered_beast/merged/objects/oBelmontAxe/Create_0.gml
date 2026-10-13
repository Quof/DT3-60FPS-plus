//Axe vision: Throws upwards in an arc just like in the original. up or forward to modify the arc. Charge it up to throw forward acts like crucifix boomerange.
//If nightmare ability is active, down down B will throw 3 axes at different distances.
//will do 1.5x knife damage, use a few more hearts. Charge will use even more hearts.

event_inherited()

setCollisionBounds(-5,-5,5,5)
arcType=1
damageType="PIERCE"
if global.TrueEnabled=1 and global.BelmontKnifeTrue=1
{
	damageType="TRUE"
}
weaponTag=31
atkLv=global.stBelmont_Dagger[0]
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
    atkPower=75+(global.stBelmont_Dagger[0]*2.5)+global.skillTree[12]
}
else
{
    atkPower=75+((global.stBelmont_Dagger[0]-10)*2.5)
}

atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stBelmont_Dagger[2]+=1
stunTime=7





image_yscale*=1.5
  image_xscale=oPlayer1.image_xscale*1.5
bulletSpeed=12
arcTime=17
lifeTime=75
//alarm[0] =1
alarm[0]=round(1/gDeltaTime) //60fps change: the direction is set one 30fps tick after creation, as at 30fps (alarms count frames)

//60fps change (added): DT3+'s own motion (correctSpeedDirection in the Step event); the direction is set by Alarm 0
_speed=0
_direction=0
_hspeed=0
_vspeed=0
