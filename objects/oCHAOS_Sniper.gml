#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-28,12,-1)

//Enemy base statistics
eName="CHAOS Sniper"
eLevel=35
maxLife=360
life=maxLife
pointWorth=62
atkPower=11
stunResist=6
baseItemChance=70
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0
inactiveDist*=1.75

gunShot=75
gunDelay=95

deathAnim=0

jeremyText="Holy hell, these guys have some nasty bullets in those guns. They deal very high damage and have tracking capabilities. If the sniper doesn't have line of sight to you, the bullet that's fired will track you vertically first, then horizontally next. If the sniper does have line of sight, then the sniper fires directly toward you, but the bullet can ricochet off walls twice toward you."
chaoText="These snipers are at least stationary. And oh man, I just saw a weird bug with these, at least I think it's a bug. Their bullet can go through thin walls."
devText="During the early stages of writing the story, CHAOS was not as prominent as they are now and the focus was mainly on Hex. I didn't feel that Hex was a good antagonist on his own so CHAOS was there to be a massive army under his control. A bit later, I didn't quite like that and went more in the direction of something that isn't fully revealed yet. (If you're only first seeing this enemy.)"
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
    //Look at player
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    //Fire at player
    gunShot+=1
    if gunShot=gunDelay
    {
      var tAfterI;
      tAfterI=instance_create(x,y,oEnemyAfterImage)
      tAfterI.sprite_index=sprite_index; tAfterI.image_blend=c_blue
      tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.05
      tAfterI.xScaling=0.04; tAfterI.yScaling=0.04; tAfterI.xShift=0; tAfterI.yShift=0
      tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
    }
    else if gunShot=gunDelay+20
    {
      playSound(global.snd_SniperShot,0,0.95,1)
      var tNewAttack,tDir;
      tDir=point_direction(x+(31*image_xscale),y-22,oPlayer1.x,returnPlayerYCenter())
      tNewAttack=instance_create(x+(31*image_xscale),y-22,oC_SniperBullet)
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
      tNewAttack.decayTime=-100;
      if !collision_line(x+(31*image_xscale),y-22,oPlayer1.x,returnPlayerYCenter(),oSolid,1,1)
      {
        tNewAttack.direction=tDir
        tNewAttack.seekProg=2
      }
      else
      {
        if image_xscale=1 {tNewAttack.direction=0}
        else {tNewAttack.direction=180}
        tNewAttack.seekProg=0
      }
      gunShot=0
    }

    yVel+=0.25
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim mod 2=0
    {
      tEffect=instance_create(x+random_range(-13,13),y-random(28),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    }
    image_alpha-=0.025
    if image_alpha<0.5
    {
      playSound(global.snd_BombExplode,0,0.92,1)
      tEffect=instance_create(x,y-13,oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_create(x,y,oCHAOS_DeadSniper)
      instance_destroy()
    }
  }
  enemyStepEvent()
}
