#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1

//Enemy base statistics
eName="CHAOS Spike Rotater"
eLevel=37
maxLife=100
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=101

moveProg=0
runAcc=1.25
bulletTime=5
if global.shooterDifficulty=1 {bulletDelay=40}
else {bulletDelay=30}
bulletCheck=0

jeremyText="Just shoot it down."
chaoText="Eaten Ability: SPIKE SHIELD#These deal no damage and do not take up a weapon slot. Instead, they will spin around you and absorb bullets for you."
devText="N/A"

shieldDir=90
shieldDist=64
for(i=0;i<2;i+=1)
{
  shieldPart[i]=instance_create(x,y,oCW_Spike)
  shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*180))
  shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*180))
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  if instance_exists(shieldPart[i])
  {
    with shieldPart[i] {instance_destroy()}
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  event_inherited()
  if bActive=true
  {
    if bIsSucked=0
    {
      x-=runAcc

      bulletTime+=1
      if bulletTime=bulletDelay-1
      {
        shotDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
      }
      if bulletTime>=bulletDelay and x>32
      {
        if bulletTime mod 2=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sC_SparkNeedle; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
          tNewAttack.decayTime=-100; tNewAttack.direction=shotDir
          bulletCheck+=1
          if bulletCheck>=5
          {
            bulletCheck=0
            bulletTime=0
          }
        }
      }
    }

    shieldDir+=4
    for(i=0;i<2;i+=1)
    {
      if instance_exists(shieldPart[i])
      {
        shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*180))
        shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*180))
        shieldPart[i].image_angle=shieldDir+(i*180)
      }
    }

    if x<=-32 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<2;i+=1)
{
  if instance_exists(shieldPart[i])
  {
    for(ii=1;ii<8;ii+=1)
    {
      draw_sprite_ext(sC_SpikeChain,0,x+lengthdir_x(ii*8,shieldDir+(i*180)),y+lengthdir_y(ii*8,shieldDir+(i*180)),1,1,shieldDir+(i*180),c_white,1)
    }
  }
}
draw_self()
