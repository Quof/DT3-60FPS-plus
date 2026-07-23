#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.optShowDamage<2
{
  global.optShowDamage+=2
}
oPlayer1.visible=0

bCanTakeDamage=true
damageTime=0

normalSpd=6
focusSpd=3
moveSpd=normalSpd
bFocus=0
hitBoxImgRot=0
swapDelay=0

bCanSuck=1
bSucking=0
suckMax=30
suckTime=suckMax
checkSuckSound=0

bCanUseWeapon=1
shotDelay=0
shotType=0
charJerryShot=0
charClaireShot=0

shotHP_Jerry=0
shotHP_Claire=0

killCombo=0
comboTime=0

multiple=0
shipAssist[0]=noone
assistDir=0

instance_create(x,y,oDragKirby)
instance_create(x,y,oDragSuck)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //****************************** CONTROLS ******************************
  //Focus
  if scrController(6)
  {
    bFocus=true
    moveSpd=focusSpd
  }
  else
  {
    bFocus=false
    moveSpd=normalSpd
  }

  if bSucking=0
  {
    //Left
    if scrController(1) and x>16
    {
      x-=moveSpd
    }
    //Right
    if scrController(2) and x<room_width-22
    {
      x+=moveSpd
    }
    //Up
    if scrController(3) and y>66
    {
      y-=moveSpd
    }
    //Down
    if scrController(4) and y<room_height-20
    {
      y+=moveSpd
    }
  }

  //Swap
  if swapDelay=0
  {
    if oKeyCodes.kCodePressed[9]=1
    {
      if global.activeCharacter=0
      {
        global.activeCharacter=1
        shotType=charClaireShot
      }
      else
      {
        global.activeCharacter=0
        shotType=charJerryShot
      }
      swapDelay=5
    }
  }
  else {swapDelay-=1}

  //Suck in
  if suckTime<suckMax {suckTime+=1}
  if scrController(7) and suckTime=suckMax and bCanSuck=1
  {
    if checkSuckSound=0
    {
      playSound(global.snd_KirbySuck,0,0.98,1)
      checkSuckSound=41
    }
    if checkSuckSound>0 {checkSuckSound-=1}
    oDragKirby.visible=1
    bSucking=1
    if oGame.time mod 2=0
    {
      var tEffect,tDir;
      tDir=random_range(-19,19)
      tEffect=instance_create(x+42+lengthdir_x(95,tDir),y+lengthdir_y(95,tDir),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=-1; tEffect.fadeSpd=0.084; tEffect.image_speed=0.33
      tEffect.direction=tDir-180; tEffect.speed=8; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      tEffect.image_xscale=1.5; tEffect.image_yscale=1.5. tEffect.image_blend=make_color_rgb(random(255),random(255),random(255))
    }
  }
  else
  {
    oDragKirby.visible=0
    SS_StopSound(global.snd_KirbySuck)
    checkSuckSound=0
    bSucking=0
  }

  //Weapon
  if scrController(5) and bCanUseWeapon=1
  {
    if shotDelay=0 and bSucking=0
    {
      event_user(0)
    }
  }
  if shotDelay>0 {shotDelay-=1}

  //Assists
  if multiple>0
  {
    assistDir+=3
    for(i=0;i<multiple;i+=1)
    {
      if shipAssist[i]>0
      {
        shipAssist[i].x=x+lengthdir_x(64,assistDir+(i*90))
        shipAssist[i].y=y+lengthdir_y(64,assistDir+(i*90))
      }
    }
  }

  //Damage time
  if damageTime>0
  {
    damageTime-=1
    if image_alpha=0.75 {image_alpha=0.25}
    else {image_alpha=0.75}
    if damageTime=0
    {
      image_alpha=1
      bCanTakeDamage=true
    }
  }

  //Combo time
  if killCombo>0
  {
    if instance_exists(oShipEnemyBase) {comboTime+=1}
    if comboTime=60
    {
      comboTime=0
      killCombo=0
    }
  }

  oPlayer1.sprite_index=sDragoonHitBox
  oPlayer1.x=x; oPlayer1.y=y
  oDragKirby.x=x+24; oDragKirby.y=y
  oDragSuck.x=x+40; oDragSuck.y=y
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//DPS=(fps/shotDelay)*atkPower
var tNewBullet;
if shotType=0 //Standard Shot - DPS=60
{
  playSound(global.snd_MarioCannon,0,0.88,1)
  tNewBullet=instance_create(x+10,y+1,oDragShip_Shot0)
  tNewBullet.bulletSpeed=15; tNewBullet.atkPower=10
  shotDelay=5
}
else if shotType=1 //Drill Shot - DPS=100
{
  playSound(global.snd_MetShotB,0,0.98,18000)
  tNewBullet=instance_create(x+10,y+1,oDragShip_Shot1)
  tNewBullet.bulletSpeed=2; tNewBullet.atkPower=30
  shotDelay=9
}
else if shotType=2 //Sticky Bomb - DPS=92
{
  playSound(global.snd_MorphBomb,0,0.95,32000)
  tNewBullet=instance_create(x+10,y+1,oDragShip_Shot2)
  tNewBullet.bulletSpeed=8; tNewBullet.atkPower=40
  shotDelay=13
}
else if shotType=3 //Spread Shot - DPS=47 (94) (141)
{
  playSound(global.snd_MetMissile,0,0.92,32000)
  var tDir;
  tDir=20
  for(i=0;i<3;i+=1)
  {
    tNewBullet=instance_create(x+10,y+1,oDragShip_Shot3)
    tNewBullet.bulletSpeed=12; tNewBullet.atkPower=11; tNewBullet.direction=tDir
    tDir-=20
  }
  shotDelay=7
}
else if shotType=4 //Homing Needle - DPS=66
{
  playSound(global.snd_MMBuster[0],0,0.92,32000)
  tNewBullet=instance_create(x+10,y+1,oDragShip_Shot4)
  tNewBullet.bulletSpeed=13; tNewBullet.atkPower=11
  shotDelay=5
}
else if shotType=5 //Dual Shot - DPS=60 (120)
{
  playSound(global.snd_MMBuster[1],0,0.9,33000)
  var tDir;
  if scrController(3) {tDir=15}
  else if scrController(4) {tDir=345}
  else {tDir=0}

  tNewBullet=instance_create(x+3,y-6,oDragShip_Shot5)
  tNewBullet.bulletSpeed=14; tNewBullet.atkPower=14; tNewBullet.direction=tDir
  tNewBullet=instance_create(x+3,y+8,oDragShip_Shot5)
  tNewBullet.bulletSpeed=14; tNewBullet.atkPower=14; tNewBullet.direction=tDir
  shotDelay=7
}
else if shotType=6 //Laser Beam - DPS=75
{
  playSound(global.snd_MetShotA,0,0.94,42000)
  tNewBullet=instance_create(x+10,y+1,oDragShip_Shot6)
  tNewBullet.bulletSpeed=9; tNewBullet.atkPower=5
  shotDelay=2
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sDragoonFlier,0,x,y,1,1,0,c_white,oPlayer1.image_alpha)
if bFocus=1
{
  hitBoxImgRot+=3
  draw_sprite_ext(sDragoonHitBox,image_index,x,y,1,1,hitBoxImgRot,c_white,1)
}
