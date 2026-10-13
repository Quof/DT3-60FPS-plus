event_inherited()
image_xscale=4
image_yscale=4
image_speed=0.5
damageType="EXPLOSION"
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
    atkPower=170+round(global.stSamus_Bomb[0]*3)+global.skillTree[13]
}
else
{
    atkPower=170+round((global.stSamus_Bomb[0]-10)*3)
}
atkPower=weaponDmgMod(1,atkPower)
stunTime=6
bCanPierce=1
bCanBoost=1
decayTime=10

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
weaponRehitTime=1000
