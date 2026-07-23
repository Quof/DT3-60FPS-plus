#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanDealDamage=false

//Enemy base statistics
eName="Chain"
eLevel=20
maxLife=10000
life=maxLife
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
bDestroyMe=0

jeremyText=""
chaoText=""
devText="No Dev Commentary at this time."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bDestroyMe=1
  {
    for(i=0;i<12;i+=1)
    {
      tEffect=instance_create(x+(random(48)*image_xscale),y-random(48),oEffectB)
      tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
      tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    instance_destroy()
  }
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
oHex_First_Main.dmgCount+=tDmgA-tDmgB
life=maxLife
