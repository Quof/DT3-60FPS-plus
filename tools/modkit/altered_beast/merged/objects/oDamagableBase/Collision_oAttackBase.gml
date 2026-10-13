if bTakingDamage=false and other.bCanDealDamage=true and bActive=true
{
  var tempCheck;
  tempCheck=0
  for(i=0;i<other.maxAtkId;i+=1)
  {
    if other.atkId[i]=id
      tempCheck=1
  }
  if tempCheck=0
  {
    if other.weaponTag=40 //Drop Samus charge shot damage by 1.25% till it gets down to 50%
    {
      if other.exPwr!=1
      {
        tAlterCannon = 0
          if global.alterEquip=1
          {
              for(i=0;i<3;i+=1)
              {
                if global.equipClaire[i]=37 //Equipment: Plasma Canister
                {
                  tAlterCannon=1
                }
              }
          }
        if other.exPwr>0.5 or tAlterCannon = 1
        {
          
          if (tAlterCannon = 0)
        {
          other.exPwr-=0.0125
          }
          else
          {
            other.exPwr+=0.02
          }
          other.atkPower=round(other.basePower*other.exPwr)
        }
      }
    }
    event_user(14) //Before damage (per enemy script)
    takeDamage(other)
    event_user(15) //After damage (per enemy script)
    if other.weakenTime > 0
    {
        weakened=other.weakenTime
    }
    other.atkId[other.maxAtkId]=id
    other.atkIdTime[other.maxAtkId]=0
    other.maxAtkId+=1
  }
}
