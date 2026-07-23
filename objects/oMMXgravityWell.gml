#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-7,-7,7,7)
image_speed=0.4

damageType="SPECIAL"
weaponTag=12
atkLv=global.stMega_Gravity[0]
atkPower=45+round(global.stMega_Gravity[0]*1.5)+global.skillTree[10]
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_Gravity[2]+=1
stunTime=5
bCanPierce=1
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

bulletSpeed=4
lifeTime=50
gravityProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if gravityProg=0
  {
    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=2}
    else {bulletSpeed=4}

    speed=bulletSpeed
    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if isCollisionLeft(1) {gravityProg=1}
    if isCollisionRight(1) {gravityProg=1}
    if isCollisionBottom(1) {gravityProg=1}
    if isCollisionTop(1) {gravityProg=1}
    lifeTime-=1
    if lifeTime=0 {gravityProg=1}
  }
  else if gravityProg=1
  {
    speed=0
    sprite_index=sMMXgravityWell3
    image_alpha=0.75
    lifeTime=30
    gravityProg=2
  }
  else if gravityProg=2
  {
    if oGame.time mod 3=0 {image_angle=random(360)}
    lifeTime-=1
    if lifeTime=0 {instance_destroy()}
  }
}
else {speed=0}
#define Collision_oEnemyBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gravityProg=0 and other.bCanTakeDamage=true {gravityProg=1}

if gravityProg>=1 {event_inherited()}
