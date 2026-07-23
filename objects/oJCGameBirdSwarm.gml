#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recAtkNum+=1
global.stJGame_B[2]+=1
lifeTime=50

newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=-28; newBird.pointY=-164; newBird.initSpd=11; newBird.myDir=-1
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=28; newBird.pointY=-164; newBird.initSpd=11; newBird.myDir=1
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=-62; newBird.pointY=-124; newBird.initSpd=10.5; newBird.myDir=-1
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=62; newBird.pointY=-124; newBird.initSpd=10.5; newBird.myDir=1
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=0; newBird.pointY=-104; newBird.initSpd=7; newBird.myDir=oPlayer1.image_xscale; newBird.sprite_index=sRedBirdFly
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=-62; newBird.pointY=-84; newBird.initSpd=6.5; newBird.myDir=-1
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=62; newBird.pointY=-84; newBird.initSpd=6.5; newBird.myDir=1
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=-28; newBird.pointY=-44; newBird.initSpd=5; newBird.myDir=-1
newBird=instance_create(oPlayer1.x,oPlayer1.y-26,oJCGameBird); newBird.pointX=28; newBird.pointY=-44; newBird.initSpd=5; newBird.myDir=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  lifeTime-=1
  if lifeTime=0 {instance_destroy()}
}
