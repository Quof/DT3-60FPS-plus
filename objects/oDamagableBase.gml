#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bPlayable=false
charEnemyCreateEvent()
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true and global.gamePaused=false
{
  with other
    hitPlayer(other)
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTakingDamage=false and other.bCanDealDamage=true and bActive=true
{
  var tempCheck;
  tempCheck=0
  for(i=0;i<other.maxAtkId;i+=1)
  {
    if other.atkId[i]=id
      tempCheck=1
  }
  if tempCheck=0
  {
    if other.weaponTag=40 //Drop Samus charge shot damage by 1.25% till it gets down to 50%
    {
      if other.exPwr<1
      {
        if other.exPwr>0.5
        {
          other.exPwr-=0.0125
          other.atkPower=round(other.basePower*other.exPwr)
        }
      }
    }
    event_user(14) //Before damage (per enemy script)
    takeDamage(other)
    event_user(15) //After damage (per enemy script)
    other.atkId[other.maxAtkId]=id
    other.atkIdTime[other.maxAtkId]=0
    other.maxAtkId+=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if findTargetX<480 and findTargetY<352
  enemyDrawEvent()
