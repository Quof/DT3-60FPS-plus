#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-34,8,-1)
image_speed=0.15

//Enemy base statistics
eName="Aquatic Demon"
eLevel=10
maxLife=310
life=maxLife
pointWorth=17
atkPower=5
resType[3]=4
resType[4]=4
stunResist=2
baseItemChance=60
baseDropIndex=80
affiliation=2
dieEffect=0
runAcc=1.25
weight=90
forceSwimUp=0
inactiveDist*=1.5

shotTime=50
shotDelay=100

deathAnim=0

jeremyText="These guys are capable on both land and in the water. Especially in the water. They're also capable of chasing you out of the water and onto land. If needed, they have a spit attack too."
chaoText="Everything here is so gross looking! Get them out of view!"
devText="The demo version of this level didn't have a map available. While the map doesn't show much, I was told it helps with understanding the layout and making sense of the doors."
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
    if x<oPlayer1.x
      image_xscale=1
    else
      image_xscale=-1

    if isCollisionWaterTop(-12) //-------------------- In Water --------------------
    {
      if shotTime<shotDelay
      {
        image_speed=0.2
        sprite_index=sAquaticDemonSwim

        findTargetX=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        if findTargetX>16
        {
          if !isCollisionWaterTop(-8) and oPlayer1.y<y
          {
            y-=4
            yVel=-6.5
            forceSwimUp=10
          }

          if forceSwimUp=0
          {
            dir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
            moveTo((runAcc*1.4)*cos(degtorad(dir)),-(runAcc*1.4)*sin(degtorad(dir)))
          }
          else
          {
            yVel+=0.3
            if isCollisionBottom(1)
              yVel=0
            if isCollisionLeft(1)
              xVel=runAcc
            if isCollisionRight(1)
              xVel=-runAcc
            if isCollisionTop(1)
              yVel=1

            moveTo(xVel,yVel)
            if isCollisionSolid()
              y-=2
          }
        }
      }
    }
    else //-------------------- On Land --------------------
    {
      if shotTime<shotDelay
      {
        findTargetX=point_distance(oPlayer1.x,0,x,0)
        if findTargetX>96
        {
          image_speed=0.15
          if image_xscale=1
            xVel=runAcc
          else
            xVel=-runAcc

          if yVel=0 //Jump up cliff
          {
            if aiCheckHoriz(0,2,16,16,-8)=1
            {
              y-=4
              yVel=-6.5
            }
          }
        }
        else
        {
          if yVel=0
            xVel=0
          shotTime+=1
          image_speed=0
          image_index=0
        }

        if yVel=0
          sprite_index=sAquaticDemonWalk
        else
          sprite_index=sAquaticDemonJump
      }
      else
      {
        if yVel=0
          xVel=0
      }

      yVel+=0.3
      if isCollisionBottom(1)
        yVel=0
      if isCollisionLeft(1)
        xVel=runAcc
      if isCollisionRight(1)
        xVel=-runAcc
      if isCollisionTop(1)
        yVel=1

      moveTo(xVel,yVel)
      if isCollisionSolid()
        y-=2

      if y>room_height+24
      {
        if questType>0
          enemyQuest(questType)
        instance_destroy()
      }
    }

    if forceSwimUp>0
      forceSwimUp-=1
    //---------- Spit Acid ----------
    if findTargetX<224 or shotTime>=shotDelay
      shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime>=shotDelay and shotTime<=shotDelay+4 //change anim
      {
        image_speed=0
        image_index=0
        if isCollisionWaterTop(-12)
          sprite_index=sAquaticDemonSShot
        else
          sprite_index=sAquaticDemonWShot
      }
      else if shotTime=shotDelay+13 //spit acid
      {
        if checkScreenArea(x,y,48)=1 {playSound(global.snd_LinkBomb,0,0.95,18000)}
        image_index=1
        var tNewAttack;
        tNewAttack=instance_create(x+(8*image_xscale),y-28,oGravityBullet)
        tNewAttack.sprite_index=sAquaDemonSpit; tNewAttack.image_xscale=image_xscale; tNewAttack.atkPower=atkPower
        tNewAttack.xVel=6*image_xscale; tNewAttack.yVel=-2
      }
      else if shotTime=shotDelay+20 //end attack
        shotTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-10,10),y-1-random(42),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
