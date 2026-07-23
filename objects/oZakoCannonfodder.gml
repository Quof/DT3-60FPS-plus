#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-34,8,-1)
image_speed=0.28
baseColor=make_color_rgb(170,170,255)
image_blend=baseColor

//Enemy base statistics
eName="CHAOS Cannonfodder"
eLevel=26
maxLife=65
life=maxLife
pointWorth=15
atkPower=7
resType[0]=1
resType[1]=1
stunResist=1
baseItemChance=30
baseDropIndex=90
affiliation=7
dieSound=0
dieEffect=0

initDir=0
runAcc=2.5
bJumpReady=1

deathAnim=0
flyX=0
flyY=0

jeremyText="These guys... just shoot them."
chaoText="These come from 'Contra: Hard Corps' for the Sega Genesis. They're the standard cannon-fodder in the game."
devText="Meh, I don't want to comment on anything within this enemy scan."

maxSlope=6
maxDownSlope=5
y-=1

if global.CHAOS_Upgrade=1
{
  sprite_index=sCAdvSoldierIdle
  eName="CHAOS Advanced Cannonfodder"
  eLevel=34
  maxLife=100
  life=maxLife
  atkPower=9
  pointWorth=25
  jeremyText+=" The advanced version of these give it improved durability and power. Also they're still Cannonfodder. And this palette swap thing they have going on... UGH! I hate these guys even more now!"
}
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("generated") {bGenEnemy=1}
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
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
      if aiCheckVert(0,2,8,0,0)=0
      {
        xVel=(runAcc*1.25)*image_xscale
        yVel=-6
        bJumpReady=0
      }
      initDir=1
    }

    //---------- Movement ----------
    if bJumpReady=1
    {
      if global.CHAOS_Upgrade=0 {sprite_index=sZakoSoldierRun}
      else {sprite_index=sCAdvSoldierRun}
      if image_xscale=1 {xVel=runAcc}
      else {xVel=-runAcc}
    }
    else //Jump
    {
      if global.CHAOS_Upgrade=0 {sprite_index=sZakoSoldierJump}
      else {sprite_index=sCAdvSoldierJump}
    }

    //Check if cliff edge and jump
    if yVel=0 and bJumpReady=1
    {
      var tDrop;
      tDrop=0
      if aiCheckHoriz(1,1,0,16,4)
      {
        if aiCheckVert(0,3,24,16,4)=1
        {
          tDrop=1
        }
      }

      if tDrop=0
      {
        xVel=(runAcc*1.25)*image_xscale
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }

    yVel+=0.3
    if isCollisionBottom(1)
    {
      yVel=0
      bJumpReady=1
    }
    if isCollisionLeft(1)
    {
      if xVel!=0 {xVel=runAcc}
    }
    if isCollisionRight(1)
    {
      if xVel!=0 {xVel=-runAcc}
    }
    if isCollisionSolid()
      y-=2

    enemySlopeMovement()
    //moveTo(xVel,yVel)
    if y>room_height+24 {instance_destroy()}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      if global.CHAOS_Upgrade=0 {sprite_index=sZakoSoldierDie}
      else {sprite_index=sCAdvSoldierDie}
      if random(100)<=4 {global.recHeardWilhelm+=1; playSound(global.snd_Wilhelm,0,0.95,1)}
      flyX=2*-image_xscale; flyY=-4
    }
    x+=flyX; y+=flyY
    flyY+=0.33
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
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.attackState=other.ACT_IN_BIKE
{
  if life>0 {enemyDefeat(0,102)}
  life=0
}
else {event_inherited()}
