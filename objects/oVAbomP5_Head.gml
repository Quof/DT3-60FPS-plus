#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
bCanTakeDamage=false
image_xscale=0; image_yscale=0

//Enemy base statistics
eName="Abomination"
if global.modeWahfuu=1 {eName="Wahfuu"}
eLevel=20
maxLife=100000
life=maxLife
atkPower=20
affiliation=9
stunResist=50
bIsBoss=true
bNoBonus=true
jawAngle=0
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sAbomAlienJaw,0,x-(76*image_xscale),y-(70*image_yscale),image_xscale,image_yscale,jawAngle,image_blend,image_alpha)
