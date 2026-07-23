#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true

//Enemy base statistics
eName="Control Virus Turret"
eLevel=10
maxLife=310
life=maxLife
atkPower=5
pointWorth=12

atkTime=15
atkDelay=140

jeremyText="This targets you and fires 3 bullets in your direction, when you're dodging, use the conveyor to your advantage instead of thinking it works against you. Remember what could looks like a hindrance, could be an ace up your sleeve in disguise...#Yeah, I was never good at coming up with analogies."
chaoText="All these sprites are from an SNES run and gun game called Jim Power. I'm pretty sure there was an arcade version too."
devText="I noticed that Chao's comments were sometimes little bits of commentary from me, which I felt I was taking away from the character by inserting too much of myself into them. While the character's comments are set to clue in the player somewhat to the enemy weakness and attack patterns, I knew that straight up info on every enemy would be a wasted opportunity for inserting humorous side comments from them."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  if atkTime=atkDelay //---------- Attack: 3 Bullets toward player ----------
  {
    var tEffect;
    tEffect=instance_create(x-8,y,oEffect)
    tEffect.sprite_index=sMMchargeComplete
    tEffect.image_speed=0.5; tEffect.image_xscale=2; tEffect.image_yscale=2
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  else if atkTime>=atkDelay+30
  {
    playSound(global.snd_CShotA,0,0.96,44100)
    var tFire,tDir;
    tDir=point_direction(x,y-4,oPlayer1.x,returnPlayerYCenter())
    tDir-=20
    for(i=0;i<3;i+=1)
    {
      tFire=instance_create(x,y-4,oPassBullet)
      tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
      tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      tDir+=20
    }
    atkTime=0
  }
  enemyStepEvent()
}
