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
//60fps change (added): _speed/_direction/_hspeed/_vspeed stand in for GameMaker's built-in speed/direction/hspeed/
//vspeed, which every instance has from the start (0 until it's set). An attack that reads one before setting it (Arthur's
//first lightning bolt in the War Room, the Dragoon ship's homing needle) crashed with "Unknown variable"; they start at 0,
//as the built-ins did (oDamagableBase's Create does the same; the creator's values, set after this, still apply)
if !variable_local_exists("_speed") {_speed=0}
if !variable_local_exists("_direction") {_direction=0}
if !variable_local_exists("_hspeed") {_hspeed=0}
if !variable_local_exists("_vspeed") {_vspeed=0}
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
      atkIdTime[i]+=1*gDeltaTime
      if atkIdTime[i]>=weaponRehitTime
        atkId[i]=0
    }
  }
}
