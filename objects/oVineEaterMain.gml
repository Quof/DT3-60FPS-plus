#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.15

//Enemy base statistics
eName="Vine Eater"
eLevel=34
maxLife=410
life=maxLife
pointWorth=65
atkPower=9
stunResist=10
baseItemChance=60
moneyWorth=5
dieSound=0
dieEffect=0
inactiveDist*=1.75

jeremyText="These are usually not too much of a threat. The only place you can deal damage to one is its mouth, but its body segments can still deal damage to you. It just swings toward you, so not too much else to say about it."
chaoText="These things borrow the behavior from those swinging chains that don't always have just a chain. Speaking of a chain, hmm... I wonder if..."
devText="These are one of those enemies that were designed to not be all that threatening in most scenarios. They do have some nifty uses for design though."

deathAnim=0

myGrapplePoint=instance_create(x,y,oStrikeChainPoint)
myGrapplePoint.visible=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with myGrapplePoint {instance_destroy()}
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
    myAngle=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    image_angle=myAngle

    myGrapplePoint.x=x
    myGrapplePoint.y=y
    /*if myGrapplePoint.bGrappled=0
    {
      baseColor=c_white
      bCanDealDamage=true
      if image_blend=c_fuchsia {image_blend=baseColor}
    }
    else
    {
      baseColor=c_fuchsia
      image_blend=baseColor
      bCanDealDamage=false
    }*/
  }
  else if life<=0
  {
    if deathAnim=0
    {
      ownerID.destroyCheck=1
      deathAnim=1
    }
  }
  enemyStepEvent()
}
