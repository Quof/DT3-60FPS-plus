#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
image_speed=0.2
bActive=1

//Enemy base statistics
eName="Grabbing Hand"
eLevel=6
maxLife=300
life=maxLife
pointWorth=2
atkPower=4
stunResist=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

xSpd=1
atkSequence=0
atkTime=0

jeremyText="These simply rise out of the ground and deal contact damage unlike what they did in Ocarina of Time. These have been modified to explode into 2 bullets after some time. When you see its movement speed slow down, it's getting closer to exploding."
chaoText="This miniboss always creeped me out when I was younger. It's just so weird, and the way it contorts its mouth when it attacks Link... so creepy."
devText="In the DT3 demo released well before the full version, this Forest Palace was based off Zelda 2, like the Desert Palace before this level. I didn't like the level in the demo so I trashed it and revamped it into what it is now. I find it to be a major improvement over the bland level that was in the demo."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and stunnedTime=0
  {
    if x>oPlayer1.x
      image_xscale=-1
    else
      image_xscale=1

    if atkSequence=0 //Rise up from the ground
    {
      atkTime+=1
      if atkTime>=30
      {
        if atkTime=30 {playSound(global.snd_FireLoop,0,1,21000)}
        if oGame.time mod 3=0
        {
          var tEffect,tXspd;
          tEffect=instance_create(x+random_range(-5,5),288+random_range(-2,3),oEffect)
          tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.33
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }

        y-=0.5
        if y<=288
        {
          bCanDealDamage=true; bCanTakeDamage=true
          atkTime=0; atkSequence=1
        }
      }
    }
    else if atkSequence=1 //Move toward player
    {
      if x<oPlayer1.x
      {
        image_xscale=1
        x+=xSpd
      }
      else
      {
        image_xscale=-1
        x-=xSpd
      }

      timeout-=1
      if timeout=120 {xSpd-=0.25}
      else if timeout<=0 {atkSequence=2; image_index=0}
    }
    else if atkSequence=2 //Explode
    {
      atkTime+=1
      if atkTime mod 2=0
      {
        if image_blend=c_orange {image_blend=c_white}
        else {image_blend=c_orange}
      }
      if atkTime>=60
      {
        playSound(global.snd_EnemyHitMM,0,0.97,13000)
        var tFire,tDir;
        if oPlayer1.y>=232
        {
          tDir=0
          for(i=0;i<2;i+=1)
          {
            tFire=instance_create(x+(5*image_xscale),y-21,oPassBullet)
            tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=4; tFire.decayTime=-100
            tDir+=180
          }
        }
        else
        {
          tDir=45
          for(i=0;i<2;i+=1)
          {
            tFire=instance_create(x+(5*image_xscale),y-21,oPassBullet)
            tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=4; tFire.decayTime=-100
            tDir+=90
          }
        }
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
