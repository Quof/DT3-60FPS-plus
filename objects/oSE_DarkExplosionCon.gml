#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
explodeNum=2
explodeDelay=10
xPlace=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  explodeDelay+=1
  if explodeDelay>=7
  {
    explodeNum-=1
    explodeDelay=0
    var tFire;
    for(i=0;i<2;i+=1)
    {
      tFire=instance_create(x-xPlace,y+8,oDamageExplosion)
      tFire.sprite_index=sBTFirePillar; tFire.image_yscale=1; tFire.image_blend=c_purple
      tFire.atkPower=atkPower; tFire.damageType="EXPLOSION"; tFire.decayTime=15
      tFire=instance_create(x+xPlace,y+8,oDamageExplosion)
      tFire.sprite_index=sBTFirePillar; tFire.image_yscale=1; tFire.image_blend=c_purple
      tFire.atkPower=atkPower; tFire.damageType="EXPLOSION"; tFire.decayTime=15
    }
    xPlace+=16
  }

  if explodeNum<=0 {instance_destroy()}
}
