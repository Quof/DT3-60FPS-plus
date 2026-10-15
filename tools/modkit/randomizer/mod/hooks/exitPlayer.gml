//Randomizer: the player going through an exit (this is the exit)
var b;
//Entrance Rando: where the shuffle has it lead (again: an exit the room's code made after it started)
rndERApplyExit()
//the story's way into Ridley's or the Parasitic Seed's fight (rndExitBoss: with Boss Rando, the boss fought there)
b=rndExitBoss(toRoom,newMapX,newMapY)
if b>=0
{
  toRoom=global.rndBossRoom[b]
  newMapX=global.rndBossX[b]
  newMapY=global.rndBossY[b]
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
