//Altered Insanity's game over hints (in oGameOver; they set hintMessage). argument0: 0 for the boss and situation
//hints, 1 for the room hints.
if argument0=0
{
  if global.currentBoss="Kamekletta"
    hintMessage="Keeping one at full health will make for a slower, but safer fight"
  else if global.currentBoss="Thunderbarb"
    hintMessage="Careful when juggling Bird over the pits, and remember you have all your attacks here, get creative!"
  else if global.currentBoss="Sera Brain"
    hintMessage="Always be analyzing for escape routes through the ceaseless projectiles. You have super charged dash regen, so go wild!"
  else if global.currentBoss="Virus Demon"
    hintMessage="If you're gonna get hit, let Vault Demon hit you with his less damaging attacks"
  else if global.currentBoss="" and instance_exists(oSituationalGO_Message)
  {
    if oSituationalGO_Message.type=3
      hintMessage="You killed a Mario enemy, you monster :("
    else if oSituationalGO_Message.type=4
      hintMessage="Jebaited :^)  (you should scan those melons)"
    else if oSituationalGO_Message.type=5
      hintMessage="Careful with that Starman!"
  }
}
else if argument0=1
{
  if room=rC5_Arena8
    hintMessage="Dash energy recharges slower than you think since you aren't attacking, use them wisely! Also if you must take a hit, take the least damaging hit you can."
}
