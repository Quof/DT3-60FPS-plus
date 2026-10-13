bCanDealDamage=true
if sprite_index=sSamusChargeCannon
{
  if image_angle=0 or image_angle=180 {setCollisionBounds(-8,-2,8,2)}
  else {setCollisionBounds(-2,-8,2,8)}
  weaponRehitTime=1
}
else if sprite_index=sSamusSpazer
{
  if image_angle=0 or image_angle=180 {setCollisionBounds(-8,-5,8,5)}
  else {setCollisionBounds(-5,-8,5,8)}
}
else if sprite_index=sSamusChargeSpazer
{
  if image_angle=0 or image_angle=180 {setCollisionBounds(-8,-5,8,5)}
  else {setCollisionBounds(-5,-8,5,8)}
  weaponRehitTime=1
}
