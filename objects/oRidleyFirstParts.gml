#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
image_speed=0
myAnim=0
animSpd=1

//Enemy base statistics
eName="Ridley"
eLevel=20
maxLife=10000
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0

tailType=1
tailWave=0
tailAngle=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myAnim+=animSpd
if type=0 //----- Head -----
{
  x=myOwner.x+(1*image_xscale)
  y=myOwner.y+3
}
else if type=1 //----- Wings -----
{
  if myAnim>=1 and myAnim<=3 {image_index=1}
  else if myAnim>=4 and myAnim<=6 {image_index=2}
  else if myAnim>=7 and myAnim<=9 {image_index=3}
  else if myAnim>=10 and myAnim<=12 {image_index=4}
  else if myAnim>=13 and myAnim<=15 {image_index=3}
  else if myAnim>=16 and myAnim<=18 {image_index=2}
  else if myAnim>=19 and myAnim<=21 {image_index=1}
  else if myAnim>=24 {image_index=0; myAnim=0}

  x=myOwner.x-(21*image_xscale)
  y=myOwner.y+6
}
else if type=2 //----- Arms -----
{
  if myAnim=6 {image_index=1}
  else if myAnim=12 {image_index=2}
  else if myAnim=18 {image_index=1}
  else if myAnim=24 {image_index=0; myAnim=0}

  x=myOwner.x-(36*image_xscale)
  y=myOwner.y+34
}
else if type=3 //----- Tail -----
{
  if tailType=0 //Stationary
  {
    x=myOwner.x-(43*image_xscale)-((tailSeg*8)*image_xscale)
    y=myOwner.y+29+(tailSeg*2)
  }
  else if tailType=1 //Normal wave
  {
    x=myOwner.x-(43*image_xscale)-((tailSeg*8)*image_xscale)
    tailWave+=0.25
    y=myOwner.y+29+(tailSeg*2)+sin(tailWave+(tailSeg*5))
    if sprite_index=sRidleyTailEnd {image_angle=180}
  }
  else if tailType=2 //Point down
  {
    x=myOwner.x-(43*image_xscale)
    y=myOwner.y+29+(tailSeg*10)
    if sprite_index=sRidleyTailEnd {image_angle=270}
  }
  else if tailType=3 //Spin
  {
    tailAngle+=25
    x=myOwner.x-(43*image_xscale)+lengthdir_x(((tailSeg*9)*image_xscale),tailAngle)
    y=myOwner.y+29+lengthdir_y(tailSeg*9,tailAngle)
    if sprite_index=sRidleyTailEnd {image_angle=tailAngle}
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
