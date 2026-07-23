#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Wasp Bot"
eLevel=15
maxLife=3400
life=maxLife
pointWorth=120
atkPower=5
resType[1]=2
if global.location=29 {resType[2]=4}
resType[4]=4
stunResist=12
baseItemChance=80
moneyWorth=10
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
inactiveDist=room_width*2
propFrame=0
propScale=1

currHspd=0
currVspd=0
maxHspd=3
maxVspd=1

missileTime=60
missileDelay=190
missileType=0
missileAmt=0

deathAnim=0

jeremyText="These have two types of missiles. The first is a homing missile which you should be familiar with. The other is a scatter missile. If you watch the exhaust, you can tell when it will fire missiles. Throughout its attack, it will cycle through them. Don't worry about the gun from the original, it seems to have been taken out."
chaoText="On their own, these things are not much of a problem, but they seem to have a behavior that gives it an affinity for assisting other attack type robots. It also has the wrong name tag, it's supposed to be 'Spycopter'. Hmm, outside of the Gate, these don't have an ELEMENTAL weakness."
devText="I decided from the start that I would be taking liberties with how enemies work. DT plays out much different than these other games, and the AI needs to change accordingly. Originally, I was going to give the Bees a laser, but decided against it."
extraInfo="Extremely high stun resist."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}

  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      //----- Movement -----
      if x>oPlayer1.x
      {
        if currHspd>-maxHspd
          currHspd-=0.075
        else
          currHspd=-maxHspd
      }
      else if x<oPlayer1.x
      {
        if currHspd<maxHspd
          currHspd+=0.075
        else
          currHspd=maxHspd
      }
      if y+45>oPlayer1.y-26-yDist
      {
        if currVspd>-maxVspd
          currVspd-=0.05
        else
          currVspd=-maxVspd
      }
      else if y+25<oPlayer1.y-26-yDist
      {
        if currVspd<maxVspd
          currVspd+=0.05
        else
          currVspd=maxVspd
      }
      hspeed=currHspd
      vspeed=currVspd
      if hspeed>0 {image_xscale=1}
      else {image_xscale=-1}

      //----- Attack: Homing Missile -----
      missileTime+=1
      if missileTime>=missileDelay and missileTime<=missileDelay+15
      {
        var tFFScl,tEffect;
        tFFScl=random(0.2)
        tEffect=instance_create(x-(37*image_xscale),y+52,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud
        tEffect.image_alpha=0.8; tEffect.image_xscale=0.8+tFFScl; tEffect.image_yscale=0.8+tFFScl
        tEffect.direction=90; tEffect.speed=random(0.5)+1; tEffect.fadeSpd=0.04
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      }
      if missileType=0
      {
        if missileTime>=missileDelay+16
        {
          var tMissile;
          tMissile=instance_create(x,y+2,oEnmityMissile)
          tMissile.atkPower=atkPower; tMissile.targetTime=20
          tMissile.direction=90
          missileAmt+=1
          if missileAmt=5 {missileType=1; missileAmt=0; missileTime=0}
          else {missileTime=missileDelay+8}
        }
      }
      else if missileType=1
      {
        if missileTime>=missileDelay+16
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y+2,oGravBulletAlt)
          tNewAttack.sprite_index=sEnmityMissile; tNewAttack.atkPower=atkPower
          tNewAttack.xVel=random_range(-4,4); tNewAttack.xGrav=0; tNewAttack.bExplode=0
          if y+45<oPlayer1.y-26
          {
            tNewAttack.yVel=-3-random(2)
            tNewAttack.yGrav=0.2
          }
          else
          {
            tNewAttack.yVel=+3+random(2)
            tNewAttack.yGrav=-0.2
          }
          missileAmt+=1
          if missileAmt=10 {missileType=0; missileAmt=0; missileTime=0}
          else {missileTime=missileDelay+13}
        }
      }

      //-- Effects --
      if oGame.time mod 7=0
      {
        var tFFScl,tEffect;
        tFFScl=random(0.2)
        tEffect=instance_create(x-(37*image_xscale),y+52,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud
        tEffect.image_alpha=0.8; tEffect.image_xscale=0.8+tFFScl; tEffect.image_yscale=0.8+tFFScl
        tEffect.direction=90; tEffect.speed=random(0.5)+1; tEffect.fadeSpd=0.02
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      }
    }
    else
    {
      hspeed=0
      vspeed=0
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y+38,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tDir=random_range(-1.5,1.5)
    tEffect=instance_create(x-(29*image_xscale),y+64,oEffectGrav); tEffect.sprite_index=sWaspBPartA
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-2-random(0.5); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x+(39*image_xscale),y+32,oEffectGrav); tEffect.sprite_index=sWaspBPartB
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x-(36*image_xscale),y+23,oEffectGrav); tEffect.sprite_index=sWaspBPartC
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-2.5,2.5)
    tEffect=instance_create(x+(7*image_xscale),y+17,oEffectGrav); tEffect.sprite_index=sWaspBPartD
    tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    for(i=0;i<3;i+=1)
    {
      tDir=random_range(-4,4)
      tEffect=instance_create(x+((i*8)*image_xscale),y+56-(i*6),oEffectGrav); tEffect.sprite_index=sWaspBPartE
      tEffect.type=2; tEffect.xSpd=tDir; tEffect.ySpd=-3-random(2.25); tEffect.fadeSpd=0.03; tEffect.rotation=-tDir
      tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    }
    instance_destroy()
  }
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
propFrame+=1
if propFrame=1 {propScale=1; image_index=0}
else if propFrame=4 {image_index=1}
else if propFrame=7 {image_index=0}
else if propFrame=10 {propScale=-1; image_index=1}
else if propFrame=12 {propFrame=0}
draw_sprite_ext(sWaspBotProp,image_index,x,y,propScale,image_yscale,image_angle,image_blend,image_alpha)
