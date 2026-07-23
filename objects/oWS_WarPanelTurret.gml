#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=0; bCanTakeDamage=0
image_speed=0
image_index=4

//Enemy base statistics
eName="War Panel Turret"
eLevel=38
maxLife=280
life=maxLife
pointWorth=45
atkPower=11
resType[0]=1
resType[1]=2
resType[2]=2
stunResist=50
baseItemChance=35
baseDropIndex=90
moneyWorth=5
affiliation=7
dieEffect=0
detectDistX=156
detectDistY=112

AIprog=0
shotTime=20
shotDelay=50
bulletSpd=10
laserAmt=0

initAtk=0

jeremyText="The only way to foresee these are to have Chao hover over them, other wise, they'll rotate out when you get fairly close. The turret attempts to track you, but its barrel rotation isn't instant. When it does fire, which it does a lot, it fires out 5 laser in succession. However, it can't rotate while firing the lasers."
chaoText="Just another piece of the ship that looks like it's out to get you."
devText="One of the big differences between developing DT1 and DT3, was that with DT1 I wasn't as concerned with how people would receive it. With DT3, there was typically always that thought lingering, and it affected my work, in both good and bad ways I feel. Around Ch.17, I went closer to the mindset I had with DT1."

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
      image_index=0
      AIprog=1
    }
    else if AIprog=1
    {
      image_index+=0.15
      if image_index>=3
      {
        bCanTakeDamage=1
        direction=player_sprite_center()
        sprite_index=sWS_TurretPTurret
        detectDistX=264
        detectDistY=200
        AIprog=2
      }
    }
    else if AIprog=2
    {
      if laserAmt=0 {turn_toward_direction(player_sprite_center(),5)}
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
        playSound(global.snd_Wave,0,0.92,42000)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sLB_Laser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=bulletSpd
        tNewAttack.decayTime=-100; tNewAttack.direction=direction; tNewAttack.image_angle=direction; tNewAttack.image_xscale=0.35
        laserAmt+=1
        if laserAmt>=5
        {
          laserAmt=0
          shotTime=0
        }
        else {shotTime=shotDelay-3}
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
      instance_create(x,y,oDestroyedTurretPanel)
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
if AIprog=0 or AIprog=1 {event_inherited()}
else if AIprog=2
{
  draw_sprite(sWS_TurretPanel,3,x,y)
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,direction,image_blend,image_alpha)
}
