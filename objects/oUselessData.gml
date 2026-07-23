#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanDealDamage=false
if room=rDiscoF or room=rDiscoG
{
  image_xscale=1.5
  image_yscale=1.5
}

//Enemy base statistics
eName="Useless Data"
eLevel=1
maxLife=10
life=maxLife
pointWorth=1
atkPower=1
baseItemChance=10
moneyWorth=0

jeremyText="Looks like just a useless piece of data laying around. You could probably use it as a one time use Latch Crystal. Remember those?#... Huh, it also looks like standard programmer art."
chaoText="After looking through this thing's code, I've found that it's unfinished AI... or in this case, forgotten. There are no comments left to clue in on what it was supposed to do, but hey, it's nice cannon fodder. Should we think twice before destroying these?"
devText="Dopple 2.0."
extraInfo="Completely useless."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  enemyStepEvent()
}
#define Collision_oLinkSWave
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Do nothing
