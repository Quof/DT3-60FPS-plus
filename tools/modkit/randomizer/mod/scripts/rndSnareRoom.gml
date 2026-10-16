//Randomizer: the trap items (rndSnareSpring) as a room starts (the roomStart hook): a Darkness Trap's darkness in it, a
//Rocketeer Trap's Rocketeer and a Wind Orb Trap's orb (not in a boss fight), and what a Teleport Trap that brought the
//player here did. And the
//way into the room the player came by, for a Teleport Trap later (rndSnareHistAdd: not in a boss fight or the boss
//gallery, nor in the Zelda road encounters, which put the player at a place of their own; kept with Traps on, or in an
//Archipelago game, whose world may have them)
if global.rndSnareT[1]>0 {rndSnareDark(1)}
if global.rndSnareT[2]>0 {rndSnareRocket()}
if global.rndSnareT[5]>0 {rndSnareOrb()}
if global.rndSnareArrive=1
{
  global.rndSnareArrive=0
  rndMsg("It's a trap!#Teleport: you were sent back somewhere you've been.",2)
}
if (global.rndSnareMode=1 or global.rndAP=1) and global.rndFight<0 and global.bBossGallery=0 and instance_exists(oPlayer1)
{
  if room!=rLink2_EnRoad and room!=rLink2_EnGrass and room!=rLink2_EnDesert and room!=rLink2_EnForest
  {
    rndSnareHistAdd(room,global.newMapX,global.newMapY)
  }
}
