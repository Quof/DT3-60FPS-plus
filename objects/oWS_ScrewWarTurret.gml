#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=0

//Enemy base statistics
eName="Screw War Turret"
eLevel=38
maxLife=660
life=maxLife
pointWorth=65
atkPower=11
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=50
baseItemChance=65
baseDropIndex=85
moneyWorth=10
affiliation=7
dieEffect=0

shotTime=35
shotDelay=55
bulletSpd=8

initAtk=0

jeremyText="This stationary turret fires a large blast of energy in the direction it is facing. It also fires a standard bullet in your direction at the same time. Yeah it's weird."
chaoText="This is another turret made with parts of the ship itself. This one can be confusing at first due to it looking like it isn't inanimate. Also these are always attached to a screw. That screw is left behind after it's destroyed and can deal damage, watch out!"
devText="When I was first thinking about the warship and some of its elements, I knew I wanted the enemies (the new ones anyway) to look like they were part of the ship, as if the ship itself is out to get the protagonists."

deathAnim=0

myCollision=instance_create(x-16,y,oInvisibleSolid)
myCollision.image_xscale=2
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

    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    shotTime+=1
    if shotTime>=shotDelay //Shoot laser
    {
      playSound(global.snd_Wave,0,0.95,19000)
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(x+(40*image_xscale)+random_range(-6,6),y+8+random_range(-4,4),oEffect)
        tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.25+random(0.25)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1,1); tEffect.ySpd=random_range(-1,1)
      }
      var tNewAttack;
      tNewAttack=instance_create(x+(44*image_xscale),y+8,oScrewTurretShot)
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=9
      if image_xscale=-1 {tNewAttack.direction=180}
      tNewAttack=instance_create(x+(44*image_xscale),y+8,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(44*image_xscale),y+8,oPlayer1.x,returnPlayerYCenter())
      shotTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(x+random(32),y+random(12),oEffect)
        tEffect.sprite_index=sEfFacLasTurExp; tEffect.image_speed=0.5; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      with myCollision {instance_destroy()}
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
if shotTime>=shotDelay-15
{
  draw_sprite_ext(sMMcharging,shotTime,x,y+8,1,1,0,c_white,image_alpha)
}
