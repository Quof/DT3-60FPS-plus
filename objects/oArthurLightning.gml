#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="ELEMENTAL"
weaponTag=108
atkPower=250
stunTime=5
bCanPierce=1
lifeTime=50
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if type=0 //Lightning downward
  {
    if oGame.time mod 3=0
    {
      if image_xscale=1 {image_xscale=-1}
      else {image_xscale=1}
    }

    y+=6
    if y>=ownerID.y
    {
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_xscale=1.5+random(1.5); tEffect.image_yscale=1.5+random(1.5)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75+random(0.25)
        tEffect.direction=random_range(45,135); tEffect.speed=3+random(3)
      }
      ownerID.npcTime=1000
      var tAttack,tDir;
      tDir=50
      for(i=0;i<9;i+=1)
      {
        tAttack=instance_create(x,y,oArthurLightning)
        tAttack.type=1; tAttack.sprite_index=sZapTrap
        tAttack.direction=tDir; tAttack.image_angle=tDir; tAttack.moveSpd=8
        tDir+=10
      }
      instance_destroy()
    }
  }
  else if type=1 //Light balls outward
  {
    atkPower=125
    speed=moveSpd
    lifeTime-=1
    if lifeTime<=0 {instance_destroy()}
  }
}
else {speed=0}
