#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_angle=270
direction=270

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2

atkProg=0
atkTime=15
atkDelay=170
turnSpd=1.5

bDestroyMe=0

for(i=0;i<8;i+=1)
{
  connectorUp[i]=1
  connectorSize[i]=0.2+(i*0.15)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Extend out
  {
    y-=0.75
    if type=0
    {
      x+=1.25
    }
    else
    {
      x-=1.25
    }
    atkTime+=1
    if atkTime>=80 {atkTime=95; atkProg+=1}
  }
  else if atkProg=1 //Main behavior
  {
    //Movement

    //Rotate toward player
    turn_toward_direction(player_sprite_center(),turnSpd)
    image_angle=direction
    //Attack
    atkTime+=1
    if atkTime=atkDelay
    {
      image_blend=c_red
    }
    else if atkTime=atkDelay+25
    {
      var tAtk;
      tAtk=instance_create(x+lengthdir_x(12,image_angle),y+lengthdir_y(12,image_angle),oPassBullet)
      tAtk.sprite_index=sHexShieldConnector; tAtk.atkPower=atkPower; tAtk.image_xscale=2; tAtk.image_yscale=0.5
      tAtk.bulletSpeed=6; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=image_angle
    }
    else if atkTime=atkDelay+40
    {
      var tAtk;
      tAtk=instance_create(x+lengthdir_x(12,image_angle),y+lengthdir_y(12,image_angle),oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_HandZap; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3
      tAtk.image_speed=0.33; tAtk.decayTime=-100; tAtk.direction=image_angle
    }
    else if atkTime=atkDelay+50
    {
      var tAtk;
      tAtk=instance_create(x+lengthdir_x(12,image_angle),y+lengthdir_y(12,image_angle),oPassBullet)
      tAtk.sprite_index=sHexShieldConnector; tAtk.atkPower=atkPower; tAtk.image_xscale=2; tAtk.image_yscale=0.5
      tAtk.bulletSpeed=6; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=image_angle
    }
    else if atkTime=atkDelay+55
    {
      image_blend=c_white; atkCycle=0; atkTime=0
    }

    if bDestroyMe=1
    {
      var tEffect,tXspd;
      for(i=0;i<16;i+=1)
      {
        tXspd=random_range(-3,3)
        tEffect=instance_create(x+random_range(-7,7),y+random_range(-7,7),oEffectGrav)
        tEffect.type=2; tEffect.sprite_index=sHFight_EyeConnector
        tEffect.xSpd=tXspd; tEffect.ySpd=-3-random(2); tEffect.fadeSpd=0.03; tEffect.rotation=random_range(-10,10)
        tEffect.grav=0.3; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
      }
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<8;i+=1)
{
  if connectorUp[i]=1
  {
    connectorSize[i]+=0.02
    if connectorSize[i]>=1.3 {connectorUp[i]=0}
  }
  else
  {
    connectorSize[i]-=0.02
    if connectorSize[i]<=0.2 {connectorUp[i]=1}
  }
  myDir=point_direction(x,y,oHex_Final_Main.x,oHex_Final_Main.y)
  myDist=point_distance(x,y,oHex_Final_Main.x,oHex_Final_Main.y)
  draw_sprite_ext(sHFight_EyeConnector,0,x+lengthdir_x(myDist*(i*0.125),myDir),y+lengthdir_y(myDist*(i*0.125),myDir),connectorSize[i],connectorSize[i],0,c_white,image_alpha)
}
event_inherited()
