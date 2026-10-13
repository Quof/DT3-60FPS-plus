event_inherited()
image_speed=0.75
damageType="EXPLOSION"
if global.TrueEnabled=1 and global.SamusBombTrue=1
{
damageType="TRUE"
}
weaponTag=42
atkLv=global.stSamus_Bomb[0]
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
//atkPower=75+round(global.stSamus_Bomb[0]*2)+global.skillTree[13]
atkPower=75+round(scrOmenLv(global.stSamus_Bomb[0])*2)+global.skillTree[13] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    atkPower=75+round((global.stSamus_Bomb[0]-10)*2)
}


atkPower=weaponDmgMod(1,atkPower)
if tAlterOmen=0
{
//stunTime=13+round(global.stSamus_Bomb[0]/2)
stunTime=13+round(scrOmenLv(global.stSamus_Bomb[0])/2) //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
}
else
{
    stunTime=13+round((global.stSamus_Bomb[0]-10)/2)
}

bCanPierce=1
bCanBoost=1
if tAlterOmen=0
{
image_xscale=1+(global.metBombUpgrade*0.07)
image_yscale=1+(global.metBombUpgrade*0.07)
}
else
{
image_xscale=1
image_yscale=1
}

if global.alterEquip=1
{
    if global.activeCharacter=1
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=15 {weakenTime=90} //Equipment: Bomber Jacket
      }
    }
}

if global.alterEquip=1
{
    if global.activeCharacter=1
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipClaire[i]=24
        {
            image_xscale*=2
            image_yscale*=2
            atkPower*=0.7
        }
      }
    }
}

_speed=0
_direction=0
_hspeed=0
_vspeed=0
