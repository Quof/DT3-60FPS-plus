#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2
bCanDealDamage=false
bActive=true

//Enemy base statistics
eName="Zebetite"
eLevel=24
maxLife=820
life=maxLife
pointWorth=10
resType[0]=2
resType[1]=1
resType[2]=1
resType[3]=1
resType[4]=1
resType[5]=4
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=0
dieEffect=0
bIsBoss=true
bNoBonus=true

jeremyText="This doesn't do anything other than be in the way. You'll need to blast them with missiles quickly, as it will regenerate any damage dealt to it, over time."
chaoText="These are a powerful source of energy for Mother Brain and have a regenerative ore-like material normally only found in Tourian."
devText="These went through a few iterations to find just the right HP and regeneration rate. Originally the regen rate was roughly 3x what it is now which, of course, was too much. The Beam and Bombs were originally able to damage them at half damage, but it felt weird and I wanted this encounter fairly close to the original."

myCollision=instance_create(x,y,oSolid)
myCollision.visible=0; myCollision.sprite_index=sZebetiteEnergy; myCollision.image_speed=0; myCollision.image_xscale=1.5

if global.gameProgress>=2970 and room=rSamus5_Lv4_Boss
{
  with myCollision {instance_destroy()}
  instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0 and bActive=1
  {
    if life<maxLife
    {
      life+=2
      if life>maxLife {life=maxLife}
    }
  }
  else if life<=0
  {
    playSound(global.snd_MetEnemyDieA,0,0.92,1)
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x,y-16+(i*16),oEffect)
      tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    with myCollision {instance_destroy()}
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
scaling=(life/maxLife)*2
draw_sprite_ext(sZebetiteEnergy,image_index,x,y,scaling,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sZebetiteGlass,0,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha)
