with (other)
{
if global.location=15 or global.location=57 or global.location=58
  sprite_index=sMarbleSpike
else if global.location=40 or global.location=105 or global.location=88
{
  sprite_index=sVaultSpike
  if true {atkPower=12} //spsp ns
}
else if global.location=59
  sprite_index=sFacSpike
else if global.location=76 or global.location=69
{
  sprite_index=sVaultSpike
  atkPower=12
}
else if global.location=99
{
  sprite_index=sVaultSpike
  atkPower=12
}
else if global.location=103
{
  sprite_index=sMarbleSpike
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
}

if variable_local_exists("idFollow")
  bFollow=true
}
