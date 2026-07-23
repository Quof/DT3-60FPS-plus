#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-14,7,-1)
image_speed=0.33

//Enemy base statistics
eName="Bago Bago"
eLevel=7
maxLife=125
life=maxLife
pointWorth=9
atkPower=5
resType[1]=1
resType[2]=5
resType[3]=1
resType[5]=5
baseItemChance=25
pickupDropMod=10
moneyWorth=0
affiliation=2
bGenEnemy=1
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

initDir=0
runAcc=2
flyVel=5
if x>oPlayer1.x
{
  image_xscale=-1
  flyVel=-5
}
airVel=-11
shotTime=20
shotDelay=90
jeremyText="These come up from water or lava below bridges, will land on them, then start firing projectiles toward you. I recommend taking it slow when you come to a gap or you might come face first into one and down you go."
chaoText="... ... ..."
devText="Having the Gate 2 overworld like it is, was actually Slaix' idea. I had to agree with his reasoning and it all turned out a lot better because I went with that. The random encounters were also his idea, which he said would be humorous to have in just to see Jerry bitch about them."
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
    shotTime+=1
    if shotTime>=shotDelay
    {
      var tNewAttack,tOffsetShotX;
      if image_xscale=1
        tOffsetShotX=4
      else
        tOffsetShotX=-4
      tNewAttack=instance_create(x+tOffsetShotX,y-8,oNormalBullet)
      tNewAttack.sprite_index=sOctorokRock
      tNewAttack.atkPower=atkPower
      tNewAttack.bulletSpeed=7
      tNewAttack.image_speed=0.33
      if image_xscale=1
        tNewAttack.direction=0
      else
        tNewAttack.direction=180
      shotTime=0
    }

    if initDir=0 //Rising
    {
      x+=flyVel
      y+=airVel
      airVel+=0.3
      if airVel>=2
      {
        xVel=flyVel
        initDir=1
      }
    }
    else
    {
      yVel+=0.3
      if isCollisionBottom(1)
      {
        yVel=0
        if initDir=1
        {
          xVel=runAcc
          if x>oPlayer1.x
            xVel*=-1
          initDir=2
        }
      }
      if isCollisionLeft(1)
        xVel=runAcc
      if isCollisionRight(1)
        xVel=-runAcc
      if isCollisionTop(1)
        yVel=0.5

      if xVel>0
        image_xscale=1
      else
        image_xscale=-1

      moveTo(xVel,yVel)
      if isCollisionSolid()
      {
        if image_xscale=1 {x+=runAcc}
        else {x-=runAcc}
      }

      if y>room_height+32
      {
        if questType>0
          enemyQuest(questType)
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
