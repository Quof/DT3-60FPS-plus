#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Bone Pillar"
eLevel=14
maxLife=380
life=maxLife
pointWorth=16
atkPower=5
resType[1]=2
resType[2]=4
resType[3]=1
resType[4]=4
stunResist=5
baseItemChance=60
baseDropIndex=80
moneyWorth=5
affiliation=3
dieEffect=0
colorFlash=0

shotTime=55
shotDelay=85
shotCount=0

deathAnim=0
dthTopX=0; dthTopVelX=random_range(-2.5,2.5)
dthTopY=0; dthTopVelY=-5-random(2)
dthTopAng=0; dthTopTurn=random_range(-6,6)
dthBottomX=0; dthBottomVelX=random_range(-1.5,1.5)
dthBottomY=0; dthBottomVelY=-2-random(1)
dthBottomAng=0; dthBottomTurn=random_range(-2,2)

if room=rBT_BonePillar
{
  pointWorth=0
  baseItemChance=-100
  bNoBonus=true
}

jeremyText="Remember these? Well they're back. Same as before, when you see them flash, they're about to fire off a... well some fire. They have a lot of HP, so I recommend using their weakness if you have it available."
chaoText="The Bone Pillar, also known as the 'Pillar of Bones,' has been a thorn in the side of many heroes in the Castlevania series, and is infamous for doing nothing more than standing still and breathing fire."
devText="I had a lot of fun thinking up the death animations for enemies like this. I feel just a simple detail like that can add a lot of charm to something. Plus it's just more satisfying to see these explode the way they do than to simply fade out as DT1 did to almost every enemy type."
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
    if shotTime>=shotDelay-20 and shotCount=0
    {
      if oGame.time mod 3=0
      {
        colorFlash+=1
        if colorFlash mod 2=0
          image_blend=c_silver
        else
          image_blend=c_white
      }
    }
    if shotTime>=shotDelay
    {
      image_blend=c_white
      var tNewAttack,offsetShotX,offsetShotY,shotDir;
      if image_xscale=1
      {
        if x>=oPlayer1.x
        {
          shotDir=180
          offsetShotX=lengthdir_x(33,image_angle+90)
          offsetShotY=lengthdir_y(33,image_angle+90)
        }
        else
        {
          shotDir=0
          offsetShotX=lengthdir_x(14,image_angle+90)
          offsetShotY=lengthdir_y(14,image_angle+90)
        }
      }
      else
      {
        if x>=oPlayer1.x
        {
          shotDir=180
          offsetShotX=lengthdir_x(14,image_angle+90)
          offsetShotY=lengthdir_y(14,image_angle+90)
        }
        else
        {
          shotDir=0
          offsetShotX=lengthdir_x(33,image_angle+90)
          offsetShotY=lengthdir_y(33,image_angle+90)
        }
      }

      tNewAttack=instance_create(x+offsetShotX,y+offsetShotY,oNormalBullet)
      tNewAttack.sprite_index=sSkelefire; tNewAttack.atkPower=atkPower; tNewAttack.damageType="ELEMENTAL"
      tNewAttack.bulletSpeed=6; tNewAttack.image_speed=0.5; tNewAttack.direction=shotDir+image_angle

      shotCount+=1
      if shotCount=1
        shotTime-=18
      else
      {
        shotCount=0
        shotTime=0
      }
    }
    else
      shotTime+=1
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_BombExplode,0,0.9,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x-14+dthTopX+random(14),y-45+dthTopY+random(14),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x-14+dthBottomX+random_range(-10,10),y-30+dthBottomY+random_range(-10,10),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    dthTopX+=dthTopVelX
    dthTopY+=dthTopVelY; dthTopVelY+=0.2
    dthTopAng+=dthTopTurn
    dthBottomX+=dthBottomVelX
    dthBottomY+=dthBottomVelY; dthBottomVelY+=0.1
    dthBottomAng+=dthBottomTurn
    image_alpha-=0.025
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 {event_inherited()}
else
{
  //Top
  draw_sprite_general(sprite_index,image_index,0,0,28,14,x-14+dthTopX,y-45+dthTopY,1,1,dthTopAng,c_white,c_white,c_white,c_white,image_alpha)
  //Bottom
  draw_sprite_general(sprite_index,image_index,0,16,28,29,x-14+dthBottomX,y-30+dthBottomY,1,1,dthBottomAng,c_white,c_white,c_white,c_white,image_alpha)
}
