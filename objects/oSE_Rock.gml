#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires atkTime
event_inherited()
bActive=true

//Enemy base statistics
eName="Rock"
eLevel=36
maxLife=10000
life=maxLife
atkPower=10
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=3
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
dieSound=0
bossProgress=0
activateBoss=0

rockSequence=0
daggerTime=0
bCanHitRope=1
laserCrawl=0
yVel=0

atkProg=160

deathAnim=0

jeremyText="This rock hides something. First thing you're gonna need to do is blow them off the ceiling and find a way to cut them down. Something else, two of these are fake, so look at the bullet pattern to find the real one."
chaoText="Something else I saw with these rocks that I don't think my brother saw. The thing inside will try to counter your methods to bring the rocks down. Keep in mind that it won't be the same every time he hides in the rocks, if it does hide in them again that is."
devText="Why would a rock have dev commentary?"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and life>0
  {
    if rockSequence=0 //Wait up top
    {
      if life<maxLife
      {
        resType[4]=1
        life=maxLife
        rockSequence=1
      }
    }
    else if rockSequence=1 //Fall with string
    {
      y+=yVel
      if yVel<3 {yVel+=0.2}
      if y>=176
      {
        y=176
        yVel=0
        rockSequence=2
      }
    }
    else if rockSequence=2 //Hang
    {
      if instance_exists(oBelmontDagger)
      {
        if oShadowEura.bossProgress>=1 //Shielding the rope
        {
          if oBelmontDagger.y<y-28 {daggerTime+=1}
        }

        if daggerTime<7
        {
          if oShadowEura.bossProgress>=2
          {
            if type=1 //3rd phase (must destroy other 2 rocks first)
            {
              if instance_exists(oShadowEura.myRockA) or instance_exists(oShadowEura.myRockB)
              {
                if oBelmontDagger.y<y-28 {daggerTime=8}
                bCanHitRope=0
              }
              else {bCanHitRope=1}
            }
            else {bCanHitRope=1}
          }
          else {bCanHitRope=1}

          if bCanHitRope=1
          {
            if collision_line(x,y-28,x,64,oBelmontDagger,1,1)
            {
              var tEffect;
              for(i=0;i<10;i+=1)
              {
                tEffect=instance_create(x,64+(i*8),oEffect)
                tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.5; tEffect.image_alpha=0.5; tEffect.image_blend=c_ltgray
                tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
              }
              daggerTime=0
              rockSequence=3
            }
          }
        }
        else //Deflect
        {
          if collision_rectangle(x-48,64,x+48,y-28,oBelmontDagger,1,1)
          {
            var tNearDagger,tEffect;
            tNearDagger=instance_nearest(x,y-48,oBelmontDagger)
            tEffect=instance_create(tNearDagger.x+(23*tNearDagger.image_xscale),tNearDagger.y+16,oEffect)
            tEffect.sprite_index=sAirDashWave; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.image_xscale=tNearDagger.image_xscale
            tNearDagger.bCollide=1
          }
        }
      }
      else {daggerTime=0}
    }
    else if rockSequence=3 //Fall to ground
    {
      y+=yVel
      if yVel<3 {yVel+=0.2}
      var tYCheck;
      if x=256 or 448 {tYCheck=256}
      else {tYCheck=288}
      if y>=tYCheck
      {
        playSound(global.snd_HardHit1,0,0.98,16000)
        y=tYCheck
        yVel=0
        var tEffect;
        if type=1 //real rock
        {
          sprite_index=sSE_RockV2
          for(i=0;i<40;i+=1)
          {
            tEffect=instance_create(x+random_range(-32,32),y+random_range(-32,32),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=23
            tEffect.image_speed=0.2; tEffect.fadeSpd=0.05; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
          oShadowEura.bCanTakeDamage=1
        }
        if type=2 //fake rock
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=3
          }
          maxLife=300
          life=maxLife
          for(i=0;i<12;i+=1)
          {
            tEffect=instance_create(x+random_range(-32,32),y+random_range(30,34),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=23
            tEffect.image_speed=0.2; tEffect.fadeSpd=0.05; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
            tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
        }
        rockSequence=4
      }
    }
  }

  //---------- ATTACK: STANDARD ----------
  atkTime+=1
  if atkTime=atkProg or atkTime=atkProg+15 or atkTime=atkProg+30
  {
    var tEfCir;
    tEfCir=instance_create(x,y,oEfCircleSoftFade)
    tEfCir.image_alpha=0.4; tEfCir.myRad=24; tEfCir.radScl=1.5; tEfCir.fadeSpeed=0.012
  }
  if atkTime=atkProg+45
  {
    var tAtk,tDir;
    if type=1
    {
      tDir=0
      for(i=0;i<oShadowEura.rockWaveNum;i+=1)
      {
        tAtk=instance_create(x,y,oPassBulletRed)
        tAtk.sprite_index=sSE_ShotA; tAtk.bulletSpeed=5; tAtk.decayTime=-100; tAtk.direction=tDir; tAtk.atkPower=atkPower
        tDir+=360/oShadowEura.rockWaveNum
      }
    }
    else if type=2
    {
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(x,y,oPassBulletRed)
        tAtk.sprite_index=sSE_ShotA; tAtk.bulletSpeed=3+(i*1.5); tAtk.decayTime=-100; tAtk.direction=tDir; tAtk.atkPower=atkPower
      }
    }
    atkTime=0
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  if deathAnim=0
  {
    playSound(global.snd_BoxBreak,0,1,1)
    deathAnim=1
  }
  for(i=0;i<32;i+=1)
  {
    tEffect=instance_create(x+random_range(-32,32),y+random_range(-32,32),oEffectGrav)
    tEffect.type=2; tEffect.sprite_index=sSE_RockV1; tEffect.newBlend=-1; tEffect.depth=23
    tEffect.fadeSpd=0.05; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
    tEffect.xSpd=random_range(-3,3); tEffect.ySpd=-4-random(3); tEffect.followID=-1; tEffect.rotation=0; tEffect.grav=0.8
  }
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if rockSequence=1 or rockSequence=2 //Draw string
{
  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_line(x,y-28,x,64)
}

if global.bossTrack>0
{
  if oShadowEura.bossProgress>=2
  {
    if oGame.time mod 2=0 {draw_set_color(c_red)}
    else {draw_set_color(c_orange)}
    draw_set_alpha(1)

    if type=1
    {
      if instance_exists(oShadowEura.myRockA)
      {
        //draw_line(x,y,oShadowEura.myRockA.x,oShadowEura.myRockA.y)
        var tLineDir,tDotAmt;
        tLineDir=point_direction(x,y,oShadowEura.myRockA.x,oShadowEura.myRockA.y)
        tDotAmt=ceil(point_distance(x,y,oShadowEura.myRockA.x,oShadowEura.myRockA.y)/11)
        laserCrawl-=1
        if laserCrawl<-12 {laserCrawl=0}
        for(i=0;i<tDotAmt;i+=1)
        {
          draw_circle(x+lengthdir_x((12*i)+laserCrawl,tLineDir),y+lengthdir_y((12*i)+laserCrawl,tLineDir),2,0)
        }
      }
      if instance_exists(oShadowEura.myRockB)
      {
        //draw_line(x,y,oShadowEura.myRockB.x,oShadowEura.myRockB.y)
        var tLineDir,tDotAmt;
        tLineDir=point_direction(x,y,oShadowEura.myRockB.x,oShadowEura.myRockB.y)
        tDotAmt=ceil(point_distance(x,y,oShadowEura.myRockB.x,oShadowEura.myRockB.y)/11)
        laserCrawl-=1
        if laserCrawl<-12 {laserCrawl=0}
        for(i=0;i<tDotAmt;i+=1)
        {
          draw_circle(x+lengthdir_x((12*i)+laserCrawl,tLineDir),y+lengthdir_y((12*i)+laserCrawl,tLineDir),2,0)
        }
      }
    }
  }
}

if daggerTime>0 //Barrier
{
  draw_set_alpha(0.1+(daggerTime*0.02))
  draw_set_color(c_white)
  draw_rectangle(x-44,64,x+44,y-28,0)
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
