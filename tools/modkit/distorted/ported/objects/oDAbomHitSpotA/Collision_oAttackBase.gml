if bombflag=2 and bCanTakeDamage=1 and other.damageType="EXPLOSION"
{
  bombflag=1
}
else if bombflag=2 and bCanTakeDamage=1 and other.damageType!="EXPLOSION"
{
  for(i=0;i<6;i+=1){resType[i]=1} //no damage but different from <8 instruments
  event_inherited()
  for(i=0;i<6;i+=1){resType[i]=3}
}
else
{event_inherited()}
