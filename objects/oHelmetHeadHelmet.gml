#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanDealDamage=0

//Enemy base statistics
eName="Helmet Head Helmet"
maxLife=2000
life=maxLife
atkPower=4
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitZelda

moveProg=0
xSpd=2

moveTime=0
atkTime=0
bossProg=0
extraBullet=0

myBarrier=0
alphaUp=1
lineAlpha=0.4
waterFrm=0

jeremyText="Helmethead's Helmet... Well that's what it is. It only stays in the air moving along a sin wave while firing periodic bullets at you."
chaoText="So it's an empty suit of armor controlled by a ghost?"
devText="Due to Jerry's abilities completely overpowering these bosses, there were some tweaks. In this case, I made the bullet frequency fired from these loose helmets a bit higher as well as made the bullet speed higher. This helped to offset Jerry's speed somewhat. During the demo, this boss was made to be laughably easy, but I decided to change that a bit for the final version."
extraInfo="Completely immune to damage while shield is active."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  waterFrm+=0.33
  //---------- Movement ----------
  if bossProg=0 //Standard movement
  {
    if moveProg=0
    {
      x+=xSpd
      if xSpd>0
        xSpd-=0.1
      y-=2
      if y<=yGround
        moveProg=1
    }
    else if moveProg=1
    {
      y+=sin(oGame.time/2.5)
      if moveTime<moveThres
      {
        if x<oPlayer1.x
          image_xscale=1
        else
          image_xscale=-1
      }

      moveTime+=1
      if moveTime>=moveThres and moveTime<=moveThres+15
      {
        image_speed=0.2
        if image_xscale=1
          x+=1.5
        else
          x-=1.5
      }
      else if moveTime>=moveThres+16
      {
        image_speed=0
        image_index=0
        xVel=0
        moveTime=0
      }
    }

    //---------- Attack: Bullet toward player ----------
    atkTime+=1
    if atkTime=atkDelay
    {
      var tEffect;
      tEffect=instance_create(x,y-4,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
      tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if atkTime>=atkDelay+15
    {
      playSound(global.snd_HardHit3,0,0.97,27000)
      var tFire;
      tFire=instance_create(x,y-4,oPassBullet)
      tFire.direction=player_sprite_center(); tFire.sprite_index=sWolfHeadShot
      tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      atkTime=0
    }
  }
  else if bossProg=1 //Move to corners
  {
    if type=1
    {
      if x<288 {x+=8; image_xscale=1}
      else {x-=8; image_xscale=-1}
      if point_distance(x,0,288,0)<9 {x=288; y=160; atkTime=0; bossProg=2}
    }
    else if type=2
    {
      if x<608 {x+=8; image_xscale=1}
      else {x-=8; image_xscale=-1}
      if point_distance(x,0,608,0)<9 {x=608; y=160; atkTime=0; bossProg=2}
    }
  }
  else if bossProg=2 //Move to corners
  {
    atkTime+=1
    if atkTime=1
    {
      var tEffect;
      tEffect=instance_create(x,y-4,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
      tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if atkTime>=15 and atkTime mod 4=0
    {
      playSound(global.snd_HardHit2,0,0.92,33000)
      var tFire;
      tFire=instance_create(x,y-4,oPassBullet)
      tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      if type=1 {tFire.direction=345}
      else if type=2 {tFire.direction=195}
    }

    if extraBullet=1
    {
      if atkTime mod 4=0
      {
        var tFire;
        tFire=instance_create(x,y-4,oPassBullet)
        tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        if type=1 {tFire.direction=280}
        else if type=2 {tFire.direction=260}
      }
    }
  }

  if alphaUp=1
  {
    lineAlpha+=0.01
    if lineAlpha>=0.6 {alphaUp=0}
  }
  else
  {
    lineAlpha-=0.01
    if lineAlpha<=0.4 {alphaUp=1}
  }

  if myBarrier=1 //Remove barrier from Helmet Head after enough damage is taken
  {
    if life<=1400
    {
      life=maxLife-200
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      myBarrier=0
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if myBarrier=0 {draw_sprite_ext(sWaterBarrier,waterFrm,x,y-6,0.5,0.5,0,c_white,0.4)}
else if myBarrier=1 //Link to Helmet Head
{
  draw_set_alpha(lineAlpha)
  draw_set_color(c_red)
  draw_line(x,y-6,oHelmetHead.x,oHelmetHead.y-16)
}
