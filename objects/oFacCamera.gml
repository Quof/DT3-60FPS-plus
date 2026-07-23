#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
image_speed=0
bInfected=0

//Enemy base statistics
eName="Facility Camera"
eLevel=31
maxLife=550
life=maxLife
pointWorth=47
atkPower=9
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=15
baseItemChance=65
baseDropIndex=90
moneyWorth=5
dieEffect=0

shotTime=30
shotDelay=45
triShot=1

bIsBoss=1
chaoText="At least when it's infected, you can destroy them... Because they're creepy."
devText="The big idea of this level wasn't just the enemies getting infected, but also having the Virus being able to change parts of the environment."
extraInfo="Can close security doors."

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
    myDist=point_distance(x,0,oPlayer1.x,0)
    if x<oPlayer1.x
    {
      if myDist<=40 {image_index=0}
      else {image_index=1}
      image_xscale=1
    }
    else
    {
      if myDist<=40 {image_xscale=1; image_index=0}
      else {image_xscale=-1; image_index=1}
    }

    if bInfected=1
    {
      shotTime+=1
      if shotTime>=shotDelay
      {
        tEffect=instance_create(x,y+60,oEffect)
        tEffect.sprite_index=sEfCamMuzzleFlash; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        if image_index=1
        {
          if image_xscale=1 {tEffect.image_angle=45}
          else {tEffect.image_angle=315}
        }
        var tNewAttack,tDir;
        tDir=point_direction(x,y+60,oPlayer1.x,oPlayer1.y-26)
        if triShot=3 {tDir-=15}
        for(i=0;i<triShot;i+=1)
        {
          tNewAttack=instance_create(x,y+60,oPassBulletRed)
          tNewAttack.sprite_index=sCamBullet; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.decayTime=-100; tNewAttack.direction=tDir
          tDir+=15
        }
        if triShot=1 {triShot=3}
        else {triShot=1}
        shotTime=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with controlID {instance_destroy()}
      tEffect=instance_create(x,y+60,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      image_xscale=1; image_index=2; image_blend=c_white
      bIsBoss=1
      jeremyText=""
      bCanDealDamage=false; bCanTakeDamage=false
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
jeremyText="All it does is fire a few undashable shots in your direction. The big thing to note about these is that some of them will close nearby doors on you when they're infected. Luckily opening the door is as easy as destroying the camera."
bCanTakeDamage=true
baseColor=make_color_rgb(180,255,180)
image_blend=baseColor
bActive=1
bInfected=1
if controlID!=-1 //Close door
{
  if instance_exists(controlID)
  {
    if controlID.progCheck=0 {controlID.progCheck=1}
  }
}
