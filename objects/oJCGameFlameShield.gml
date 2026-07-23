#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="ELEMENTAL"
weaponTag=51
atkLv=global.stCGame_B[0]
atkPower=10+global.stCGame_B[0]+(global.stJGame_C[1]*2)
atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
stunTime=3
bCanHitSwitch=0
decayTime=900
shieldDist=16
bSplit=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sEfManaFire; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
tEffect.image_xscale=0.85; tEffect.image_yscale=0.85
tEffect.newBlend=1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if bSplit=0
  {
    if global.activeCharacter=0 {bSplit=1}
    image_angle=shieldDir-90
    if shieldDist<48 {shieldDist+=1}
    if abs(oPlayer1.xVel)<=3
    {
      if shieldDist>48 {shieldDist-=1}
    }
    else
    {
      if shieldDist<64 {shieldDist+=1}
    }

    shieldDir-=5
    x=oPlayer1.x+lengthdir_x(shieldDist,shieldDir)
    y=oPlayer1.y-26+lengthdir_y(shieldDist,shieldDir)
  }
  else
  {
    direction=image_angle
    speed=13
  }

  if checkScreenArea(x,y,48)=0 {instance_destroy()}

  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
else {speed=0}
