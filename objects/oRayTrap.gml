#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bShowHealthBar=false

//Enemy base statistics
eName="Ray Trap"
eLevel=15
maxLife=100
life=maxLife
atkPower=5
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
affiliation=4
hitSound=global.snd_EnemyHitMM

checkArea=0
fireTime=0

jeremyText="This is always stationary, treat it like a trap. However, if you touch the lasers created by the sensors, all the Ray Traps close by will fire a very fast laser at you. Don't be fooled by the damage output above. That's simply contact damage, the laser has an output rating of 8."
chaoText="You could just dash your way through the problems these things give you.#... ... ...#What? I was trying to give useful advice!"
devText="Not to spoil anything, but this is an enemy type that will show up outside of this Gate. There's quite a few uses for such a thing."
extraInfo="Completely immune to damage."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if checkArea=1
  {
    if fireTime=0
    {
      if checkScreenArea(x,y,4)=1 {fireTime=50}
    }
    checkArea=0
  }

  if fireTime>0
  {
    fireTime-=1
    if fireTime mod 2=0 and fireTime>30
    {
      if image_blend=c_white {image_blend=c_silver}
      else {image_blend=c_white}
    }

    if fireTime=30 //Fire laser
    {
      playSound(global.snd_LaserA,0,1,1)
      image_blend=c_white
      var tNewAttack;
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sWalkBlasterLaser
      tNewAttack.atkPower=atkPower+3; tNewAttack.bulletSpeed=20; tNewAttack.decayTime=-100
      tNewAttack.direction=player_sprite_center()
      tNewAttack.image_xscale=1.5
    }
  }
  enemyStepEvent()
}
