#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-9,-42,9,-1)
image_speed=0.15

//Enemy base statistics
eName="Tentacle Spider"
eLevel=25
maxLife=370
life=maxLife
pointWorth=33
atkPower=7
resType[2]=2
resType[4]=4
stunResist=1
baseItemChance=70
dieEffect=3

initDir=0
runAcc=2
bJumpReady=1
shotTime=0
shotReady=0
jumpTime=10
jumpDelay=60

jeremyText="Remember the Green Orcs from Gate 2? These work just like that, except they'll also jump up walls, and they like to just suddenly jump at times. There are also times that midair it will stop and flash. I recommend backing away as it is invincible during this and when it ends, it will spray bullets everywhere."
chaoText="The sprite is from a game called 'Super Valis 4', that was on the SNES."
devText="It was around the time that this enemy was coded that a lot of changes were made. Such as fire rate exploits, changing the save function to also save boss progress, fully implementing the Gate Item Terminal, and other minor issues fixed up."
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
    //---------- Movement ----------
    if yVel=0 and bJumpReady=1
    {
      sprite_index=sTentacleSpiderWalk
      if x<oPlayer1.x {xVel=runAcc; image_xscale=1}
      else {xVel=-runAcc; image_xscale=-1}
    }
    else {sprite_index=sTentacleSpiderJump}

    if yVel=0 and bJumpReady=1 {jumpTime+=1} //Jump at set times
    if jumpTime>=jumpDelay
    {
      if shotTime<500 {shotTime+=10}
      xVel=(runAcc*1.125)*image_xscale
      y-=4
      yVel=-4
      jumpTime=0
      bJumpReady=0
    }

    if yVel=0 and bJumpReady=1 //Check if cliff edge and jump
    {
      var tDrop;
      tDrop=0
      if aiCheckHoriz(1,1,0,16,4)
      {
        if aiCheckVert(0,3,24,16,4)=1
        {
          tDrop=1
        }
      }

      if tDrop=0
      {
        xVel=(runAcc*1.25)*image_xscale
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }

    if yVel=0 and bJumpReady=1 //Jump up cliff
    {
      if aiCheckHoriz(0,2,16,16,-8)=1
      {
        y-=4
        yVel=-6.5
        jumpTime=0
        bJumpReady=0
      }
    }

    //Multishot
    if shotTime<900 or shotTime>=1000 {shotTime+=1}
    if shotTime>=85 and shotTime<=900 and shotReady>=25
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      xVel=0; yVel=0
      shotTime=1000
    }
    else if shotTime>=1001 and shotTime<=1030 //Charge shot
    {
      if shotTime mod 2=0 {image_blend=make_color_rgb(random(255),random(255),random(255))}
    }
    if shotTime>=1031
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_ChargeStrike,0,0.92,44100)}
      var tNewAttack,tDir;
      tDir=0
      for(i=0;i<16;i+=1)
      {
        tNewAttack=instance_create(x,y,oNormalBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower
        tNewAttack.bulletSpeed=6; tNewAttack.direction=tDir
        tDir+=360/16
      }
      image_blend=baseColor
      for(i=0;i<6;i+=1)
      {
        resType[i]=3
      }
      resType[2]=2; resType[4]=4
      xVel=runAcc*image_xscale
      shotTime=0; shotReady=0
    }
    if bJumpReady=0 {shotReady+=1}

    if shotTime<=999 {yVel+=0.25}
    if isCollisionBottom(1)
    {
      yVel=0
      shotReady=0
      bJumpReady=1
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y<0 or y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
