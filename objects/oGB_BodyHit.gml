#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Used for taking damage for the stunned state
event_inherited()
bActive=1
bCanDealDamage=false
image_speed=0
image_xscale=-1

//Enemy base statistics
eName="Giant Blarg"
maxLife=10000
life=1000+oGiantBlarg.bodyLife
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[2]=3
stunResist=50
affiliation=1
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

jeremyText=""
chaoText=""
devText=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGiantBlarg.hitState=0
  {
    if life>1000
    {
      resType[2]=oGiantBlarg.resType[2]
      x=oGiantBlarg.x
      y=oGiantBlarg.y
      image_xscale=oGiantBlarg.image_xscale
    }
    else
    {
      resType[2]=1
      life=1000+oGiantBlarg.bodyLife
      baseColor=make_color_rgb(100,100,255)
      image_blend=baseColor
      oGiantBlarg.hitState=1
    }
  }
  enemyStepEvent()
}
