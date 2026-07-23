#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-26,-26,26,-1)
image_speed=0.3

//Enemy base statistics
eName="CHAOS Biker"
eLevel=28
maxLife=250
life=maxLife
pointWorth=35
atkPower=8
resType[0]=1
resType[1]=1
stunResist=4
baseItemChance=70
baseDropIndex=90
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0
initDir=0
turnTime=0
runAcc=7
gunShot=0
gunDelay=16
inactiveDist*=1.5

jeremyText="Only troublesome thing about them is they're fast and fire quite fast as well. Use caution."
chaoText="Eww, that arm is so weird... I mean seriously, look at it! Also this is from 'Contra: Hard Corps'."
devText="When constructing the tileset for this, there were some challenges that came up. Though I figured there would be since the Rayman tiles are fairly detailed. So in revenge, I decided I wanted to burn it down. Luckily this all went with the action in this part of the game."

deathAnim=0
maxSlope=6
maxDownSlope=5
y-=1
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
    if initDir=0
    {
      xVel=runAcc
      if x>oPlayer1.x
      {
        xVel*=-1
        direction=180
      }
      initDir=1
    }

    //Turn if going away from player
    if turnTime<=20
    {
      if x>oPlayer1.x and image_xscale=1
        turnTime+=1
      else if x<oPlayer1.x and image_xscale=-1
        turnTime+=1

      if !isCollisionBottom(1) and turnTime=20 {turnTime=10}
    }
    else
    {
      xVel*=-1
      turnTime=0
    }

    //Turn arm toward player
    turn_toward_direction(point_direction((x-(14*image_xscale))+lengthdir_x(20,direction),y-31+lengthdir_y(20,direction),oPlayer1.x,returnPlayerYCenter()),6)
    gunShot+=1
    if gunShot>=gunDelay
    {
      var tNewAttack;
      tNewAttack=instance_create((x-(14*image_xscale))+lengthdir_x(20,direction),y-31+lengthdir_y(20,direction),oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5; tNewAttack.depth=9
      tNewAttack.decayTime=-100; tNewAttack.direction=direction
      gunShot=0
    }

    //Smoke effect
    if oGame.time mod 6=0
    {
      var tEffect;
      tEffect=instance_create(x-(24*image_xscale),y,oEffect)
      tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1
      tEffect.image_blend=make_color_rgb(32,128,224); tEffect.image_speed=0.33
    }

    if !isCollisionBottom(1)
      yVel+=0.2
    if isCollisionSolid()
      y-=2

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1

    enemySlopeMovement()

    if y>room_height+24
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_EnemyDieMM,0,1,1)
      for(i=0;i<3;i+=1)
      {
        tEffect=instance_create(x,y-17,oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      sprite_index=sZakoSoldierDie
      y-=28
      if random(100)<=4 {global.recHeardWilhelm+=1; playSound(global.snd_Wilhelm,0,0.95,1)}
      flyX=5*image_xscale; flyY=-5
      image_angle=180
    }
    x+=flyX; y+=flyY
    flyY+=0.33
    image_angle+=2*-image_xscale
    image_alpha-=0.035
    if image_alpha<0
    {
      playSound(global.snd_HardHit1,0,0.98,1)
      tEffect=instance_create(x,y-17,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
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
event_inherited()
if life>0 {draw_sprite_ext(sBikeSArm,0,x-(14*image_xscale),y-31,1,1,direction,image_blend,image_alpha)}
