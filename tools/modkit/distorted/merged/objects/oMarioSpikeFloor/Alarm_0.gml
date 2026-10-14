if global.location=15 or global.location=57 or global.location=58 or global.location=106 //spsp for the last one, Metroid Nightmare
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

if global.location=106 {atkPower=12} //spsp ns met nightmare
// DO THIS CONSISTENTLY FOR THE ENTIRE S GATE
if room=rExtGateS_1 //spsp ns
{
    sprite_index=sMarbleSpike
    atkPower=20
}

if variable_local_exists("idFollow")
  bFollow=true
