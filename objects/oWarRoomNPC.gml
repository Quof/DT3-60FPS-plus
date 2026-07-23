#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-36,12,-1)
image_alpha=0
image_speed=0

damageType="NORMAL"
weaponTag=107
atkPower=25
stunTime=1
bCanPierce=1
weaponRehitTime=30

npcTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  npcTime+=1
  if type=1 //------------------------------ Arthur ------------------------------
  {
    if npcTime=1
    {
      var distCheck,tAttack;
      if instance_exists(oEnemyBase) {distCheck=instance_nearest(oPlayer1.x,oPlayer1.y-26,oEnemyBase)}
      else {distCheck=oPlayer1}
      x=distCheck.x; y=oPlayer1.y
      if !collision_point(x,y+4,oSolid,0,1) {y+=4}
      sprite_index=sNPC_Arthur_Lightning
      tAttack=instance_create(x,-16,oArthurLightning)
      tAttack.type=0; tAttack.ownerID=id
    }
    else if npcTime>=2 and npcTime<=11 {image_alpha+=0.1}
    else if npcTime=1010 {sprite_index=sNPC_Arthur_Idle; image_speed=0.12}
    else if npcTime>=1035
    {
      image_alpha-=0.05
      if image_alpha<=0 {instance_destroy()}
    }
  }
  else if type=2 //------------------------------ Battletoad ------------------------------
  {
    if npcTime=1
    {
      var distCheck;
      if instance_exists(oEnemyBase) {distCheck=instance_nearest(oPlayer1.x,oPlayer1.y-26,oEnemyBase)}
      else {distCheck=oPlayer1}
      x=distCheck.x; y=-16
      sprite_index=sNPC_Battletoad_Fist; image_alpha=1
      if x>distCheck.x {image_xscale=-1}
      xVel=2*image_xscale; yVel=6
      atkPower=100
    }
    else if npcTime>=2 and npcTime<=99 //Slam down
    {
      if yVel<9 {yVel+=0.2}
      if isCollisionBottom(1) or isCollisionSolid()
      {
        xVel=0; yVel=0
        tAttack=instance_create(x,y,oBattletoadSmashwave)
        npcTime=100
      }
      moveTo(xVel,yVel)
    }
    else if npcTime=110 {sprite_index=sNPC_Battletoad_Idle; image_speed=0.12}
    else if npcTime=140 //Check if an enemy is close enough and kick
    {
      if instance_exists(oEnemyBase)
      {
        var enemyCheck,tCheckX,tCheckY;
        enemyCheck=instance_nearest(x,y,oEnemyBase)
        tCheckX=point_distance(x,0,enemyCheck.x,0)
        tCheckY=point_distance(0,y,0,enemyCheck.y)
        if tCheckX<=96 and tCheckX<=96 and y>enemyCheck.y
        {
          if x<enemyCheck.x {image_xscale=1}
          else {image_xscale=-1}
          sprite_index=sNPC_Battletoad_Foot; image_index=0; image_speed=0
          y-=2
          xVel=4*image_xscale; yVel=-8
        }
      }
      npcTime=500
    }
    else if npcTime>=500 and npcTime<=999 //Land
    {
      if npcTime=504 {image_index=1}
      else if npcTime=508 {image_index=2}
      yVel+=0.3
      if isCollisionBottom(1) or isCollisionSolid()
      {
        sprite_index=sNPC_Battletoad_Idle; image_speed=0.12
        npcTime=1000
      }
      moveTo(xVel,yVel)
    }
    else if npcTime>=1025
    {
      image_alpha-=0.05
      if image_alpha<=0 {instance_destroy()}
    }
  }
  else if type=3 //------------------------------ Firebrand ------------------------------
  {
    if npcTime=1
    {
      x=oPlayer1.x-(72*oPlayer1.image_xscale); y=oPlayer1.y
      sprite_index=sNPC_Firebrand_Idle; image_alpha=1; image_speed=0.12
      while (collision_point(x,y+4,oSolid,0,1)) {y-=4} //Pull object out of the ground
      while (!collision_point(x,y+4,oSolid,0,1)) {y+=4} //Push object to the ground
      var tNewAtk;
      tNewAtk=instance_create(x,y,oFirebrandFirewave)
      fireAmt=0
    }
    else if npcTime=45
    {
      var tNewAtk,enemyCheck,dirCheck;
      if instance_exists(oEnemyBase)
      {
        enemyCheck=instance_nearest(x,y,oEnemyBase)
        sprite_index=sNPC_Firebrand_Fire
        if x<enemyCheck.x {image_xscale=1; dirCheck=0}
        else {image_xscale=-1; dirCheck=180}
        tNewAtk=instance_create(x+(11*image_xscale),y-27,oFirebrandDemonFire)
        tNewAtk.moveSpd=7; tNewAtk.direction=dirCheck; tNewAtk.image_xscale=image_xscale
      }
    }
    else if npcTime=50
    {
      sprite_index=sNPC_Firebrand_Idle
      fireAmt+=1
      if fireAmt>=4 {npcTime=55}
      else {npcTime=35}
    }
    else if npcTime>=61 and npcTime<=70 {image_alpha-=0.1}
    else if npcTime>=71 {instance_destroy()}
  }
  else if type=4 //------------------------------ Goemon ------------------------------
  {
    if npcTime=1
    {
      x=oPlayer1.x+(72*oPlayer1.image_xscale); y=oPlayer1.y
      sprite_index=sNPC_Goemon_Idle; image_alpha=1; image_speed=0.33
      while (collision_point(x,y+4,oSolid,0,1)) {y-=4} //Pull object out of the ground
      while (!collision_point(x,y+4,oSolid,0,1)) {y+=4} //Push object to the ground
      var tEffect,tXspd;
      for(i=0;i<16;i+=1)
      {
        tXspd=random_range(-2.25,2.25)
        tEffect=instance_create(x+random_range(-12,12),y-2-random(16),oEffectGrav)
        tEffect.type=2; tEffect.sprite_index=sFallingLeaf; tEffect.newBlend=-1
        tEffect.fadeSpd=0.05; tEffect.followID=-1; tEffect.grav=0.4; tEffect.xSpd=tXspd
        tEffect.ySpd=-1-random(4); tEffect.rotation=tXspd*4; tEffect.image_blend=make_color_rgb(200,0,200)
      }
    }
    else if npcTime=37 {sprite_index=sNPC_Goemon_Throw; image_index=0}
    else if npcTime>=40 and npcTime<=90 //Throw coins
    {
      if npcTime mod 10=0
      {
        var tNewAtk,enemyCheck,dirCheck;
        if instance_exists(oEnemyBase)
        {
          enemyCheck=instance_nearest(x,y-16,oEnemyBase)
          if x<enemyCheck.x {image_xscale=1}
          else {image_xscale=-1}
          dirCheck=point_direction(x+(10*image_xscale),y-16,enemyCheck.x,enemyCheck.y-16)
        }
        else
        {
          if image_xscale=1 {dirCheck=0}
          else {dirCheck=180}
        }
        tNewAtk=instance_create(x+(10*image_xscale),y-16,oGoemonCoin)
        tNewAtk.moveSpd=9; tNewAtk.direction=dirCheck
      }
    }
    else if npcTime=92 {sprite_index=sNPC_Goemon_Idle}
    else if npcTime>=105
    {
      var tEffect,tXspd;
      for(i=0;i<16;i+=1)
      {
        tXspd=random_range(-2.25,2.25)
        tEffect=instance_create(x+random_range(-12,12),y-2-random(16),oEffectGrav)
        tEffect.type=2; tEffect.sprite_index=sFallingLeaf; tEffect.newBlend=-1
        tEffect.fadeSpd=0.05; tEffect.followID=-1; tEffect.grav=0.4; tEffect.xSpd=tXspd
        tEffect.ySpd=-1-random(4); tEffect.rotation=tXspd*4; tEffect.image_blend=make_color_rgb(200,0,200)
      }
      instance_destroy()
    }
  }
  else if type=5 //------------------------------ Ristar ------------------------------
  {
    if npcTime=1
    {
      bCanDealDamage=0
      barrierFrm=0; barrierAlpha=0
      x=oPlayer1.x; y=oPlayer1.y
      while (!collision_point(x,y+4,oSolid,0,1)) {y+=4} //Push object to the ground
      sprite_index=sNPC_Ristar_Idle; image_speed=0.12; image_alpha=1
    }
    else if npcTime=15
    {
      sprite_index=sNPC_Ristar_ShieldDance; image_speed=0.2
      oPlayer1.bCanTakeDamage=false
    }
    else if npcTime>=16 and npcTime<=30 {barrierAlpha+=0.025}
    else if npcTime>=201 and npcTime<=299
    {
      barrierAlpha-=0.01
      if barrierAlpha<=0 {npcTime=300}
    }
    else if npcTime>=301 and npcTime<=320
    {
      if npcTime=301 {oPlayer1.bCanTakeDamage=true}
      image_alpha-=0.05
    }
    else if npcTime>=321 {instance_destroy()}
  }
  else if type=6 //------------------------------ Sparkster ------------------------------
  {
    if npcTime=1
    {
      var distCheck;
      if instance_exists(oEnemyBase) {distCheck=instance_nearest(oPlayer1.x,oPlayer1.y-128,oEnemyBase)}
      else {distCheck=oPlayer1}
      x=view_xview[0]-48; y=distCheck.y-16
      sprite_index=sNPC_Sparkster_Fly; image_alpha=1
      atkPower=200
    }
    else if npcTime>=2
    {
      x+=9
      var tEffect;
      tEffect=instance_create(x-11,y-14,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sSamusSMissileEffect; tEffect.newBlend=-1;
      tEffect.speed=random(1)+1; tEffect.friction=random(0.0125)+0.0125; tEffect.image_speed=0.2
      tEffect.fadeSpd=0.05; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      tEffect.direction=random_range(178,182)
      if npcTime>=91 and npcTime<=100 {image_alpha-=0.1}
      else if npcTime>=101 {instance_destroy()}
    }
  }
  else if type=7 //------------------------------ The Master (Actraiser) ------------------------------
  {
    if npcTime=1
    {
      var distCheck;
      if instance_exists(oEnemyBase) {distCheck=instance_nearest(oPlayer1.x,oPlayer1.y-52,oEnemyBase)}
      else {distCheck=oPlayer1}
      x=distCheck.x; y=-16
      sprite_index=sNPC_TheMaster_Dive; image_alpha=1
      if x>distCheck.x {image_xscale=-1}
      xVel=2*image_xscale; yVel=6
      atkPower=100
    }
    else if npcTime>=2 and npcTime<=99 //Slam down
    {
      if yVel<9 {yVel+=0.2}
      if isCollisionBottom(1) or isCollisionSolid()
      {
        xVel=0; yVel=0
        sprite_index=sNPC_TheMaster_Idle
        npcTime=100
      }
      moveTo(xVel,yVel)
    }
    else if npcTime=110 {sprite_index=sNPC_TheMaster_SwordUp}
    else if npcTime=114 {image_index=1}
    else if npcTime=118 {image_index=2}
    else if npcTime=125
    {
      var tNewAtk,enemyCheck,dirCheck;
      if instance_exists(oEnemyBase)
      {
        enemyCheck=instance_nearest(x,y-16,oEnemyBase)
        if x<enemyCheck.x {image_xscale=1}
        else {image_xscale=-1}
        dirCheck=point_direction(x+(33*image_xscale),y-65,enemyCheck.x,enemyCheck.y-16)
      }
      else
      {
        if image_xscale=1 {dirCheck=0}
        else {dirCheck=180}
      }
      tNewAtk=instance_create(x+(33*image_xscale),y-65,oTheMasterLightning)
      tNewAtk.moveSpd=3; tNewAtk.direction=dirCheck
    }
    else if npcTime>=136 and npcTime<=145 {image_alpha-=0.1}
    else if npcTime>=146 {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if type=5 and npcTime>=15 //Ristar barrier
{
  draw_set_alpha(0.15)
  draw_set_color(c_blue)
  draw_line(x,y-12,oPlayer1.x,returnPlayerYCenter())
  barrierFrm+=0.25
  draw_sprite_ext(sWaterBarrier,barrierFrm,oPlayer1.x,returnPlayerYCenter(),1.25,1.25,0,c_white,barrierAlpha)
}
