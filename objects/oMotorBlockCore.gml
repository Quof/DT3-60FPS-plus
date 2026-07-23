#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
flashFrm=0

//Enemy base statistics
eName="Motor Block Core"
maxLife=150
life=maxLife
atkPower=1
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  flashFrm+=0.33
  if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    instance_destroy()
  }

  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sMotorBlockCoreB,flashFrm,x-4,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
