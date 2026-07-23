#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bSway
event_inherited()
bActive=true
image_xscale=0.1; image_yscale=0.1
visible=0
bCanDealDamage=0; bCanTakeDamage=0

//Enemy base statistics
eName="Abomination"
if global.modeWahfuu=1 {eName="Wahfuu"}
eLevel=39
maxLife=1000000
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true

fireTime=0
fireDelay=170
myProg=0
myTime=0

moveWave=pi/2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bSway=1
  {
    moveWave+=pi/50
    x+=cos(moveWave)/4
  }

  if myProg=0
  {
    myTime+=1
    if myTime>=100
    {
      visible=1
      bCanDealDamage=1; bCanTakeDamage=1
      myTime=0; myProg+=1
    }
  }
  else if myProg=1
  {
    image_xscale+=0.01; image_yscale+=0.01
    if image_xscale=0.5
    {
      bCanDealDamage=1
      myProg+=1
    }
  }
  else if myProg=2
  {
    turn_toward_direction(point_direction(x+lengthdir_x(44,22+image_angle),y+lengthdir_y(44,22+image_angle),oPlayer1.x,returnPlayerYCenter()),1)
    image_angle=direction
    fireTime+=1
    if fireTime=fireDelay-20 //Attack warning
    {
      var tEffect;
      tEffect=instance_create(x+lengthdir_x(44,22+image_angle),y+lengthdir_y(44,22+image_angle),oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
      tEffect.image_xscale=0.8; tEffect.image_yscale=0.8
    }
    if fireTime>=fireDelay //Fire attack
    {
      var tNewAttack,tDir;
      tDir=image_angle-25
      for(i=0;i<3;i+=1)
      {
        tNewAtk=instance_create(x+lengthdir_x(44,22+image_angle),y+lengthdir_y(44,22+image_angle),oPassBullet)
        tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=3; tNewAtk.image_speed=0.33
        tNewAtk.decayTime=-100; tNewAtk.direction=tDir
        tDir+=25
      }
      fireTime=0
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
if fireTime>=8 {fireTime-=8}
