if rockProg=0 and bCanTakeDamage=1
{
  hitNum+=1
  if hitNum=12
  {
    bCanTakeDamage=0
    image_xscale=1; image_yscale=1
    hitNum=0
    rockProg+=1
  }
}

if deflectorTime>=deflectorDelay
{
  if other.weaponTag=0 or other.weaponTag=30
  {
    deflectorHits+=1
    if deflectorHits>=4
    {
      deflectorHits=0; deflectorTime=0
    }
  }
}

if correctResType=1
{
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[4]=1 //spsp ns
  resType[5]=5 //spsp ns
  correctResType=0
}
