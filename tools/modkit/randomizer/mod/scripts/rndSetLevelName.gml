//Randomizer: what an ability set's level gives (argument0: the set, hasAbilToken's index; argument1: the level, 2 up)
var s,l;
s=argument0
l=argument1
if s=0 {return "Mario Ability Set"}
if s=1
{
  if l=2 {return "Link: Master Sword"}
  if l=3 {return "Link: Bow & Arrow"}
  return "Link: Fuse Bomb"
}
if s=2
{
  if l=2 {return "Belmont: Hair Whip"}
  if l=3 {return "Belmont: Dagger"}
  return "Belmont: Holy Water"
}
if s=3
{
  if l=2 {return "Mega Man: X Buster"}
  if l=3 {return "Mega Man: Shotgun Ice"}
  if l=4 {return "Mega Man: Gravity Well"}
  return "Mega Man: Grapple"
}
if s=4
{
  if l=2 {return "Samus: Arm Cannon"}
  if l=3 {return "Samus: Morph Ball"}
  if l=4 {return "Samus: Charge Beam"}
  if l=5 {return "Samus: Missiles"}
  if l=6 {return "Samus: Spazer Beam"}
  if l=7 {return "Samus: Bombs"}
  return "Samus: Diffusion Missile"
}
if s=5
{
  if l=2 {return "Jerry's Game Powers"}
  return "Jerry's Game Powers: Bird Swarm"
}
if l=2 {return "Claire's Game Powers"}
return "Claire's Game Powers: Flame Shield"
