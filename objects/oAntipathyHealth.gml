#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false; bCanTakeDamage=false
bShowHealthBar=true
showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0

//Enemy base statistics
eName="None"
eLevel=12
maxLife=10500
life=maxLife
bIsBoss=true
bNoBonus=true
bossProgress=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  life=(oAntiAlpha.life+oAntiBeta.life)-29500
  lifePercent=life/maxLife
  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
  {
    oAntiAlpha.waitDelay-=6
    oAntiBeta.waitDelay-=6
    bossProgress+=1
  }
  else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
  {
    oAntiAlpha.waitDelay-=6
    oAntiBeta.waitDelay-=6
    oAntiBeta.shockMax+=1
    bossProgress+=1
  }
  else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
  {
    oAntiAlpha.waitDelay-=6
    oAntiBeta.waitDelay-=6
    oAntiBeta.shockMax+=1
    bossProgress+=1
  }
  else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=3
  {
    oAntiAlpha.waitDelay-=4
    oAntiBeta.waitDelay-=4
    oAntiAlpha.atkMax+=1
    oAntiBeta.atkMax+=1
    bossProgress+=1
  }

  if life<=0
  {
    if global.bBossGallery=1
    {
      bossRoomTally(47)
      global.newMapX=1592; global.newMapY=464; room_goto(rBossGallery)
    }
    else
    {
      oAntiAlpha.life=0; oAntiBeta.life=0
      oAntiAlpha.bCanDealDamage=0; oAntiBeta.bCanDealDamage=0
    }
  }
}
