//Randomizer: a boss's fight starts. The boss gallery's setup for the boss's type (oBossGalleryDoor's user event 0: its
//currentBoss and bossTrack, for the boss room's code to make the boss) with the player's own abilities, all on
//(rndAbilApply), and the gallery's flag on, so the boss, beaten, goes to the gallery, where rndBossEnd takes over (the
//gallery's timer isn't shown in these fights: the mod's oHUD). argument0: the boss; argument1: the room the player goes
//to after the fight is won, argument2, argument3: where in it (argument2 -1: where they were when the boss was beaten).
//Lost or given up, they go back to where they came into the room they went into the fight from (rndInRoom/X/Y)
var d;
global.rndFight=argument0
global.rndFightRetRoom=argument1
global.rndFightRetX=argument2
global.rndFightRetY=argument3
global.rndFightLastX=global.rndBossX[argument0]
global.rndFightLastY=global.rndBossY[argument0]
global.rndFightLoseRoom=global.rndInRoom
global.rndFightLoseX=global.rndInX
global.rndFightLoseY=global.rndInY
global.bBossResultShow=0
d=instance_create(0,0,oBossGalleryDoor)
d.type=global.rndBossType[argument0]
with (d) {event_user(0)}
with (d) {instance_destroy()}
global.bBossGallery=1
//the player's life and ammo now, which the boss room's code puts back as the fight starts (storeStatus(1)), the way the
//story keeps them before its fights
if instance_exists(oPlayer1) {storeStatus(0)}
global.bCanSave=0
global.rmDeaths=0
global.hitsTaken=0
global.levelTimeSecond=0
rndAbilApply()
