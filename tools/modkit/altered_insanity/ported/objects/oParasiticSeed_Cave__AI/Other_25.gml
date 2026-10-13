if armorCheck=3
{
  if other.damageType="EXPLOSION"
  {
    armorHP-=1
    if armorHP<=0
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=3
      }
      resType[3]=2
      armorCheck+=1
    }
  }
}

if other.weaponTag=1 {hitCheckArrow+=1}
if other.weaponTag=41 {hitCheckMissile+=1}
