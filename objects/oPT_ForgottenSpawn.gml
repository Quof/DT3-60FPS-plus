#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_speed=0.25
image_angle=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)

//Enemy base statistics
eName="A Forgotten Spawn"
eLevel=28
maxLife=220
life=maxLife
pointWorth=5
atkPower=7
affiliation=6
dieEffect=0
bCanBeBlocked=1
bParryOpp=1
blockCost=40

moveSpd=5.5
diff=100

deathAnim=0

jeremyText="These seek you out very similar to the homing missiles you've come across in the past, and that's it. Their level scales with yours, which is about the only notable thing about them. Their stat scaling isn't too great though."
chaoText="These are also from 'Beyond Oasis'."
devText="While this wasn't in the screenshot with the Unforgotten way back in the day. What idea I did have, it involved spawning minions to do most of the work for it. Maybe 'A Forgotten Spawn' isn't the most appropriate name..."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
rpgLv=global.stJGame_C[1]

eName=string("Lv.") +string(rpgLv) +string(" A Forgotten Spawn")
pointWorth=5+round(rpgLv/12)
if rpgLv<=9
{
  expValue=10+rpgLv
  maxLife=220+round(rpgLv*1.75)
}
else if rpgLv>=10 and rpgLv<=24
{
  expValue=15+round(rpgLv*1.25)
  maxLife=240+round(rpgLv*2.5)
}
else if rpgLv>=25 and rpgLv<=49
{
  expValue=20+round(rpgLv*2)
  maxLife=260+round(rpgLv*3.25)
}
else if rpgLv>=50
{
  expValue=30+round(rpgLv*3)
  maxLife=300+round(rpgLv*4.75)
}
life=maxLife
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=moveSpd
  image_angle=direction
  if bActive=true and life>0
  {
    diff=angle_difference(image_angle,player_sprite_center())
    if diff<18 and diff>-18
    {
      if moveSpd<2 {moveSpd+=0.1}
      else if moveSpd>2 {moveSpd-=0.1}
    }
    else
    {
      if moveSpd>1 {moveSpd-=0.1}
    }
    turn_toward_direction(player_sprite_center(),3)
  }
  else if life<=0
  {
    deathAnim+=1
    speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-13,13),y+random_range(-13,13),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {speed=0}
