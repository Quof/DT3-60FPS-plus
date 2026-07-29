#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-15,-4,15,-1)
global.recAtkNum+=1

lifeTime=75


_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  yVel+=0.2*DeltaTime

  if isCollisionBottom(1) {yVel=0}
  if isCollisionSolid() {y-=2}

  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

  lifeTime-=1*gDeltaTime
  if lifeTime mod 3=0
  {
    instance_create(x+random_range(-2,2),y-18,oJCGameSBomb)
  }

  if lifeTime=0 //explode
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMissExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
