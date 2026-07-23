/*
This is called after a boss fight.
It is used to clear any effects still on screen
and to set the player back to the normal state.
*/
with oEnemyBase
  instance_destroy()
with oEProjectileBase
  instance_destroy()
with oBossBarrier
  instance_destroy()
with oAttackBase
  instance_destroy()
stopPlayer()
oPlayer1.image_alpha=1
