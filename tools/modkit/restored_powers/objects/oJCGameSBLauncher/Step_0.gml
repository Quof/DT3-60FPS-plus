event_inherited()
if global.gamePaused=false
{
  //yVel+=0.2*DeltaTime
  yVel=scrGravAcc(yVel,0.2,1) //60fps change: typo fix (DeltaTime is not a variable, so this line errored); accelerates then moves, see scrGravAcc

  //if isCollisionBottom(1) {yVel=0}
  if isCollisionBottom(1) {yVel=0; xVel=0} //restored game powers change: it stops where it lands (thrown with xVel, which nothing slowed)
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
