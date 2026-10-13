event_inherited()
image_speed=0.75
damageType="EXPLOSION"

weaponTag=2

atkPower=150

stunTime=15

bCanPierce=1


image_xscale=1.5
image_yscale=1.5




if global.alterEquip=1
{
    if global.activeCharacter=0
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=15 {weakenTime=90} //Equipment: Bomber Jacket
      }
    }
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
    if global.activeCharacter=0
    {
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=24
        {
            image_xscale*=2
            image_yscale*=2
            atkPower*=0.7
        }
      }
    }
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
