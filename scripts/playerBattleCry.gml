//This determines the player's battle sounds.

if currentAttackCombo!=3
{
  attackSound=round(random(2))
  playSound(global.snd_PlayerAtk[attackSound],0,1,hitCombo*10)
}
else
{
  attackSound=round(random(1))
  playSound(global.snd_PlayerStrAtk[attackSound],0,1,hitCombo*10)
}
