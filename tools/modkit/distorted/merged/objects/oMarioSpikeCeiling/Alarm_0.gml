if global.location=15 or global.location=49
  sprite_index=sMarbleSpike
else if global.location=40 or global.location=105 or global.location=76 //spsp ns for that last one, PttT
  sprite_index=sVaultSpike
else if global.location=59
  sprite_index=sFacSpike
else if global.location=103
{
  sprite_index=sMarbleSpike
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=2; myShadow.maxShadowDist=192
}

if room=rBT_ZeroA or room=rBT_ZeroB or room=rBT_ZeroC or room=rBT_ZeroD
{
  sprite_index=sMarbleSpike
}

if variable_local_exists("idFollow")
  bFollow=true

if room=rExtGateS_1 //spsp ns
{
    sprite_index=sMarbleSpike
    atkPower=20
}
