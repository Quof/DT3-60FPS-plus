#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="CHAOS Sabotage"
eLevel=32
maxLife=290
life=maxLife
pointWorth=54
atkPower=9
resType[1]=4
resType[5]=2
stunResist=3
baseItemChance=70
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0
inactiveDist*=1.5

dropType=0 //0: None, 1: Down, 2: Up
moveWave=pi
shotTime=15
shotDelay=35
shotType=0
bAssisted=0
findAlly=0
linkFrm=0

deathAnim=0

jeremyText="Easy behavior for these guys. They drop till a set point from the ground, but will pull themselves back up if you get close. It cycles between 2 shot types. A 3-shot burst and a 5 shot spread, but watch out for the middle bullet aimed at you; it has a red outline. There is also an assist function for something called the 'CHAOS Shock Unit'."
chaoText="Another sprite from the Mega Man Zero series. CHAOS really likes these."
devText="Sometime after making these guys, I decided to go back and revamp the bosses: Helmet Head, Thunderbird, and Large Vampire Bat. In the demo version, all three of these bosses were meant to be an overly easy encounter."

if global.CHAOS_Upgrade=1
{
  image_index=1
  eName="CHAOS Advanced Sabotage"
  eLevel=36
  maxLife=370
  life=maxLife
  atkPower=10
  pointWorth=73
  jeremyText+=" The advanced version of these give it improved durability and power."
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    //Hanging wave
    moveWave+=pi/40
    x+=cos(moveWave)/1.75

    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}


    if !collision_point(x,y+sprite_height+80,oSolid,0,1) //Check if ground is close
    {
      if point_distance(0,y+16,0,returnPlayerYCenter())<144 and y+16>returnPlayerYCenter() //Check if player is too high up
      {
        dropType=2
      }
      else {dropType=1}
    }
    else
    {
      dropType=0
    }

    if point_distance(x,y+16,oPlayer1.x,returnPlayerYCenter())<128 //Check if player is close
    {
      dropType=2
    }
    else
    {
      if dropType!=1 {dropType=0} //Drop if ground is not close
    }

    if dropType=1 //Down
    {
      y+=5
    }
    else if dropType=2 //Up
    {
      if y>ystart+12 {y-=3}
    }

    shotTime+=1
    if shotTime=shotDelay //Shot warning
    {
      var tEffect;
      tEffect=instance_create(x+(16*image_xscale),y+31,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
      tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
    }
    if shotType=0 //3 Bullets
    {
      if shotTime>=shotDelay+10
      {
        if shotTime mod 10=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x+(16*image_xscale),y+31,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
          tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100
          tNewAttack.direction=point_direction(x+(16*image_xscale),y+16,oPlayer1.x,returnPlayerYCenter())
        }
      }
      if shotTime>=shotDelay+40
      {
        shotType=1
        shotTime=0
      }
    }
    else if shotType=1 //5 Bullet spread (Mid bullet at player is red)
    {
      if shotTime=shotDelay+10
      {
        var tNewAttack,tDir;
        tDir=point_direction(x+(16*image_xscale),y+16,oPlayer1.x,returnPlayerYCenter())
        tDir-=22
        for(i=0;i<5;i+=1)
        {
          if i=2
          {
            tNewAttack=instance_create(x+(16*image_xscale),y+31,oPassBulletRed)
            tNewAttack.sprite_index=sCamBullet; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
            tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tDir
          }
          else
          {

            tNewAttack=instance_create(x+(16*image_xscale),y+31,oPassBullet)
            tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
            tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tDir
          }
          tDir+=11
        }
      }
      if shotTime>=shotDelay+20
      {
        shotType=0
        shotTime=0
      }
    }

    if instance_exists(oCHAOS_AdvancedTurret)
    {
      findAlly=instance_nearest(x,y,oCHAOS_AdvancedTurret)
      if point_distance(x,y+28,findAlly.x,findAlly.y)<208 //Sabotage must be close enough
      {
        linkFrm+=0.33
        resType[1]=3
        bAssisted=1
      }
      else {resType[1]=4; bAssisted=0}
    }
    else {resType[1]=4; bAssisted=0}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-7,7),y+1+random(30),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.05
    if image_alpha<0.5
    {
      playSound(global.snd_BombExplode,0,0.92,1)
      for(i=0;i<7;i+=1)
      {
        tDir=random_range(-3.5,3.5)
        tEffect=instance_create(x+random_range(-7,7),y+1+random(30),oEffectGrav)
        if image_index=0 {tEffect.sprite_index=sSabotagePartsA}
        else {tEffect.sprite_index=sSabotagePartsB}
        tEffect.image_speed=0; tEffect.type=2; tEffect.image_index=i
        tEffect.xSpd=tDir; tEffect.ySpd=-2.5-random(2); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
        tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
      }
      instance_destroy()
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
if bAssisted=1
{
  if instance_exists(findAlly)
  {
    var tMyDist,tMyDir;
    tMyDist=point_distance(x,y+28,findAlly.x,findAlly.y)
    tMyDir=point_direction(x,y+28,findAlly.x,findAlly.y)
    draw_sprite_ext(sEfLinkLightning,linkFrm,x,y+28,0.5,tMyDist/64,tMyDir+90,c_white,0.45)
  }
}
draw_set_alpha(1)
draw_set_color(c_gray)
draw_line(xstart,ystart,x,y)
event_inherited()
