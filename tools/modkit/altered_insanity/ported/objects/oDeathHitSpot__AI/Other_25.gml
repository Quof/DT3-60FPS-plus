if room!=rBT_Cousinoer5DeathEX
{
if other.weaponTag=31
{
  oDeath.hitKnife+=1
  if oDeath.hitKnife=4
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=1; tAtkShield.atkUp=1
    resType[1]-=1
    oDeath.resType[1]-=1
  }
  else if oDeath.hitKnife=8
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=1; tAtkShield.atkUp=1
    resType[1]-=1
    oDeath.resType[1]-=1
  }
}
else if other.weaponTag=32
{
  oDeath.hitWater+=1
  if oDeath.hitWater=2
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=2; tAtkShield.atkUp=1
    resType[2]-=1
    oDeath.resType[2]-=1
  }
  else if oDeath.hitWater=4
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=2; tAtkShield.atkUp=1
    resType[2]-=1
    oDeath.resType[2]-=1
  }
}
}
else
{
    if other.weaponTag=31
    {
      oDeathEX.hitKnife+=1
      if oDeathEX.hitKnife=4
      {
        var tAtkShield;
        tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeathEX.id
        tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=1; tAtkShield.atkUp=1
        resType[1]-=1
        oDeathEX.resType[1]-=1
      }
      else if oDeathEX.hitKnife=8
      {
        var tAtkShield;
        tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeathEX.id
        tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=1; tAtkShield.atkUp=1
        resType[1]-=1
        oDeathEX.resType[1]-=1
      }
    }
    else if other.weaponTag=32
    {
      oDeathEX.hitWater+=1
      if oDeathEX.hitWater=2
      {
        var tAtkShield;
        tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeathEX.id
        tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=2; tAtkShield.atkUp=1
        resType[2]-=1
        oDeathEX.resType[2]-=1
      }
      else if oDeathEX.hitWater=4
      {
        var tAtkShield;
        tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeathEX.id
        tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=2; tAtkShield.atkUp=1
        resType[2]-=1
        oDeathEX.resType[2]-=1
      }
    }
}
