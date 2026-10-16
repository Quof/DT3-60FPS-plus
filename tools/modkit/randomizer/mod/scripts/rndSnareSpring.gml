//Randomizer: a trap item springs on the player (argument0: the trap, rndgen.py's SNARE_TYPES: 1 Darkness, 2 Rocketeer,
//3 Teleport, 4 Achilles, 5 Wind Orb), with its message (rndGiveKP gives it). Darkness, Rocketeer, Achilles and Wind Orb
//last the option's time of play (global.rndSnareTime: 2, 5 or 10 minutes; rndSnareT: 30fps ticks left, counted down
//while the game isn't paused: rndSnareTick; the save keeps them); one sprung while it's on starts its time again.
//Darkness: Dark Mode's darkness in every room (rndSnareDark, rndSnareRoom). Rocketeer: a CHAOS Rocketeer now, and
//another in every room come into (rndSnareRocket). Teleport: to a way into a room the player has come in by this run, at
//random (rndSnareTeleport), as soon as it can (in a boss fight, once it's over: rndSnareCanGo). Achilles: any hit kills,
//as in Achilles Mode (the mod's takeDamage: rndgen.py's SCRIPT_PATCHES). Wind Orb: the Green Warmaster's seeker orb,
//which can't be destroyed, after the player now and in every room come into (rndSnareOrb)
var p,tFor;
p=argument0
tFor=" for "+string(round(global.rndSnareTime/1800))+" minutes."
playSound(global.snd_DemonLaugh,0,1,1)
if p=1
{
  global.rndSnareT[1]=global.rndSnareTime
  rndSnareDark(1)
  rndMsg("It's a trap!#Darkness: the lights are out"+tFor,2)
}
else if p=2
{
  global.rndSnareT[2]=global.rndSnareTime
  rndSnareRocket()
  rndMsg("It's a trap!#CHAOS Rocketeers are after you"+tFor,2)
}
else if p=3
{
  global.rndSnarePend=1
  rndMsg("It's a trap!#Teleport: you're being sent back somewhere...",2)
}
else if p=4
{
  global.rndSnareT[4]=global.rndSnareTime
  rndMsg("It's a trap!#Achilles: any hit kills you"+tFor,2)
}
else if p=5
{
  global.rndSnareT[5]=global.rndSnareTime
  rndSnareOrb()
  rndMsg("It's a trap!#Wind Orb: the Warmaster's orb hunts you"+tFor,2)
}
