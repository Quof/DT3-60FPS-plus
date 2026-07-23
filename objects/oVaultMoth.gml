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
eName="Vault Moth"
eLevel=21
maxLife=310
life=maxLife
pointWorth=26
atkPower=6
resType[0]=2
resType[4]=2
resType[global.vaultWeakness]=4
stunResist=3
baseItemChance=70
baseDropIndex=80
moneyWorth=5
dieEffect=0
inactiveDist*=2

currHspd=0
currVspd=0

amplitude=38
phase=0
introAnim=0
deathAnim=0

jeremyText="The movement behavior is like the Phantom Skull, but its target spot is above you instead of on you. I can't read the projectile code, but from observing it, I can see that it only fires when you're close by."
chaoText="For that shared code data, they seem to cycle through resistances based on the number of hits from the current one."
devText="Sometimes when writing these Dev Commentaries out, I want to mention something about the level, won't be able to due to it being a big spoiler. For some of these things, it's reserved for a boss, an enemy that doesn't show up till later in the level, or commentary from an enemy in a later level."
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
        myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
        myDist=round(myDist/32)
        if myDist>9 {myDist=9}
        else if myDist<3 {myDist=3}
        maxSpeed=myDist

        if x>oPlayer1.x+(32*oPlayer1.image_xscale)
        {
          if currHspd>-maxSpeed {currHspd-=0.1}
          else {currHspd=-maxSpeed}
        }
        else if x<oPlayer1.x+(32*oPlayer1.image_xscale)
        {
          if currHspd<maxSpeed {currHspd+=0.1}
          else {currHspd=maxSpeed}
        }
        if y>oPlayer1.y-98
        {
          if currVspd>-maxSpeed {currVspd-=0.1}
          else {currVspd=-maxSpeed}
        }
        else if y<oPlayer1.y-98
        {
          if currVspd<maxSpeed {currVspd+=0.1}
          else {currVspd=maxSpeed}
        }
        hspeed=currHspd; vspeed=currVspd

        //Sprinkle bullets
        xDist=point_distance(x,0,oPlayer1.x,0)
        if xDist<=104
        {
          if oGame.time mod 8=0
          {
            var tNewAttack;
            tNewAttack=instance_create(x,y,oGravPassBullet)
            tNewAttack.sprite_index=sWallCancerShot; tNewAttack.atkPower=atkPower
            tNewAttack.image_xscale=0.5; tNewAttack.image_yscale=0.5
            tNewAttack.xVel=random(4)*choose(-1.25,1.25); tNewAttack.yVel=random_range(-3,-4)
          }
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
      hspeed=0
      vspeed=0
    }
  }
  else if life<=0
  {
    for(i=0;i<16;i+=1)
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
else
{
  hspeed=0
  vspeed=0
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
{
  global.tempAction[0]+=1
}

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
