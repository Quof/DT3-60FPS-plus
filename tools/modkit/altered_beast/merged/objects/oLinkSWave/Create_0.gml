event_inherited()
damageType="NORMAL"
if global.TrueEnabled=1 and global.LinkSwordTrue=1
{
    damageType="TRUE"
}
weaponTag=0
atkLv=global.stLink_Sword[0]
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
//atkPower=(100+round(global.stLink_Sword[0]*2.5)+(global.skillTree[8]*6))*0.75
atkPower=(100+round(scrOmenLv(global.stLink_Sword[0])*2.5)+(global.skillTree[8]*6))*0.75 //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=(100+round((global.stLink_Sword[0]-10)*2.5))*0.75
}
atkPower=weaponDmgMod(0,atkPower)
if tAlterOmen=0
{
stunTime=8+global.skillTree[0]
}
else
{
    stunTime=8
}
bCanHitSwitch=0
bCanPierce=1
global.recAtkNum+=1
global.stLink_Sword[2]+=1
image_xscale=oPlayer1.image_xscale
image_speed=0
image_index=2
decayTime=13
