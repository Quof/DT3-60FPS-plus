#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

//Enemy base statistics
eName="Magical Bat"
eLevel=37
maxLife=300
life=maxLife
pointWorth=15
atkPower=10
stunResist=50
baseItemChance=10
moneyWorth=0
affiliation=1

jeremyText="Remember 'Magical Castle: Starring Mickey'? These guys have perfect behavior."
chaoText="I always loved the Mickey games. So much color and fun looking animations!"
devText="This level was a lot of fun to make and turned out really well I think. Originally, I wasn't going to make a level with these tiles, but it was highly desired by pretty much all of the testers."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if room=rMC_K_Secret
    {
      inactiveDist=10000
      x+=4
    }
    else
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }
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
      other.yAdjust=-10
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
          scrSlowFall(5,0.4,0)
        }

        //Damage effect
        playSound(global.snd_MarioStomp,0,0.92,1)
        var tEffect;
        for(i=0;i<3;i+=1)
        {
          tEffect=instance_create(x,y-6,oKillEffect)
          tEffect.speed=5; tEffect.direction=random(360); tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
          tEffect.friction=0.1+random(0.3); tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
        }
        oPlayer1.canAirDash=1
        oPlayer1.doubleJumpCheck=1
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
