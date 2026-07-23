#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
visible=0
image_speed=0
bCanTakeDamage=false
bCanDealDamage=false
detectDistX=172
detectDistY=144

//Enemy base statistics
eName="Vault Shadow"
eLevel=22
maxLife=405
life=maxLife
pointWorth=28
atkPower=5
resType[0]=2
resType[4]=2
resType[global.vaultWeakness]=4
stunResist=5
baseItemChance=75
baseDropIndex=90
moneyWorth=5
dieEffect=0
inactiveDist*=1.25

homingShotX=-1000
homingShotY=-1000
laserTime=55

amplitude=38
phase=0
introAnim=0
deathAnim=0

jeremyText="This will try to keep away from you if you're too close. When you see those projectiles, try to be sure you have a dash ready, they're super fast."
chaoText="The last bit of the shared code shows they always cycle in 'SPECIAL' -> 'PIERCE' -> 'ELEMENTAL' -> 'SHOT'."
devText="Having enemies that all share and change their weakness together based on player actions was an idea I had when making DT1, but never did have a place to use it. When I did, I completely forgot about it, which would have been the Data Segment."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      if introAnim>=100 //Normal behavior
      {
        //Movement
        myDir=player_sprite_center()
        myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        if myDist<=92
        {
          direction=myDir+180
          speed=2
        }
        else if myDist>=122
        {
          direction=myDir
          speed=2
        }
        else {speed=0}

        if laserTime>=101 {speed=0}
        //Fire laser
        laserTime+=1
        if laserTime=100
        {
          for(i=0;i<2;i+=1)
          {
            myFire[i]=instance_create(x,y,oVShadowLaser)
            myFire[i].atkPower=atkPower
            myFire[i].direction=myDir+90+(i*180)
          }
        }
        else if laserTime>=125 {laserTime=0}
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
            image_speed=0.2
            bCanTakeDamage=true
            bCanDealDamage=true
            introAnim=100
          }
        }
      }
    }
    else
    {
      if laserTime>=101 {laserTime+=1}
      speed=0
    }
  }
  else if life<=0
  {
    for(i=0;i<20;i+=1)
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
else {speed=0}
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
