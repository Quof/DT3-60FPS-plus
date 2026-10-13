///ALTER SHIFT TIME
if ATTACK_FORM=1 //======================================== MAIN FORM ========================================
{
  if other.damageType="NORMAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=5; shiftTime+=5}
    else {shiftDamage+=3; shiftTime+=3}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }

  if image_xscale>0
  {

  }
  else
  {

  }
}
else if ATTACK_FORM=2 //======================================== FIRE FORM ========================================
{
  if other.damageType="PIERCE" or other.damageType="ELEMENTAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=5; shiftTime+=5}
    else {shiftDamage+=3; shiftTime+=3}
    if other.weaponTag=32 {shiftDamage+=2; shiftTime+=2}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
else if ATTACK_FORM=3 //======================================== ICE FORM ========================================
{
  if other.damageType="SHOT" or other.damageType="EXPLOSION"
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=5; shiftTime+=5}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
else if ATTACK_FORM=4 //======================================== WIND FORM ========================================
{
  if other.damageType="SPECIAL"
  {
    if timeTillLastHit<=25 {shiftDamage+=5; shiftTime+=5}
    else {shiftDamage+=3; shiftTime+=3}
  }
  else
  {
    if timeTillLastHit<=25 {shiftDamage+=3; shiftTime+=3}
    else {shiftDamage+=2; shiftTime+=2}
  }
}
timeTillLastHit=0
if waitTime<waitDelay {waitTime+=1}
