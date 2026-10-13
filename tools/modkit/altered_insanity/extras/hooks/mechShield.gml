//In Altered Insanity's boss challenges, the mech's shield goes up above and below it when Up is held (playerTechStart,
//in the player; returns 1 when it has put the shields up).
var playerAttack;
if global.inBossChallenge=1 and kUp and mechShieldUses>0
{
  if global.location=110 {playSound(global.snd_NewAbilitySet,0,0.85,10000)}
  else {playSound(global.snd_NewAbilitySet,0,0.92,14000)}
  mechShieldUses-=1
  playerAttack=instance_create(x,y-70,oJMechShield)
  playerAttack.image_angle=90
  playerAttack=instance_create(x,y+15,oJMechShield); playerAttack.image_xscale=-1
  playerAttack.image_angle=90
  return 1
}
return 0
