#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
bActive=true

//Enemy base statistics
eName="Barba Body"
maxLife=100
life=maxLife
atkPower=6
affiliation=2
bNoBonus=true

jeremyText="Just one of Barba's many body segments. They look to be moving in a nice little sine wave."
chaoText="What? I don't have commentary for every little thing. Leave me alone!"
devText="You're either testing to see what's all scannable or you clicked on this by mistake... That or you thought that this would count as the main scan. DT3 will sometimes give different results if you scan other parts of an enemy's body. This also goes for non-bosses as well."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=sin(oGame.time/2.5+waveOffset)
  image_xscale=oBarba.image_xscale
  image_blend=oBarba.image_blend
}
