#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bShowHealthBar=false
bCanTakeDamage=false
bCanDealDamage=false
image_alpha=0
hoverAlpha=-1

//Enemy base statistics
eName="Spin Guard Shield"
maxLife=100
life=maxLife
atkPower=6
for(i=0;i<6;i+=1)
{
  resType[i]=1
}

jeremyText="The Spin Guard's shields. They are invulnerable to everything and just get in the way."
chaoText="What else can really be said for these?"
devText="Development for DT1 started around February 2009 and the first full release was in November 2010. During that time, I had moved to California from Austin, Texas for a few months. After some shenanegans there, I moved back to Austin, which is where I am at the moment of typing this message... (February 14, 2012)"
extraInfo="Immune to damage."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  enemyStepEvent()
}
