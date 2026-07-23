#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: xSpawn,ySpawn,objSpawn,moveSpd,turnDelay,turnAmt,myDir
spawnTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  spawnTime+=1
  if spawnTime=1
  {
    var tEffect;
    tEffect=instance_create(xSpawn,ySpawn,oEffect)
    tEffect.sprite_index=sEfEnergyRip; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    tEffect.image_alpha=0.75; tEffect.image_speed=0.15
  }
  else if spawnTime>=25
  {
    var tNewSpawn;
    tNewSpawn=instance_create(xSpawn,ySpawn,objSpawn)
    tNewSpawn.moveSpd=moveSpd
    tNewSpawn.turnDelay=turnDelay
    tNewSpawn.turnAmt=turnAmt
    tNewSpawn.direction=myDir
    instance_destroy()
  }
}
