if bNormalResist=0
{
  if other.weaponTag=0 or other.weaponTag=30
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=0; tAtkShield.atkUp=1
    resType[0]-=1
    bNormalResist=1
  }
}
