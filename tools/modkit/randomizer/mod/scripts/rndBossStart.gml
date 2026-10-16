//Randomizer: a boss's fight starts. The boss gallery's setup for the boss's type (rndBossSetup: its currentBoss and
//bossTrack, for the boss room's code to make the boss; the player as who they are) with the player's own abilities,
//all on (rndAbilApply), and the gallery's flag on, so the boss, beaten, goes to the gallery, where rndBossEnd takes
//over (the gallery's timer isn't shown in these fights: the mod's oHUD). argument0: the boss whose place it is (its
//room, or the exit the story went into its fight by); with Boss Rando the boss fought there is another's
//(rndBRFight), in that boss's own room. global.rndFight: the boss fought, rndFightSlot: whose place (rndBossEnd marks
//it beaten). The caller takes the player to the fight: rndBossRoom[rndFight], rndBossX/Y[rndFight]. argument1: the
//room the player goes to after the fight is won, argument2, argument3: where in it (argument2 -1: where they were when
//the boss was beaten; for another boss's fight, where this one's starts, or where they came into the room for one that
//starts as it's come into). Lost or given up, they go back to where they came into the room they went into the fight
//from (rndInRoom/X/Y). A boss whose fight is several in a row (rndBossChainN: Ridley's three) starts with the first:
//the others follow it (rndBossNextLink), and a try given up starts again from it
var s,b;
s=argument0
b=global.rndBRFight[s]
global.rndFightSlot=s
global.rndFight=b
global.rndBossSeen=rndSetChar(global.rndBossSeen,s+1,"1") //(its fight seen: its preview shows the boss from now on)
global.rndFightLink=0
global.rndFightRetRoom=argument1
global.rndFightRetX=argument2
global.rndFightRetY=argument3
if b!=s and argument2<0
{
  //(the fight is in another room: won, the player comes back to where this boss's fight starts)
  if global.rndBossOnEntry[s]=0 {global.rndFightRetX=global.rndBossFX[s]; global.rndFightRetY=global.rndBossFY[s]}
  else {global.rndFightRetX=global.rndInX; global.rndFightRetY=global.rndInY}
}
global.rndFightLastX=global.rndBossX[b]
global.rndFightLastY=global.rndBossY[b]
global.rndFightLoseRoom=global.rndInRoom
global.rndFightLoseX=global.rndInX
global.rndFightLoseY=global.rndInY
global.bBossResultShow=0
rndBossSetup(global.rndBossType[b])
global.rndAbilHeldRoom=-1 //(the setup's abilSetRemove(1) isn't the room's: the roomStart hook)
global.bBossGallery=1
//the player's life and ammo now, which the boss room's code puts back as the fight starts (storeStatus(1)), the way the
//story keeps them before its fights
if instance_exists(oPlayer1) {storeStatus(0)}
global.bCanSave=0
global.rmDeaths=0
global.hitsTaken=0
global.levelTimeSecond=0
rndAbilApply()
