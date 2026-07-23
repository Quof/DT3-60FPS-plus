#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false; bCanDealDamage=false
image_speed=0.25
baseColor=make_color_rgb(16,98,240)
image_blend=baseColor
image_xscale=0; image_yscale=0

bActive=1

//Enemy base statistics
eName="Vault Lavaball"
eLevel=21
maxLife=2000
life=maxLife
pointWorth=10
atkPower=6
resType[0]=2
resType[2]=5
resType[4]=1
stunResist=50
affiliation=8
damageType="ELEMENTAL"
dieEffect=0
bobTime=0
xVel=choose(-2,2)
moveTick=pi

myProg=0
progTime=0
deathAnim=0

jeremyText="The movement pattern is simple, just a sin wave. This is a priority target though. It looks to be connected to the water changing to lava."
chaoText="The sprite is from Zelda: Minish Cap, but in that game, it had eyes."
devText="N/A"
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
    if myProg=0 //Spawn in
    {
      progTime+=1
      if progTime mod 3=0
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_green
        tAfterI.image_alpha=0.5; tAfterI.image_xscale=2.5; tAfterI.image_yscale=2.5; tAfterI.xShift=0; tAfterI.yShift=0
        tAfterI.imageFade=0.05; tAfterI.xScaling=-0.2; tAfterI.yScaling=-0.2; tAfterI.bFollow=0
      }

      image_xscale+=0.04; image_yscale+=0.04
      if image_xscale>=1
      {

        bCanTakeDamage=true; bCanDealDamage=true
        progTime=0; myProg+=1
      }
    }
    else if myProg=1 //Slight wait
    {
      progTime+=1
      if progTime>=40
      {
        var tEffect;
        for(i=0;i<20;i+=1)
        {
          tEffect=instance_create(2176+random(64),352+random(24),oEffect)
          tEffect.sprite_index=sDeathFlameA; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.5-random(1)
          tEffect.image_speed=0.5
        }

        with (oDesertWaterVol) {instance_destroy()}
        var tLava;
        tLava=instance_create(2176,352,oMarioLava)
        tLava.image_xscale=4; tLava.scaling=16
        progTime=0; myProg+=1
      }
    }
    else if myProg=2 //Normal behavior
    {
      if x>=oVaultDemon.xCenter+oVaultDemon.roomSpan {xVel=-2}
      else if x<=oVaultDemon.xCenter-oVaultDemon.roomSpan {xVel=2}
      x+=xVel
      moveTick+=0.5
      y+=sin(moveTick/4)
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-6,6),y+random_range(-12,12),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0
    {
      var tEffect;
      for(i=0;i<20;i+=1)
      {
        tEffect=instance_create(2168+random(64),352+random(24),oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1-random(2)
        tEffect.image_speed=0.5
      }
      oVaultDemon.resType[0]=2
      if oVaultDemon.bossProgress<=1 {resType[1]=3}
      else {resType[1]=2}
      with (oMarioLava) {instance_destroy()}
      var tWater;
      tWater=instance_create(2176,352,oDesertWaterVol)
      tWater.image_xscale=64; tWater.image_yscale=24
      instance_destroy()
    }
  }
  enemyStepEvent()
}
