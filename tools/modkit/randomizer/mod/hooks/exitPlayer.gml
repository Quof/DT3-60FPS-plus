//Randomizer: the player going through an exit (this is the exit)
var b;
//a randomizer boss fight's room left by one of its exits (not every boss room is shut in the fight: the Blade Bot's,
//Low Facility G, has its doors open): the fight ends as one given up from the game over screen does, in the boss
//gallery, where rndBossEnd takes over (the roomStart hook). The player goes back to where they came into the room they
//went into the fight from, or, with the boss beaten already (bBossResultShow), on from where they were. Otherwise the
//fight went on where they walked to: no boss's fight could start, and saving and the pause menu's Teleport stayed off
if global.rndFight>=0 and toRoom!=rBossGallery
{
  toRoom=rBossGallery
  newMapX=1032
  newMapY=496
  rndLocAhead(toRoom)
  exit
}
//the same for one of the boss gallery's own fights (its doors' ones, its flag on and no randomizer fight): back to the
//gallery, as the game's fights there end
if global.bBossGallery=1 and global.rndFight<0 and room!=rBossGallery and toRoom!=rBossGallery
{
  toRoom=rBossGallery
  newMapX=1032
  newMapY=496
  rndLocAhead(toRoom)
  exit
}
//the boss gallery left by its way out, not in a randomizer fight: its flag off, as the room that way out leads to in the
//game turns it off (Central City - North B's code), wherever Entrance Rando has it lead. Otherwise the pause menu's
//Teleport stayed off for good, and no boss's fight could start
if room=rBossGallery and global.rndFight<0 {global.bBossGallery=0}
//Entrance Rando: where the shuffle has it lead (again: an exit the room's code made after it started)
rndERApplyExit()
//the story's way into Ridley's or the Parasitic Seed's fight (rndExitBoss: with Boss Rando, the boss fought there)
b=rndExitBoss(toRoom,newMapX,newMapY)
if b>=0
{
  toRoom=global.rndBossRoom[b]
  newMapX=global.rndBossX[b]
  newMapY=global.rndBossY[b]
  rndLocAhead(toRoom)
  exit
}
//out of the room of a boss not beaten yet past it (an exit on the other side of where its fight starts from the side the
//player came in on: rndRoomSide): the fight instead, so a boss has to be beaten to go on (with Boss Rando, the fight of
//the boss fought there, in that boss's room). An exit on the player's own side doesn't, however far from where they
//came in (Barrens - Great Falloff's two ways out at its west end, the Vault Demon far east); one who came in level
//with the boss: any exit but the one by where they came in
if global.rndRoomBoss>=0 and global.rndFight<0 and global.bBossGallery=0
{
  var tPast;
  if global.rndRoomSide<0 {tPast=(x>global.rndBossFX[global.rndRoomBoss])}
  else if global.rndRoomSide>0 {tPast=(x<global.rndBossFX[global.rndRoomBoss])}
  else {tPast=(point_distance(x,y,global.rndInX,global.rndInY)>128)}
  if tPast
  {
    rndBossStart(global.rndRoomBoss,room,-1,-1)
    toRoom=global.rndBossRoom[global.rndFight]
    newMapX=global.rndBossX[global.rndFight]
    newMapY=global.rndBossY[global.rndFight]
  }
}
//(a Highlands room is made as before the CHAOS Warship's attack: rndHLEnter)
rndHLEnter(toRoom)
//(Entrance Rando: into another area's room, global.location that area's before its instances are made: rndLocAhead)
rndLocAhead(toRoom)
