#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-11,-30,11,-1)
image_speed=0
animSpd=0.175

//Enemy base statistics
eName="CHAOS Shock Unit"
eLevel=33
maxLife=670
life=maxLife
pointWorth=75
atkPower=9
resType[1]=4
resType[3]=1
stunResist=12
baseItemChance=70
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0

knifeHit=0
runAcc=3
bJumpReady=1
canDash=0
minDistToPlayer=112
shotTime=30
shotDelay=65
shotType=0
dropShield=0
bAssisted=0
findAlly=0
linkFrm=0

deathAnim=0

jeremyText="This guy will always try to keep his distance. The first thing he does is fire off a rocket fist, and then bring out a shield which blocks all projectiles. While the shield is active, its NORMAL type defense goes up by 1 factor. The rocket fist will locate your x-coordinate and then slam downward. After some of that, it'll return to the bot and this repeats."
chaoText="Remember those Advanced Turrets? When this has its shield out, the turret will sometimes stop its bomb dropping and instead fly behind the shield and fire its projectiles."
devText="This enemy type was originally going to show up just after the Vault chapter, but I found this to be a bit rough for that part of the game. This and its group all felt like end-game content and were going to be used for that as well, but I decided against introducing them early."

myRocket=noone
myShield=noone
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
    if shotTime<shotDelay //Facing direction
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //---------- Movement ----------
    if sprite_index=sCHAOS_ShockUnitIdle or sprite_index=sCHAOS_ShockUnitWalkA or sprite_index=sCHAOS_ShockUnitWalkB
    {
      if yVel=0 and bJumpReady=1 and shotTime<shotDelay and canDash<30
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}

        if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)>minDistToPlayer+(minDistToPlayer/5)
        {
          image_index+=animSpd
          if instance_exists(myRocket) {sprite_index=sCHAOS_ShockUnitWalkB}
          else {sprite_index=sCHAOS_ShockUnitWalkA}
          if image_xscale=1 {xVel=runAcc}
          else {xVel=-runAcc}
        }
        else if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<minDistToPlayer
        {
          image_index-=animSpd
          if instance_exists(myRocket) {sprite_index=sCHAOS_ShockUnitWalkB}
          else {sprite_index=sCHAOS_ShockUnitWalkA}
          if image_xscale=1 {xVel=-runAcc}
          else {xVel=runAcc}
        }
        else
        {
          if sprite_index!=sCHAOS_ShockUnitWalkB
          {
            image_index+=animSpd
            sprite_index=sCHAOS_ShockUnitIdle
          }
          xVel=0
        }
      }
    }

    if yVel=0 and bJumpReady=1
    {
      //---------- Check if wall and jump up ----------
      if aiCheckHoriz(0,3,16,16,-8)=1
      {
        y-=4
        yVel=-6.5
      }

      //---------- Check if cliff edge and jump ----------
      var tDrop;
      tDrop=0
      if aiCheckHoriz(1,1,0,16,4)
      {
        if aiCheckVert(0,3,24,16,4)=1 {tDrop=1}
      }

      if tDrop=0
      {
        sprite_index=sCHAOS_ShockUnitIdle
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }

    if canDash>0 {canDash-=1}
    if !instance_exists(myShield) or shotTime>shotDelay
    {
      //Dash back if player is too close
      if shotTime<shotDelay
      {
        if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<minDistToPlayer/1.75 and canDash=0
        {
          var tEffect;
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sGroundDust; tEffect.image_alpha=0.75; tEffect.image_speed=0.75
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          xVel=(runAcc*2)*-image_xscale
          canDash=40
        }
      }

      shotTime+=1
      if shotTime=shotDelay //Bring out rocket fist
      {
        if yVel=0
        {
          xVel=0
          sprite_index=sCHAOS_ShockUnitPunch
          myRocket=instance_create(x+(24*image_xscale),y-22,oCSU_RocketPunch)
          myRocket.atkPower=atkPower; myRocket.ownerID=id; myRocket.image_xscale=image_xscale
        }
        else {shotTime=shotDelay-10}
      }
      else if shotTime=shotDelay+35 //Set to WalkB
      {
        sprite_index=sCHAOS_ShockUnitWalkB; image_index=0
      }
      else if shotTime=shotDelay+45 //Summon shield
      {
        myShield=instance_create(x+(24*image_xscale),y-20,oCSU_Shield)
        myShield.ownerID=id; myShield.atkPower=atkPower
      }
      else if shotTime>=shotDelay+65 //Back to walking
      {
        shotTime=0
      }
    }

    if instance_exists(myShield) //Keep shield in place
    {
      myShield.x=x+(24*image_xscale)
      myShield.y=y-20
      if myShield.atkProg=1 {myShield.image_xscale=image_xscale*1.3}

      if dropShield=1
      {
        myRocket=0
        dropShield=2
      }
      else if dropShield=2 //Remove shield
      {
        myShield.image_xscale=0.1; myShield.image_yscale=0.1
        if myShield.image_xscale<=0.1
        {
          with myShield {instance_destroy()}
          myShield=0
          dropShield=0
        }
      }
    }

    //Resist changes
    if instance_exists(oCHAOS_Sabotage)
    {
      findAlly=instance_nearest(x,y,oCHAOS_Sabotage)
      if point_distance(x,y-19,findAlly.x,findAlly.y+27)<208 //Sabotage must be close enough
      {
        linkFrm+=0.33
        if instance_exists(myShield) {resType[0]=1}
        else {resType[0]=2}
        if knifeHit=1 {resType[1]=2}
        else {resType[1]=3}
        bAssisted=1
      }
      else //Sabotage not close enough
      {
        if instance_exists(myShield) {resType[0]=2}
        else {resType[0]=3}
        if knifeHit=1 {resType[1]=3}
        else {resType[1]=4}
        bAssisted=0
      }
    }
    else //No Sabotage around
    {
      if instance_exists(myShield) {resType[0]=2}
      else {resType[0]=3}
      if knifeHit=1 {resType[1]=3}
      else {resType[1]=4}
      bAssisted=0
    }

    yVel+=0.3
    if isCollisionBottom(1)
    {
      if yVel>0 {bJumpReady=1}
      yVel=0
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionTop(1)
      yVel=0.1

    moveTo(xVel,yVel)
    if isCollisionSolid() {y-=2}
    if y>room_height+24
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sCHAOS_ShockUnitDefeat
      if instance_exists(myRocket) {with myRocket {instance_destroy()}}
      if instance_exists(myShield) {with myShield {instance_destroy()}}
    }
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-8,8),y-1-random(29),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.075
    if image_alpha<0
    {
      instance_destroy()
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
if other.weaponTag=1 or other.weaponTag=31
{
  if knifeHit=0
  {
    var tAtkShield;
    tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
    tAtkShield.xOffset=0; tAtkShield.yOffset=-19; tAtkShield.atkType=1; tAtkShield.atkUp=1
    resType[1]-=1
    knifeHit=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bAssisted=1
{
  if instance_exists(findAlly)
  {
    var tMyDist,tMyDir;
    tMyDist=point_distance(x,y-19,findAlly.x,findAlly.y+27)
    tMyDir=point_direction(x,y-19,findAlly.x,findAlly.y+27)
    draw_sprite_ext(sEfLinkLightning,linkFrm,x,y-19,0.5,tMyDist/64,tMyDir+90,c_white,0.45)
  }
}
event_inherited()
