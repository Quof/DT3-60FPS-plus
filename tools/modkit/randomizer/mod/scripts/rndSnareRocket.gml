//Randomizer: a Rocketeer Trap's CHAOS Rocketeer, at the top of the view on one side or the other: it flies to the player
//and keeps by them, shooting (oCHAOS_Rocketeer). One an enemy spawner might have made (bGenEnemy: AP from only so many
//of those). Not in a boss fight or the boss gallery
var t,tX;
if !instance_exists(oPlayer1) or global.rndFight>=0 or global.bBossGallery=1 {exit}
if irandom(1)=0 {tX=view_xview[0]+16}
else {tX=view_xview[0]+view_wview[0]-16}
t=instance_create(tX,view_yview[0]+24,oCHAOS_Rocketeer)
t.bGenEnemy=1
