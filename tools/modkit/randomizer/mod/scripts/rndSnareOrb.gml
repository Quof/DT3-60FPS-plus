//Randomizer: a Wind Orb Trap's orb (oRndSnareOrb: the Green Warmaster's seeker orb, which can't be destroyed), one in the
//room, at the top of the view on the side away from the player, so it has a way to come before it reaches them. Not in a
//boss fight or the boss gallery
var t,tX;
if !instance_exists(oPlayer1) or global.rndFight>=0 or global.bBossGallery=1 {exit}
if instance_exists(oRndSnareOrb) {exit}
if oPlayer1.x>view_xview[0]+view_wview[0]/2 {tX=view_xview[0]+24}
else {tX=view_xview[0]+view_wview[0]-24}
t=instance_create(tX,view_yview[0]+32,oRndSnareOrb)
