#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
gunAngle=270
image_xscale=0.1; image_yscale=0.1
bCanDealDamage=0; bCanTakeDamage=0

//Enemy base statistics
eName="Targeting War Turret"
eLevel=38
maxLife=500
life=maxLife
pointWorth=60
atkPower=11
resType[1]=2
resType[2]=4
resType[3]=2
resType[4]=4
stunResist=50
baseItemChance=65
baseDropIndex=85
moneyWorth=10
affiliation=7
dieEffect=0

AIprog=0
shotTime=20
shotDelay=40
bulletSpd=8

initAtk=0

jeremyText="Do you remember the Facility Turrets that could track you? These are pretty much those, but with some enhancements. A larger, faster laser, and a higher fire rate. They're more durable and they don't have the design restriction of only being able to attach to a ceiling."
chaoText="This all looks like it comes from a Sonic game, but maybe it wasn't an official one. The turret itself is made from parts of the ship itself."
devText="I have a thing for villains residing in giant space ships. Of course, I didn't want that specifically for DT3, so a giant flying ship works just the same for me in this case."
extraInfo="Leads targets."

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and life>0
  {
    if initAtk=0 //Set new activate distance
    {
      detectDistX=264
      inactiveDist=128
      initAtk=1
    }

    if AIprog=0
    {
      image_xscale+=0.1; image_yscale+=0.1
      if image_xscale>=1
      {
        bCanTakeDamage=1
        AIprog=1
      }
    }
    else if AIprog=1
    {
      gunAngle=intercept_course_player(x,y,bulletSpd)
      shotTime+=1
      if shotTime=shotDelay-10 //Warning
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=0.85; tEffect.image_yscale=0.85
      }
      else if shotTime>=shotDelay //Shoot laser
      {
        playSound(global.snd_Wave,0,0.92,36000)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=bulletSpd
        tNewAttack.decayTime=-100; tNewAttack.direction=gunAngle; tNewAttack.image_angle=gunAngle
        shotTime=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      for(i=0;i<3;i+=1)
      {
        tEffect=instance_create(x+random_range(-6,6),y+random_range(-6,6),oEffect)
        tEffect.sprite_index=sEfFacLasTurExp; tEffect.image_speed=0.5; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sWS_TargetingTurret,image_index,x,y,image_xscale,image_yscale,gunAngle,image_blend,image_alpha)
