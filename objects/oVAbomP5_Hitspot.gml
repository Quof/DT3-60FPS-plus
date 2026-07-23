#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
bCanDealDamage=false
bCanTakeDamage=false

//Enemy base statistics
eName="Abomination"
eLevel=20
maxLife=100000
life=maxLife
atkPower=20
affiliation=9
stunResist=50
bIsBoss=true
bNoBonus=true
image_xscale=3
image_yscale=3.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
    if oVAbom_P5_Main.image_angle=90 {x=oVAbom_P5_Main.x+178}
    else {x=oVAbom_P5_Main.x-228}
    y=oVAbom_P5_Main.y-31

  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tDmgA,tDmgB;
tDmgA=life
event_inherited()
tDmgB=life
oVAbom_P5_Main.damageTakenSession+=tDmgA-tDmgB
oVAbom_P5_Main.damageTakenTotal+=tDmgA-tDmgB
