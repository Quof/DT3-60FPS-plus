#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
bInfected=0
gunAngle=270

//Enemy base statistics
eName="Facility Laser Turret"
eLevel=30
maxLife=180
life=maxLife
pointWorth=20
atkPower=8
resType[0]=2
resType[1]=1
stunResist=2
baseItemChance=30
baseDropIndex=90
dieEffect=0

shotTime=30
shotDelay=50
bulletSpd=7

bIsBoss=1
chaoText="I didn't think you guys would have to go up against things that can lead its target. What I don't like is how the cannon tricks you on where it's going to fire."
devText="I found that an enemy that can lead its targets isn't too much of a threat on its own. However when mixed up with enemies that either don't at all, or will fire at the player if its buddy is leading, it creates trickier scenarios. These aren't the only things that will be able to lead."
extraInfo="Leads targets."

deathAnim=0

myInfectSpot=instance_create(x,y,oInfectMe)
myInfectSpot.myOwner=id
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if bInfected=1
    {
      gunAngle=intercept_course_player(x,y,bulletSpd)
      shotTime+=1
      if shotTime=shotDelay-10 //Warning
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      }
      else if shotTime>=shotDelay //Shoot laser
      {
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=bulletSpd
        tNewAttack.decayTime=-100; tNewAttack.direction=gunAngle; tNewAttack.image_xscale=0.5
        shotTime=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sEfFacLasTurExp; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(myInfectSpot)
{
  with myInfectSpot {instance_destroy()}
}
bIsBoss=0
jeremyText="These have low durability, a decent fire rate and power output. Pretty unremarkable in that regard. What makes them interesting is their targeting system. They're able to predict where you're going to be and will fire there instead of at you. I have noticed a small degree of error and there seems to be ways of consistently triggering that error, but I don't know what it is. Just know that keeping on a predictable path will hurt you against these."
bCanTakeDamage=true
baseColor=make_color_rgb(180,255,180)
image_blend=baseColor
bActive=1
bInfected=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sFacilityTurretBarrel,image_index,x,y,image_xscale,image_yscale,gunAngle,image_blend,image_alpha)
event_inherited()

/*draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_middle)
draw_text(x,y+36,gunAngle)
