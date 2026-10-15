//Randomizer: a fight of a boss whose fight is several in a row (rndBossChain*: Ridley, Ridley (Lava), the tunnel chase,
//as the story has them) won, and not the last of them (rndBossEnd: the game has gone back to the boss gallery): the
//next one starts, as rndBossStart starts a fight. The boss gallery's setup for its type (oBossGalleryDoor's user event
//0: its currentBoss and bossTrack, for its room's code), the player's own abilities (rndAbilApply), and the life and
//ammo they won the last one with (rndChainSt: oRndWatcher keeps them during the fight, the gallery has refilled them
//since), which its room's code puts back as it starts (storeStatus(1)), so Retry starts it again with them. The fight
//and the place are still rndFight and rndFightSlot; rndFightLink counts the fights done
var b,k,d,i;
b=global.rndFight
k=global.rndFightLink
global.rndFightLink=k+1
global.bBossResultShow=0
d=instance_create(0,0,oBossGalleryDoor)
d.type=global.rndBossChainType[b,k]
with (d) {event_user(0)}
with (d) {instance_destroy()}
global.rndAbilHeldRoom=-1 //(the setup's abilSetRemove(1) isn't the room's: the roomStart hook)
global.bBossGallery=1
for(i=0;i<5;i+=1) {global.pStatusStore[i]=global.rndChainSt[i]}
global.bCanSave=0
global.rmDeaths=0
global.hitsTaken=0
global.levelTimeSecond=0
rndAbilApply()
transition_kind=0
global.newMapX=global.rndBossChainX[b,k]
global.newMapY=global.rndBossChainY[b,k]
room_goto(global.rndBossChainRoom[b,k])
