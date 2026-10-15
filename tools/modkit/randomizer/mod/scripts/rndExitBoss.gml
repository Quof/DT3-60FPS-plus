//Randomizer: the player going from this room into another (argument0: the room; argument1, argument2: where they come
//in) the story's way into a boss whose room an endgame world's exit goes past (rndBossViaFrom/To: Ridley's, the
//Parasitic Seed's), not beaten yet: its fight starts (rndBossStart: with Boss Rando, the fight of the boss fought there),
//and after it's won the player comes into argument0 where they would have, or where the via's way back is
//(rndBossViaBackRoom/X/Y: Ridley's hatch leads into the tunnel, a dead end whose story chase would start again: back up
//in rSamus5_Lv4_N instead). The caller then takes the player to the fight: rndBossRoom, rndBossX/Y of the boss
//returned. Returns the boss fought, or -1
var b,i;
if global.rndActive=0 or global.bBossGallery=1 or global.rndFight>=0 {return -1}
b=-1
for(i=0;i<global.rndBossN;i+=1)
{
  if global.rndBossViaFrom[i]=room and global.rndBossViaTo[i]=argument0 {b=i; break}
}
if b<0 {return -1}
if string_char_at(global.rndBossDone,b+1)!="0" {return -1}
if global.rndBossViaBackRoom[b]>=0 {rndBossStart(b,global.rndBossViaBackRoom[b],global.rndBossViaBackX[b],global.rndBossViaBackY[b])}
else {rndBossStart(b,argument0,argument1,argument2)}
return global.rndFight
