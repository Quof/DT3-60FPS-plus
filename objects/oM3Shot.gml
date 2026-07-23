#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
      var tHopPitch;
      tHopPitch=oPlayer1.hopOnCount
      if tHopPitch>8 {tHopPitch=8}
      playSound(global.snd_MarioKick,0,0.98,22050+(tHopPitch*1000))
      var tEffect;
      for(i=0;i<6;i+=1)
      {
        tEffect=instance_create(x,bbox_bottom-(sprite_height/2),oKillEffect)
        tEffect.speed=2.66; tEffect.direction=i*60; tEffect.friction=0.11
        tEffect.fadeAlpha=0.025; tEffect.imageRot=0
      }
      if oPlayer1.canAirDash=0 {oHUD.airDashScl=3}
      oPlayer1.canAirDash=1
      oPlayer1.doubleJumpCheck=1
      oPlayer1.hopOnCount+=1
      if global.recMaxEnemyJumpCombo<oPlayer1.hopOnCount {global.recMaxEnemyJumpCombo=oPlayer1.hopOnCount}
      global.recEnemyJumpedOn+=1
      if global.difficulty>=2
      {
        awardAP(10*oPlayer1.hopOnCount)
        if global.optShowPointsEarned=true
        {
          newAward=instance_create(round(bbox_left+(abs(sprite_width)/2)),round(bbox_top+(abs(sprite_height)/2)),oKillAward)
          newAward.pointValue=10*oPlayer1.hopOnCount
        }
      }
      awardAwesome(150*oPlayer1.hopOnCount)
      instance_destroy()
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
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
