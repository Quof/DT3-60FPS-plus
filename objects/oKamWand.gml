#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanDealDamage=false
bCanTakeDamage=false
image_blend=c_red

//Enemy base statistics
eName="Kamek's Wand"
if oKamek.life=3 {maxLife=3}
else {maxLife=2}
life=maxLife
atkPower=3
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0

atkTime=0
atkSequence=0
hitStateTime=0

wandState=0
xVel=0
yVel=0
atkNum=0

jeremyText="This looks to be linked with Kamek's shield. But bleh, blocked from seeing much of anything."
chaoText="His wand has all sorts of attacks and moves on its own."
devText="No Dev Commentary for this."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if hitStateTime>0
    {
      hitStateTime-=1
      if hitStateTime mod 2=0 {image_alpha=0.5}
      else {image_alpha=0.75}
      if hitStateTime=0
      {
        image_alpha=1
        bCanDealDamage=true
        bCanTakeDamage=true
      }
    }
    atkTime+=1
    if atkSequence=0 //---------- Start sequence ----------
    {
      if atkTime>=45 {image_angle+=10}
      if atkTime>=60
      {
        image_blend=c_white
        bCanDealDamage=true
        bCanTakeDamage=true
        atkTime=0; atkSequence+=1
      }
    }
    else if atkSequence=1 //---------- Wander back and forth ----------
    {
      image_angle+=10
      if x>oPlayer1.x and xVel>-3 {xVel-=0.2}
      else if x<oPlayer1.x and xVel<3 {xVel+=0.2}
      x+=xVel
      if atkTime>=60 {atkTime=0; atkSequence+=1}
    }
    else if atkSequence=2 //---------- Attack: Wand projectile toward player ----------
    {
      if atkTime>=1 and atkTime<=30 {image_angle=player_sprite_center()}
      else if atkTime=40
      {
        playSound(global.snd_Magic,0,0.98,1)
        var tAtk,tMax,tAng;
        if oKamek.life=4 or oKamek.life=2 {tMax=1}
        else {tMax=3}
        tAng=image_angle
        if tMax=3 {tAng-=25}
        for(i=0;i<tMax;i+=1)
        {
          tAtk=instance_create(x+lengthdir_x(10,image_angle),y+lengthdir_y(10,image_angle),oKamBounceBall)
          tAtk.sprite_index=sKamekShape; tAtk.direction=tAng; tAtk.atkPower=atkPower; tAtk.projType=1; tAtk.bulletSpeed=5
          if tMax=1 {tAtk.image_index=irandom_range(0,2)}
          else {tAtk.image_index=i}
          tAng+=25
        }
      }
      else if atkTime=50 //End attack
      {
        atkTime=0
        atkNum+=1
        if atkNum=2 {atkNum=0; atkSequence+=1}
        else {atkSequence=1}
      }
    }
    else if atkSequence=3 //---------- Attack: Lightning ----------
    {
      image_angle+=10
      if atkTime>=1 and atkTime<=197 //Hover to sides
      {
        if x<=oKamek.xCenter
        {
          x-=2
          if x<=oKamek.xCenter-oKamek.roomSpan {atkTime=198}
        }
        else
        {
          x+=2
          if x>=oKamek.xCenter+oKamek.roomSpan {atkTime=198}
        }
      }
      else if atkTime=199
      {
        image_angle=90
        var tAtkLight;
        tAtkLight=instance_create(oPlayer1.x,oKamek.yGround,oCackLightning)
        tAtkLight.type=0; tAtkLight.warnTime=35; tAtkLight.decay=15
        atkTime=200
      }
      else if atkTime>=201 and atkTime<=220 //Wand sparkles
      {
        var tEffect;
        tEffect=instance_create(x,y-10,oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.2+random(0.1); tEffect.newBlend=-1
        tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
      }
      else if atkTime>=221 {atkTime=0; atkSequence+=1}
    }
    else if atkSequence=4 //---------- Attack: Swoop down ----------
    {
      if atkTime=1
      {
        if x<oKamek.xCenter {xVel=2.5} else {xVel=-2.5}
        yVel=5
      }
      else if atkTime>=15 and atkTime<=199 //Swoop
      {
        image_angle+=10
        x+=xVel; y+=yVel
        if yVel>-5 {yVel-=0.1}
        if yVel<0 and y<=oKamek.yGround-158
        {
          y=oKamek.yGround-158
          atkTime=0; atkSequence=1
        }
      }
    }
    else if atkSequence=5 //---------- Float back up (after getting hit) ----------
    {
      y-=2
      if y<=oKamek.yGround-158
      {
        y=oKamek.yGround-158
        atkTime=0; atkSequence=1
      }
    }
  }
  else if life<=0 //Defeat animation
  {
    oKamek.wandState=1
    oKamek.bCanTakeDamage=true
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sWitchFire; tEffect.image_speed=0.25
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanTakeDamage=true
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND)
      other.yAdjust=-8
    if platformCharacterIs(IN_AIR)
      other.yAdjust=0
  }
  veloAssist=0
  if oPlayer1.yVel>0
    veloAssist=round(oPlayer1.yVel/2)

  if bbox_bottom+yAdjust+veloAssist<oPlayer1.bbox_bottom
  {
    if bCanDealDamage=true
    {
      with other
        hitPlayer(other)
    }
  }
  else
  {
    if global.hasAbilToken[0]>=2 and oPlayer1.starmanTime<=0
    {
      var tDmgCheck;
      tDmgCheck=0
      if oPlayer1.sprite_index!=sJerryDamaged and oPlayer1.sprite_index!=sClaireDamaged
      {
        if oPlayer1.sprite_index!=sJerryDamaged and oPlayer1.sprite_index!=sClaireDamaged
        {
          if oPlayer1.bCanTakeHit=true
          {
            if oPlayer1.dashInvulnerabilityTime=0
              tDmgCheck=1
          }
          else
          {
            if oPlayer1.dashInvulnerabilityTime=0 and oPlayer1.yVel>0
              tDmgCheck=1
          }
        }

        if tDmgCheck=1
        {
          with oPlayer1
          {
            if platformCharacterIs(ON_GROUND)
              yVel=-2
            if platformCharacterIs(IN_AIR)
            {
              if oPlayer1.jumpTime<oPlayer1.jumpTimeTotal-5
                oPlayer1.jumpTime=oPlayer1.jumpTimeTotal-5
              if kJump or kUp
                yVel=-13.5
              else
                yVel=-6.5
            }
          }

          //Damage effect
          var tEffect;
          playSound(global.snd_MarioStomp,0,0.98,1)
          for(i=0;i<9;i+=1)
          {
            tEffect=instance_create(x-12+random(24),bbox_top+8,oKillEffect)
            tEffect.speed=5; tEffect.direction=55+(i*8)+random(4)
            tEffect.friction=0.1+random(0.3); tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
          }
          life-=1 //Damage Boss
          bCanTakeDamage=false
          bCanDealDamage=false
          hitStateTime=60
          atkSequence=5
          atkTime=0
        }
      }
    }
    else
    {
      if bCanDealDamage=true
      {
        with other
          hitPlayer(other)
      }
    }
  }
}
else
{
  if bCanDealDamage=true
  {
    with other
      hitPlayer(other)
  }
}
