#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-76,16,-1)
image_speed=0.15
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="Lv.?? The Stone Golem"
eLevel=28
maxLife=6500
life=maxLife
atkPower=14
resType[3]=2
damageType="ELEMENTAL"
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=6
dieEffect=0
bossProgress=0
activateBoss=0

hammerTime=10
hammerDelay=60
jumpAtk=0
rockFall=0
rockDuration=42

bCanBeBlocked=1
bParryOpp=0
blockCost=65
//--------------------

//Misc Data
xCenter=416
yGround=288
roomSpan=224

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    jeremyText="Oh man, so this guy doesn't have much to him, but you get very few mistakes, as he hits HARD. Harder than anything else you've faced. Its behavior is simple, he won't use the hammer unless you get close, he'll just wait for you. After that though, if you're far enough, he'll leap at you. An issue that you may run into is being cornered. It's not hopeless, there has to be something you can abuse to get out of that situation."
    chaoText="This is from Demon Hunter Legend.#Since it seems Jeremy didn't mention everything, I'll cover some other stuff. If you're attacking it from the front, your attacks will deal half damage, unless of course you utilize the parry mechanic."
    devText="This enemy has one of the highest damage outputs in the game, although he's very slow and predictable, so that shouldn't be too much of a problem."
    extraInfo="Has massive damage output."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if sprite_index=sPT_StoneGolem_Idle
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //---------- Hammer Slam ----------
    hammerTime+=1
    if hammerTime>=hammerDelay
    {
      if hammerTime=hammerDelay //Change anim
      {
        if point_distance(x,0,oPlayer1.x,0)<96
        {
          instance_create(x-(33*image_xscale),y-85,oG6_CounterSpark)
          xVel=0
          sprite_index=sPT_StoneGolem_Ready
          image_speed=0; image_index=0
        }
        else
        {
          if jumpAtk=1
          {
            xVel=0
            sprite_index=sPT_StoneGolem_Ready
            image_speed=0; image_index=0
            y-=4
            yVel=-10
            xVel=3*image_xscale
            jumpAtk=2
          }
          else {hammerTime=hammerDelay-5}
        }
      }
      if jumpAtk<2 //Normal attack
      {
        if hammerTime=hammerDelay+20
        {
          rockFall=1
          playSound(global.snd_HardHit1,0,1,1)
          if (image_xscale=1 and x<xCenter+roomSpan-48) or (image_xscale=-1 and x>xCenter-roomSpan+48) {x+=32*image_xscale}
          bParryOpp=1
          sprite_index=sPT_StoneGolem_Slam
          var tEffect;
          tEffect=instance_create(x+(image_xscale*58),y,oEffect)
          tEffect.sprite_index=sGroundBlast; tEffect.image_speed=0.75; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        else if hammerTime>=hammerDelay+28 //End attack
        {
          bParryOpp=0
          sprite_index=sPT_StoneGolem_Idle
          image_speed=0.15
          jumpAtk=1
          hammerTime=0
        }
      }
      else if jumpAtk=2 //Jump attack
      {
        if bParryOpp=0
        {
          if yVel>0
          {
            sprite_index=sPT_StoneGolem_Slam
            bParryOpp=1
          }
        }
      }
    }

    if rockFall>0
    {
      rockFall+=1
      if rockFall mod 6=0
      {
        var tEffect,tNewAttack,tXX;
        if rockFall mod 18=0 {tXX=oPlayer1.x}
        else {tXX=xCenter-(roomSpan+8)+random((roomSpan*2)-8)}
        for(i=0;i<4;i+=1)
        {
          tEffect=instance_create(tXX+random_range(-8,8),y-192+random_range(-8,8),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.decay=-100
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.image_alpha=0.75

          tEffect=instance_create(tXX+random_range(-12,12),y-192+random_range(-2,2),oEffectGrav)
          tEffect.sprite_index=sDTitanRock; tEffect.xSpd=random_range(-0.25,0.25); tEffect.ySpd=1.5+random(1.5); tEffect.fadeSpd=0.07
          tEffect.type=2; tEffect.grav=0.4+random(0.2); tEffect.rotation=0; tEffect.newBlend=-1; tEffect.followID=-1
          tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
        }

        tNewAttack=instance_create(tXX,y-192,oGravPassBullet)
        tNewAttack.sprite_index=sDTitanRock; tNewAttack.atkPower=atkPower-4
        tNewAttack.xVel=0; tNewAttack.yVel=1; tNewAttack.damageType="ELEMENTAL"
      }
      if rockFall>=rockDuration {rockFall=0}
    }

    yVel+=0.5
    if isCollisionBottom(1)
    {
      yVel=0
      if jumpAtk=2
      {
        bParryOpp=0
        playSound(global.snd_HardHit1,0,1,1)
        sprite_index=sPT_StoneGolem_Idle
        image_speed=0.15
        var tEffect;
        tEffect=instance_create(x+(image_xscale*58),y,oEffect)
        tEffect.sprite_index=sGroundBlast; tEffect.image_speed=0.75; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        xVel=0
        jumpAtk=0
        hammerTime=0
      }
    }
    if isCollisionLeft(1)
    {
      if jumpAtk=2
      {
        xVel=3
        image_xscale=1
      }
    }
    if isCollisionRight(1)
    {
      if jumpAtk=2
      {
        xVel=-3
        image_xscale=-1
      }
    }
    if isCollisionSolid()
      y-=2
    moveTo(xVel,yVel)
    if y>room_height+24
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.7 and lifePercent>=0.31 and bossProgress=0
    {
      hammerDelay-=5
      rockDuration+=6
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0 and bossProgress=1
    {
      hammerDelay-=5
      rockDuration+=6
      bossProgress+=1
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      sprite_index=sPT_StoneGolem_Idle
      image_speed=0
    }
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-11,11),y-2-random(72),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.02
    if image_alpha<0.5
    {
      if global.bBossGallery=1
      {
        bossRoomTally(41)
        global.newMapX=2680; global.newMapY=464; room_goto(rBossGallery)
      }
      else
      {
        playSound(global.snd_BombExplode,0,1,1)
        var tEffect;
        for(i=0;i<48;i+=1)
        {
          tEffect=instance_create(x+random_range(-20,20),y-random(sprite_height),oEffectGrav)
          tEffect.sprite_index=sDTitanRock; tEffect.xSpd=random_range(-4,4); tEffect.ySpd=-7+random(2); tEffect.fadeSpd=0.02
          tEffect.type=2; tEffect.grav=0.5; tEffect.rotation=0; tEffect.newBlend=-1; tEffect.followID=-1
          tEffect.image_xscale=0.33; tEffect.image_yscale=0.33
        }
        oEvCh15MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if enemyDeflect(1,1,1,1,1,1)=1 and global.stJGame_C[0]<4000
{
  resType[0]=2
  event_inherited()
  resType[0]=3
}
else {event_inherited()}
