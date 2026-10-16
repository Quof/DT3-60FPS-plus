//Randomizer: a trap item springs on the player (argument0: the trap, rndgen.py's SNARE_TYPES: 1 Darkness, 2 Rocketeer,
//3 Teleport, 4 Achilles), with its message (rndGiveKP gives it). Darkness, Rocketeer and Achilles last 5 minutes of play
//(global.rndSnareT: 30fps ticks left, counted down while the game isn't paused: rndSnareTick; the save keeps them); one
//sprung while it's on starts its 5 minutes again. Darkness: Dark Mode's darkness in every room (rndSnareDark,
//rndSnareRoom). Rocketeer: a CHAOS Rocketeer now, and another in every room come into (rndSnareRocket). Teleport: to a
//way into a room the player has come in by this run, at random (rndSnareTeleport), as soon as it can (in a boss fight,
//once it's over: rndSnareCanGo). Achilles: any hit kills, as in Achilles Mode (the mod's takeDamage: rndgen.py's
//SCRIPT_PATCHES)
var p;
p=argument0
playSound(global.snd_DemonLaugh,0,1,1)
if p=1
{
  global.rndSnareT[1]=global.rndSnareTime
  rndSnareDark(1)
  rndMsg("It's a trap!#Darkness: the lights are out for 5 minutes.",2)
}
else if p=2
{
  global.rndSnareT[2]=global.rndSnareTime
  rndSnareRocket()
  rndMsg("It's a trap!#CHAOS Rocketeers are after you for 5 minutes.",2)
}
else if p=3
{
  global.rndSnarePend=1
  rndMsg("It's a trap!#Teleport: you're being sent back somewhere...",2)
}
else if p=4
{
  global.rndSnareT[4]=global.rndSnareTime
  rndMsg("It's a trap!#Achilles: any hit kills you for 5 minutes.",2)
}
