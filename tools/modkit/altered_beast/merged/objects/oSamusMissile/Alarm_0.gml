atkPower=round(atkPower*exPwr)
if image_angle=90 or image_angle=270 {setCollisionBounds(-2,-6,2,6)}

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

if tRailGun=1 and sprite_index=sSamusSuperMissile
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
