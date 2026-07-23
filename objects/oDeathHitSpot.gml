#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Death"
eLevel=12
maxLife=6400
life=maxLife
atkPower=5
resType[4]=2
stunResist=50
affiliation=3
bIsBoss=true
bNoBonus=true
image_xscale=18
image_yscale=38
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oDeath.image_xscale=1
  {
    x=oDeath.x-5
    y=oDeath.y-40
  }
  else
  {
    x=oDeath.x-13
    y=oDeath.y-40
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.weaponTag=31
{
  oDeath.hitKnife+=1
  if oDeath.hitKnife=4
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=1; tAtkShield.atkUp=1
    resType[1]-=1
    oDeath.resType[1]-=1
  }
  else if oDeath.hitKnife=8
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=1; tAtkShield.atkUp=1
    resType[1]-=1
    oDeath.resType[1]-=1
  }
}
else if other.weaponTag=32
{
  oDeath.hitWater+=1
  if oDeath.hitWater=2
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=2; tAtkShield.atkUp=1
    resType[2]-=1
    oDeath.resType[2]-=1
  }
  else if oDeath.hitWater=4
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=oDeath.id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-24; tAtkShield.atkType=2; tAtkShield.atkUp=1
    resType[2]-=1
    oDeath.resType[2]-=1
  }
}
