#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCanDealDamage=true
damageType="NORMAL"

maxAtkId=0
atkId=0
atkIdTime=0
stunTime=1
bCanHitSwitch=1
bCanPierce=0
weaponRehitTime=20
initFireDir=oPlayer1.image_xscale
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  for(i=0;i<maxAtkId;i+=1)
  {
    if atkId[i]!=0
    {
      atkIdTime[i]+=1
      if atkIdTime[i]>=weaponRehitTime
        atkId[i]=0
    }
  }
}
