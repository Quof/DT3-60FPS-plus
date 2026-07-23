#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-46,16,-1)
animSpd=0.2
image_speed=0

//Enemy base statistics
eName="Stalfos"
eLevel=10
maxLife=660
life=maxLife
pointWorth=26
atkPower=6
resType[0]=2
resType[1]=1
resType[3]=1
resType[5]=4
stunResist=12
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=4
bIsBoss=true
bNoBonus=true

initDir=0
runAcc=2
minDistToPlayer=88
bBroken=0
fixTime=0
xShake=0

atkTime=40
atkDelay=75

deathAnim=0

jeremyText="There's an iconic enemy. These guys are pretty stupid though. It'll try to keep itself at an optimal distance though and I wonder how much we'll see of that... Anyway, when you see his sword raised, he's about to do a dashing sword strike. If you're too close at the start of this, like the Wolfos, he'll dash back a tiny bit. Oh yeah, you should know how to finish them off after they fall; if you don't do it in time, they'll get back up."
chaoText="These guys are present in a lot of the Zelda games. I always liked the Stalfos from Ocarina of Time the most. In 2 on 1 fights, the one you weren't engaging with tended to not attack you. They were fallen Hyrule warriors if I remember right, and even though they were undead, I felt like they still wanted to fight with honor."
devText="Making this level with the upside down variants was tricky at times. There's a specific way I designed for the player to get through it, and every time I changed one thing to help dictate that route, it tended to make the level impossible. Making sure that by opening up another route didn't break this intended flow was challenging, but I found ways to make the level better through those iterations."
extraInfo="Vulnerable just before attacking."
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
    if bBroken=0
    {
      //---------- Movement ----------
      if atkTime<atkDelay
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}

        if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)>minDistToPlayer+(minDistToPlayer/5)
        {
          image_index+=animSpd
          sprite_index=sStalfosWalk
          if image_xscale=1 {xVel=runAcc}
          else {xVel=-runAcc}
        }
        else if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<minDistToPlayer
        {
          image_index-=animSpd
          sprite_index=sStalfosWalk
          if image_xscale=1 {xVel=-runAcc}
          else {xVel=runAcc}
        }
        else
        {
          image_index+=animSpd
          sprite_index=sStalfosIdle
          xVel=0
        }
      }
      else //Slow down back-dash
      {
        if atkTime>=atkDelay+1
        {
          if xVel>0 {xVel-=0.5}
          else if xVel<0 {xVel+=0.5}
        }
      }

      //---------- ATTACK: Sliding Sword Strike ----------
      atkTime+=1
      if atkTime>=atkDelay
      {
        if atkTime=atkDelay //change anim and step back if too close to player
        {
          xVel=0
          sprite_index=sStalfosSwing
          image_index=0
          resType[0]=3; resType[1]=3
          if findTargetX<96 //player is close
          {
            var tDash;
            tDash=1
            if aiCheckHoriz(1,4,-16,-4,4)=1
              tDash=0

            if tDash=1 //dash if able to
            {
              if image_xscale=1 {xVel=-4}
              else {xVel=4}
            }
          }
        }
        else if atkTime=atkDelay+16 //Dash forward
        {
          resType[0]=2; resType[1]=1
          var tNewAtk;
          if image_xscale=1 {xVel=11}
          else {xVel=-11}
          image_index=1
        }
        else if atkTime=atkDelay+25 {image_index=2}
        else if atkTime=atkDelay+28 {image_index=3}
        else if atkTime=atkDelay+34 //End attack
        {
          atkTime=0
        }
      }
    }
    else if bBroken=1 //Time before rising again
    {
      fixTime+=1
      if fixTime>=155 and fixTime<=184 //Shake
      {
        if oGame.time mod 2=0
        {
          if xShake=1 {xShake=-1}
          else {xShake=1}
        }
      }
      else if fixTime>=185
      {
        maxLife=330
        life=maxLife
        sprite_index=sStalfosIdle
        xShake=0
        bCanDealDamage=true
        bCanTakeDamage=true
        for(i=0;i<6;i+=1) {resType[i]=3}
        resType[0]=2
        resType[1]=1
        resType[3]=1
        resType[5]=4
        bBroken=0
      }
    }
    else if bBroken=2
    {
      deathAnim+=1
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      if deathAnim mod 3=0
      {
        tEffect=instance_create(x+random_range(-13,13),y+random(-32),oEffect)
        tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
        tEffect.image_alpha=0.5+(image_alpha/3)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      image_alpha-=0.04
      if image_alpha<0
      {
        bNoBonus=false
        enemyDefeat(0,0)
        internetzDrop(1)
        instance_destroy()
      }
    }

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1) and bBroken=0
      xVel=runAcc
    if isCollisionRight(1) and bBroken=0
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  else if life<=0
  {
    if bBroken=0
    {
      maxLife=100000
      life=maxLife
      sprite_index=sStalfosBroken
      bCanTakeDamage=true
      var tEffect,tXScl,tYScl;
      tXScl=choose(-1,1); tYScl=choose(-1,1)
      for(i=0;i<12;i+=1)
      {
        tEffect=instance_create(x+random_range(-13,13),y+random(-32),oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.33; tEffect.image_xscale=tXScl; tEffect.image_yscale=tYScl
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      for(i=0;i<6;i+=1) {resType[i]=1}
      resType[4]=5
      xVel=0
      fixTime=0
      life=maxLife
      global.recKillCount-=1
      bBroken=1
    }
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bBroken=1
{
  if other.damageType="EXPLOSION"
  {
    bBroken=2
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x+xShake,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
