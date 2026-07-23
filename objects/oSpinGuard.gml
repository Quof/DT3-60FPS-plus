#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-14,14,14)
bCanTakeDamage=false
bCanDealDamage=false
image_alpha=0

//Enemy base statistics
eName="Spin Guard"
eLevel=11
maxLife=390
life=maxLife
pointWorth=16
atkPower=5
resType[1]=4
resType[2]=1
resType[4]=4
resType[5]=2
stunResist=2
baseItemChance=60
baseDropIndex=90
moneyWorth=5
dieSound=0
dieEffect=0
runAcc=1
inactiveDist*=1.25

initSeq=0
shotTime=50
shotDelay=130

deathAnim=0

jeremyText="A troublesome bot with two shields that spin around it. They wouldn't be much of an issue, but making contact with them will hurt you. If you do decide to go close, be quick with it."
chaoText="I think Jeremy is tired or... wait, we can't get tired in this world. Anyway, these will sometimes spin fast, which indicates they are about to fire. Something in the behavior indicates that their shot will bounce, but it isn't in this version of them. Looks like it was commented out since it wasn't finished."
devText="Enemy types like this that are just a bit different with multiple moving parts, no matter how simple the movement may be, is something I should have done more with the earlier games. I think the reason there wasn't much variation in enemy AI was a combination of not being as skilled then and not being very confident in my own abilities."

shieldDir=90
shieldDist=240
for(i=0;i<2;i+=1)
{
  shieldPart[i]=instance_create(x,y,oSpinGuardShield)
  shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*180))
  shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*180))
  shdVelX[i]=random_range(-2,2)
  shdVelY[i]=-3-random(2)
  shdVelTurn[i]=random_range(-5,5)
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  if instance_exists(shieldPart[i])
  {
    with shieldPart[i] {instance_destroy()}
  }
}
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
    initSeq+=1
    if initSeq>=1 and initSeq<=99
    {
      image_alpha+=0.025
      for(i=0;i<2;i+=1)
      {
        shieldPart[i].image_alpha+=0.025
      }
      shieldDist-=8
      if shieldDist<=40
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        for(i=0;i<2;i+=1)
        {
          if instance_exists(shieldPart[i])
          {
            shieldPart[i].image_alpha=1
            shieldPart[i].bCanTakeDamage=true
            shieldPart[i].bCanDealDamage=true
          }
        }
        image_alpha=1
        bCanDealDamage=true
        bCanTakeDamage=true
        initSeq=100
      }
    }
    else if initSeq>=110
    {
      shieldDir-=6
      mDir=player_sprite_center()
      moveTo((runAcc)*cos(degtorad(mDir)),-(runAcc)*sin(degtorad(mDir)))
    }

    for(i=0;i<2;i+=1)
    {
      if instance_exists(shieldPart[i])
      {
        shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*180))
        shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*180))
        shieldPart[i].image_angle=shieldDir+(i*180)
      }
    }

    //---------- ATTACK: Shot ----------
    shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime>=shotDelay and shotTime<=shotDelay+29 //spin
      {
        image_angle-=20
      }
      else if shotTime=shotDelay+30 //Fire shot
      {
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sEBShot; tNewAttack.atkPower=atkPower
        tNewAttack.bulletSpeed=6; tNewAttack.decayTime=-100; tNewAttack.direction=mDir
        image_angle=0
        shotTime=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      for(i=0;i<2;i+=1)
      {
        shieldPart[i].bCanDealDamage=false
        shieldPart[i].bCanTakeDamage=false
      }
      playSound(global.snd_BombExplode,0,0.9,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.image_xscale=0.4; tEffect.image_yscale=0.4; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    y+=0.5
    for(i=0;i<2;i+=1)
    {
      if instance_exists(shieldPart[i])
      {
        shieldPart[i].x+=shdVelX[i]
        shieldPart[i].y+=shdVelY[i]
        shdVelY[i]+=0.3
        shieldPart[i].image_angle+=shdVelTurn[i]
      }
    }
    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
