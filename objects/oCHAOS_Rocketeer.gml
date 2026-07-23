#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
xOffset=0
yOffset=0
bCanDealDamage=0

//Enemy base statistics
eName="CHAOS Rocketeer"
eLevel=33
maxLife=390
life=maxLife
pointWorth=62
atkPower=9
resType[5]=2
stunResist=9
baseItemChance=70
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0

currHspd=0; currVspd=0
xPoint=0
yPoint=0
maxSpeed=8
if x>=oPlayer1.x {atkSide=1; shotTime=0}
else {atkSide=-1; shotTime=10}
shotDelay=40
shotType=0
bLaser=0
laserDir=0
laserCrawl=0
circleRad=2
circleCol=c_white
myLaser=0
bNormalResist=0

deathAnim=0

jeremyText="These guys are super dangerous. A moderate amount of armor for a small flyer too. The first attack is a point explosion missile. It targets the position you are currently at, upon being fired, and will explode in that spot. The other is an undashable laser. The telegraph is easy to see, but you have 1/2 of a second to get away after it stops targeting you."
chaoText="This is from the Mega Man Zero series. I noticed in the behavior that these guys prefer to attack in groups of two and tend to always pin their target."
devText="I thought about having this enemy show up just after the Vault chapter, but Claire doesn't have her Samus abilities yet and that felt it was a bit too early to bring out these guys. That and it didn't work with the plot."

if global.CHAOS_Upgrade=1
{
  sprite_index=sCHAOS_AdvRocketeer
  eName="CHAOS Advanced Rocketeer"
  eLevel=38
  maxLife=550
  life=maxLife
  atkPower=10
  pointWorth=95
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
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true and stunnedTime=0 and life>0
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}
    if y<=oPlayer1.y-82 {image_index=0}
    else if y>=oPlayer1.y-81 and y<=oPlayer1.y-34 {image_index=1}
    else if y>=oPlayer1.y+34 and y<=oPlayer1.y+81 {image_index=3}
    else if y>=oPlayer1.y+82 {image_index=4}
    else {image_index=2}

    event_user(0)
    //Movement
    xPoint=oPlayer1.x+(88*atkSide)
    yPoint=oPlayer1.y-128

    if x>xPoint
    {
      if currHspd>-maxSpeed {currHspd-=0.5}
      else {currHspd+=0.5}
    }
    else if x<xPoint
    {
      if currHspd<maxSpeed {currHspd+=0.5}
      else {currHspd-=0.5}
    }
    if y>yPoint
    {
      if currVspd>-maxSpeed {currVspd-=0.5}
      else {currVspd+=0.5}
    }
    else if y<yPoint
    {
      if currVspd<maxSpeed {currVspd+=0.5}
      else {currVspd-=0.5}
    }
    hspeed=currHspd; vspeed=currVspd

    //Smoke
    var tEffect;
    tEffect=instance_create(x-(17*image_xscale),y-2,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
    tEffect.speed=random(1)+1; tEffect.friction=random(0.0125)+0.0125; tEffect.image_speed=0.2
    tEffect.fadeSpd=0.05; tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    if image_xscale=1 {tEffect.direction=random_range(255,265)}
    else {tEffect.direction=random_range(275,285)}

    shotTime+=1
    if shotType=0 //Point explosion missile
    {
      if shotTime=shotDelay-5
      {
        var tEffect;
        tEffect=instance_create(x+(xOffset*image_xscale),y+yOffset,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=0.875; tEffect.image_yscale=0.875
      }
      else if shotTime>=shotDelay+10
      {
        playSound(global.snd_CShotB,0,0.95,1)
        var tNewAttack;
        tNewAttack=instance_create(x+(xOffset*image_xscale),y+yOffset,oPointExpBullet)
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
        tNewAttack.direction=point_direction(x+(xOffset*image_xscale),y+yOffset,oPlayer1.x,returnPlayerYCenter())
        shotType=1
        shotTime=0
      }
    }
    else if shotType=1 //Laser
    {
      if shotTime=shotDelay {bLaser=1; circleRad=2; circleCol=c_white}
      if shotTime>=shotDelay and shotTime<=shotDelay+14 {laserDir=point_direction(x+(xOffset*image_xscale),y+yOffset,oPlayer1.x,returnPlayerYCenter())}
      else if shotTime=shotDelay+15 {circleRad=3; circleCol=c_red}
      else if shotTime=shotDelay+30
      {
        bLaser=0
        playSound(global.snd_CShotA,0,0.95,1)
        var tEffect,myLaser;
        tEffect=instance_create(x+(xOffset*image_xscale),y+yOffset,oEffect)
        tEffect.sprite_index=sEfPowerWave; tEffect.image_alpha=0.4; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=3; tEffect.image_angle=90+laserDir
        tEffect.image_xscale=0.8; tEffect.image_yscale=0.8

        myLaser=instance_create(x+(xOffset*image_xscale),y+yOffset,oC_RocketLaser)
        myLaser.image_angle=laserDir; myLaser.atkPower=atkPower
      }
      else if shotTime>=shotDelay+31
      {
        if atkSide=1 {atkSide=-1}
        else {atkSide=1}
        shotType=0
        shotTime=0
      }
    }
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
        tEffect.image_speed=0; tEffect.type=2; tEffect.image_index=i
        tEffect.xSpd=tDir; tEffect.ySpd=-2.5-random(2); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
        tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        if global.CHAOS_Upgrade=0 {tEffect.sprite_index=sSabotagePartsA}
        else {tEffect.sprite_index=sSabotagePartsB}
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Arm positions
if image_index=0
{
  xOffset=16
  yOffset=11
}
else if image_index=1
{
  xOffset=18
  yOffset=7
}
else if image_index=2
{
  xOffset=20
  yOffset=1
}
else if image_index=3
{
  xOffset=20
  yOffset=-5
}
else if image_index=4
{
  xOffset=17
  yOffset=-11
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bNormalResist=0
{
  if other.weaponTag=0 or other.weaponTag=30
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=0; tAtkShield.atkUp=1
    resType[0]-=1
    bNormalResist=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bLaser=1
{
  laserCrawl+=2
  if laserCrawl>12 {laserCrawl=0}
  draw_set_alpha(1)
  draw_set_color(circleCol)
  for(i=0;i<24;i+=1)
  {
    draw_circle(x+(xOffset*image_xscale)+lengthdir_x((12*i)+laserCrawl,laserDir),y+yOffset+lengthdir_y((12*i)+laserCrawl,laserDir),circleRad,0)
  }
}
event_inherited()
