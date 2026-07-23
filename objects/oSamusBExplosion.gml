#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.75
damageType="EXPLOSION"
weaponTag=42
atkLv=global.stSamus_Bomb[0]
atkPower=75+round(global.stSamus_Bomb[0]*2)+global.skillTree[13]
atkPower=weaponDmgMod(1,atkPower)
stunTime=13+round(global.stSamus_Bomb[0]/2)
bCanPierce=1
bCanBoost=1
image_xscale=1+(global.metBombUpgrade*0.07)
image_yscale=1+(global.metBombUpgrade*0.07)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
The bomb will not boost the player that much while they are in the air if they have not been boosted by another bomb 1 second prior.
This keeps the player from getting to places they shouldn't be able to by placing a bomb in the air and jumping to it.
*/
if oPlayer1.attackState=oPlayer1.ACT_MORPHBALL and bCanBoost=1
{
  if oPlayer1.y-12<y
  {
    if oPlayer1.x>x
    {
      oPlayer1.xAcc=(point_distance(x,0,oPlayer1.x,0)/5)
    }
    else if oPlayer1.x<x
    {
      oPlayer1.xAcc=-(point_distance(x,0,oPlayer1.x,0)/5)
    }
    with oPlayer1
    {
      if platformCharacterIs(ON_GROUND) {y-=1}
      if global.location=49
      {
        if isCollisionWaterTop(4)
        {
          if global.gameProgress<2820 {yVel=-4}
          else {yVel=-9.5}
        }
        else {yVel=-9.5}
      }
      else
      {
        if isCollisionWaterTop(4) {yVel=-4}
        else {yVel=-9.5}
      }
      if platformCharacterIs(IN_AIR)
      {
        yVel=-4.5
      }
    }
    bCanBoost=0
  }
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
