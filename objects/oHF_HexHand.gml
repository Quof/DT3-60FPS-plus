#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_speed=0

//Enemy base statistics
eName="Hex Hand"
eLevel=40
maxLife=760
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=2
}
resType[4]=5
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0

atkProg=0
atkTime=0
atkDelay=30
atkCycle=0

jeremyText="Whatever you do, don't destroy these. When you do, they explode into a bullet storm that lasts a good 3 seconds. Destroying them also restores a bit of Hex's HP. Wow, so basically just refrain from using EXPLOSIVE type damage around these."
chaoText="This thing fires two types of attacks. One of them are the same as those shield orbs, but they're fired at you. The other is a red lightning attack. If you can hit this thing with Jerry's Fuse Bomb, you should be able to destroy it in one hit if you've powered up your bomb. Oh yeah, every two of these that you destroy, you'll get a heart drop, assuming you need it. Note that hearts will disappear after awhile here."
devText="Hex blocks dev commentary."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if atkProg=0 //Rise up
    {
      y-=2
      if y<=288 {atkProg+=1}
    }
    else if atkProg=1 //Open hand
    {
      atkTime+=1
      if atkTime=15 {image_index=1}
      else if atkTime=20 {image_index=2}
      else if atkTime=25
      {
        image_index=3
        atkTime=0 atkProg+=1
      }
    }
    else if atkProg=2 //Attack
    {
      atkTime+=1
      if atkTime=atkDelay
      {
        var tAtk,tDir;
        tDir=point_direction(x-(40*image_xscale),y-119,oPlayer1.x,returnPlayerYCenter())
        tAtk=instance_create(x-(40*image_xscale),y-119,oPassBullet)
        tAtk.sprite_index=sHexShieldConnector; tAtk.atkPower=atkPower; tAtk.image_xscale=2; tAtk.image_yscale=0.5
        tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=tDir
      }
      else if atkTime=atkDelay+12
      {
        var tAtk,tDir;
        tDir=point_direction(x-(40*image_xscale),y-97,oPlayer1.x,returnPlayerYCenter())
        tAtk=instance_create(x-(40*image_xscale),y-97,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_HandZap; tAtk.atkPower=atkPower; tAtk.bulletSpeed=7
        tAtk.image_speed=0.33; tAtk.decayTime=-100; tAtk.direction=tDir
      }
      else if atkTime=atkDelay+15
      {
        atkCycle+=1
        if atkCycle>=2 {atkCycle=0; atkTime=0; atkProg+=1}
        else {atkTime=5}
      }
    }
    else if atkProg=3 //Close hand
    {
      atkTime+=1
      if atkTime=15 {image_index=2}
      else if atkTime=20 {image_index=1}
      else if atkTime=25
      {
        image_index=0
        atkTime=0 atkProg+=1
      }
    }
    else if atkProg=4 //Linger a bit
    {
      atkTime+=1
      if atkTime>=20 {atkTime=0 atkProg+=1}
    }
    else if atkProg=5 //Drop down
    {
      y+=4
      if y>=560 {instance_destroy()}
    }
    enemyStepEvent()
  }

  if life<=0
  {
    image_blend=c_red
    image_alpha-=0.04
    if image_alpha<=0
    {
      if oPlayer1.life<oPlayer1.maxLife
      {
        oHex_Final_Main.heartDrop+=1
        if oHex_Final_Main.heartDrop>=2
        {
          tHeartDrop=instance_create(x,280,oHealthPickup)
          oHex_Final_Main.heartDrop=0
        }
      }
      instance_destroy()
    }
  }
}
