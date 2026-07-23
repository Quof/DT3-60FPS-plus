#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-11,16,9)
bCanDealDamage=false
bCauseKnockback=false

//Enemy base statistics
eName="Metroid"
eLevel=24
maxLife=330
life=maxLife
pointWorth=36
atkPower=1
resType[0]=1
resType[1]=1
resType[4]=2
stunResist=3
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
bIsBoss=true
bNoBonus=true

frmBrain=0
animFang=0
frmFang=0

latching=0
lifeDrain=0
moveSpd=5.5
blastSpd=0
blastDir=0
frozen=0
frozenTime=0
unlatchTime=0
makeSound=0

deathAnim=0

jeremyText="Like I said before, you'll need to hit them enough for the freeze effect to kick in. These deal damage just like Metroids originally do. It'll latch onto your head and the only way to get them off is to either leave the room or bomb them off. Be aware that more than one Metroid can latch itself onto you here."
chaoText="In Metroid game lore, it's said that the Chozo genetically engineered the Metroids in order to prevent the spread of X Parasites. In their language, Metroid means 'Ultimate Warrior'."
devText="The DT engine isn't set up to have enemies with collision or anything like a freeze state, but local scripts made it possible and very workable. I knew they only took 1 shot to freeze normally, but with DT's mobility, they simply weren't challenging or scary at all."
extraInfo="Standard tracking capabilities."
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
    if makeSound=0 {makeSound=1} //Delay by 1 frame
    else if makeSound=1
    {
      playSound(global.snd_MetGeep,0,1,22050+random(11025))
      makeSound=2
    }

    if frozen=0
    {
      frmBrain+=0.2
      animFang+=1
      if animFang=6 {frmFang=1}
      else if animFang=12 {frmFang=2}
      else if animFang=18 {frmFang=1}
      if animFang=24 {frmFang=0; animFang=0}

      if latching=0 //Normal movement
      {
        lifeDrain=0
        if x>oPlayer1.x and xVel>-5.5 {xVel-=0.33}
        else if x<oPlayer1.x and xVel<5.5 {xVel+=0.33}
        if y>oPlayer1.y and yVel>-5.5 {yVel-=0.33}
        else if y<oPlayer1.y and yVel<5.5 {yVel+=0.33}
        if isCollisionTop(1) {yVel=1}
        if isCollisionBottom(1) {yVel=-1}
        if isCollisionLeft(1) {xVel=1}
        if isCollisionRight(1) {xVel=-1}
        moveTo(xVel,yVel)
      }
      else if latching=1 //Latched onto player
      {
        x=oPlayer1.x
        y=oPlayer1.bbox_top-6
        lifeDrain+=1
        if global.difficulty=1 and global.bNightmareMode=0
        {
          if lifeDrain mod 16=0 {bCanDealDamage=true}
        }
        else
        {
          if lifeDrain mod 8=0 {bCanDealDamage=true}
        }
      }
      else if latching=2 //Blast away from the player after being hit with explosive type damage
      {
        blastSpd-=0.5
        moveTo(blastSpd*cos(degtorad(blastDir)),-blastSpd*sin(degtorad(blastDir)))
        if blastSpd<=5
        {
          xVel=0; yVel=0
          latching=3
        }
      }
      else if latching=3 //Slight wait before seeking player
      {
        unlatchTime-=1
        if unlatchTime<=0
        {
          latching=0
        }
      }
    }
    else if frozen>=1 and frozen<=15 //Delay frozen damage state to prevent a super missile from killing the metroid if it is the killing shot
    {
      frozen+=1
    }
    else if frozen>=16 and frozen<=20 //Frozen state
    {
      for(i=0;i<6;i+=1) {resType[i]=1}
      resType[5]=3
      bCanTakeDamage=true
      life=maxLife
      unlatchTime=0
      frozenTime+=1
      if frozenTime>=180 and frozenTime mod 2=0
      {
        if image_blend=baseColor {image_blend=c_red}
        else {image_blend=baseColor}
      }
      if frozenTime>=240
      {
        with mySolid {instance_destroy()} //Destroy solid from frozen state
        for(i=0;i<6;i+=1) {resType[i]=3}
        resType[0]=1
        resType[1]=1
        resType[4]=2
        life=round(maxLife/3)
        baseColor=c_white
        image_blend=baseColor
        bCanDealDamage=true
        stunResist=3
        frozenTime=0
        frozen=0
      }
    }
    else if frozen>=21
    {
      deathAnim+=1
      if deathAnim=1 //Destroy solid from frozen state
      {
        with mySolid {instance_destroy()}
      }
      image_speed=0
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      if deathAnim mod 3=0
      {
        tEffect=instance_create(x+random_range(-14,14),y+random_range(-20,20),oEffect)
        tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
        tEffect.image_alpha=0.5+(image_alpha/3)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      image_alpha-=0.04
      if image_alpha<0
      {
        bNoBonus=false
        enemyDefeat(0,0)
        if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1] //Drops
        {
          //Force 1 missile
          var tWepDrop;
          tWepDrop=instance_create(bbox_left+2+random(sprite_width-4),bbox_top+2+random(sprite_height-4),oWeaponPickup)
          tWepDrop.sprite_index=sMetroidMissile
          if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]/2.5 //If under 50% missile capacity, 1 extra missile drops at 60% chance
          {
            var tItemCheck;
            tItemCheck=round(random(100))
            if tItemCheck<=60
            {
              var tWepDrop;
              tWepDrop=instance_create(bbox_left+2+random(sprite_width-4),bbox_top+2+random(sprite_height-4),oWeaponPickup)
              tWepDrop.sprite_index=sMetroidMissile
            }
          }
        }
        if oPlayer1.lifePercent<=0.8 //If under 80% HP, heart drops at 60% chance
        {
          var tItemCheck;
          tItemCheck=round(random(100))
          if tItemCheck<=60
          {
            var tHeartDrop;
            tHeartDrop=instance_create(bbox_left+2+random(sprite_width-4),bbox_top+2+random(sprite_height-4),oHealthPickup)
            tHeartDrop.sprite_index=sMetroidHealthPickup
          }
        }
        instance_destroy()
      }
    }
  }
  else if life<=0
  {
    if frozen=0
    {
      mySolid=instance_create(x,y,oSolid); mySolid.sprite_index=sMetroidMembrane; mySolid.visible=0
      baseColor=c_blue
      image_blend=baseColor
      life=maxLife
      global.recKillCount-=1
      latching=0
      stunResist=50
      stunnedTime=0
      frozen=1
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if frozen=0 and stunnedTime=0
{
  if latching=0
  {
    bCanTakeDamage=false
    lifeDrain=-1
    unlatchTime=15
    latching=1
  }
  else
  {
    if bCanDealDamage=true
    {
      redDmgHit(0)
      bCanDealDamage=false
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if frozen=0
{
  if latching=0 or latching=3 {event_inherited()}
  else if latching=1
  {
    if other.damageType="EXPLOSION"
    {
      bCanTakeDamage=true
      bCanDealDamage=false
      blastSpd=14
      blastDir=random_range(60,120)
      latching=2
    }
  }
}
else if frozen>=16 and frozen<=20
{
  if other.damageType="SPECIAL"
  {
    if other.sprite_index=sSamusSuperMissile {frozen+=5}
    else {frozen+=1}
    event_inherited()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sMetroidFangs,frmFang,x+1,y+9,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sMetroidFangs,frmFang,x-1,y+9,-image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sMetroidInnerds,frmBrain,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sMetroidMembrane,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
