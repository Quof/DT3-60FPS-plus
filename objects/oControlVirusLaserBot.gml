#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
image_angle=270

//Enemy base statistics
eName="Control Virus Laser Bot"
eLevel=9
maxLife=105
life=maxLife
pointWorth=9
atkPower=5

atkTime=0
atkDelay=65

jeremyText="This fires lasers in fairly often, you should get rid of them as soon as you can. Not only do they make a lot of the field unsafe, but your Pincher Bot doesn't stand a chance with those there. These go down easy, should be no problem for you."
chaoText="I find these to be more troublesome than the turrets. Do what Jeremy said, I don't have anything else to say on this that one of us haven't already said."
devText="The hardest part about making these was fine tuning their initial delay. I knew I needed to give the player enough time to destroy most, if not all of them, before they had a chance to fire. The end result is giving the player roughly 2.16 seconds before they start.##My record time for beating this thing is having 610 on the clock, which is 20.33 seconds remaining."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  if atkTime>=atkDelay //---------- Attack: Bullet down ----------
  {
    playSound(global.snd_CShotB,0,0.9,44100)
    var tFire;
    for(i=0;i<3;i+=1)
    {
      tFire=instance_create(x,y-4,oPassBullet)
      tFire.direction=270; tFire.sprite_index=sWolfHeadShot
      tFire.atkPower=atkPower; tFire.bulletSpeed=8; tFire.decayTime=-100
    }
    atkTime=55
  }
  enemyStepEvent()
}
