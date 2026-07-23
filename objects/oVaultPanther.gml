#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-22,-21,22,-1)
visible=0
image_speed=0
bCanTakeDamage=false
bCanDealDamage=false
detectDistX=172
detectDistY=144

//Enemy base statistics
eName="Vault Panther"
eLevel=20
maxLife=250
life=maxLife
pointWorth=24
atkPower=6
resType[0]=2
resType[4]=2
resType[global.vaultWeakness]=4
stunResist=2
baseItemChance=65
baseDropIndex=90
moneyWorth=5
dieEffect=0
initDir=0
runAcc=6
turnTime=0

amplitude=38
phase=0
introAnim=0
deathAnim=0

jeremyText="It acts just like the Skeleton Panthers except that it can turn around. Everything else that's relevant is blocked out for me."
chaoText="I can see part of a shared code string for these Vault creatures. They all share a specific weakness."
devText="This Chapter plays out differently than the others. I wanted to display that right away by having it start out the way it did with Jerry taken out."
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
    if introAnim>=100 //Normal behavior
    {
      if initDir=0
      {
        xVel=runAcc
        if x>oPlayer1.x
          xVel*=-1
        initDir=1
      }

      if x>oPlayer1.x and image_xscale=1
        turnTime+=1
      else if x<oPlayer1.x and image_xscale=-1
        turnTime+=1
      if turnTime>=25
      {
        sprite_index=sVaultPantherLookBack
        if xVel>0 {xVel-=0.33}
        else if xVel<0 {xVel+=0.33}

        if xVel>=-1 and xVel<=1
        {
          if image_xscale=1 {xVel=-runAcc}
          else {xVel=runAcc}
          sprite_index=sVaultPantherRun
          turnTime=0
        }
      }

      yVel+=0.3
      if isCollisionBottom(1)
        yVel=0
      if isCollisionLeft(1)
        xVel*=-1
      if isCollisionRight(1)
        xVel*=-1
      if isCollisionSolid()
        y-=2
      if xVel>0
        image_xscale=1
      else
        image_xscale=-1
      moveTo(xVel,yVel)
      if y>room_height+24
      {
        if questType>0
          enemyQuest(questType)
        instance_destroy()
      }
    }
    else //Phase in
    {
      if introAnim=0
      {
        if x>oPlayer1.x {image_xscale=-1}
        detectDistX=264
        detectDistY=200
        visible=1
        introAnim=1
      }
      else if introAnim=1
      {
        phase+=0.025
        amplitude-=2
        if amplitude<=1 {introAnim=10}
      }
      else if introAnim>=10
      {
        introAnim+=1
        if introAnim>=20
        {
          image_speed=0.45
          bCanTakeDamage=true
          bCanDealDamage=true
          introAnim=100
        }
      }
    }
  }
  else if life<=0
  {
    for(i=0;i<12;i+=1)
    {
      tEffect=instance_create(x+random_range(-22,22),y-1-random(21),oEffectB)
      tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
      tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    instance_destroy()
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tScrnText;
tScrnText=instance_create(240,64,oScreenText)
tScrnText.textTime=80
tScrnText.textFont=fnt_Location
tScrnText.textAlign=fa_center
tScrnText.screenText="The Vault creatures have shifted their resistance."
tScrnText.dropStyle=4
tScrnText.textType=0
tScrnText.followType=1
tScrnText.image_blend=c_white
tScrnText.depth=-99

with oVaultPanther
{
  resType[1]=3
  resType[2]=3
  resType[3]=3
  resType[5]=3
  resType[global.vaultWeakness]=4
}
with oVaultMoth
{
  resType[1]=3
  resType[2]=3
  resType[3]=3
  resType[5]=3
  resType[global.vaultWeakness]=4
}
with oVaultShadow
{
  resType[1]=3
  resType[2]=3
  resType[3]=3
  resType[5]=3
  resType[global.vaultWeakness]=4
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.damageType="PIERCE" and global.vaultWeakness=1) or (other.damageType="ELEMENTAL" and global.vaultWeakness=2) or (other.damageType="SHOT" and global.vaultWeakness=3) or (other.damageType="SPECIAL" and global.vaultWeakness=5)
global.tempAction[0]+=1

if global.vaultWeakness=1 //Pierce
{
  if global.tempAction[0]>=12
  {
    if global.gameProgress>=2250 {global.vaultWeakness=3}
    else {global.vaultWeakness=2}
    event_user(0)
    global.tempAction[0]=0
  }
}
else if global.vaultWeakness=3 //Shot
{
  if global.tempAction[0]>=24
  {
    global.vaultWeakness=5
    event_user(0)
    global.tempAction[0]=0
  }
}
else if global.vaultWeakness=5 //Special
{
  if global.tempAction[0]>=6
  {
    global.vaultWeakness=2
    event_user(0)
    global.tempAction[0]=0
  }
}
else if global.vaultWeakness=2 //Elemental
{
  if global.tempAction[0]>=12
  {
    global.vaultWeakness=1
    event_user(0)
    global.tempAction[0]=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if introAnim>=10 {event_inherited()}
else
{
  if image_xscale<0
    draw_sprite_wave(sprite_index,image_index,x+abs(sprite_width),y,1,12,amplitude,phase)
  else
    draw_sprite_wave(sprite_index,image_index,x,y,1,12,amplitude,phase)
}
