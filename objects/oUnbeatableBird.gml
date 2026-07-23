#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
global.recBirdsSeen+=1

//Enemy base statistics
eName="Alexander - Destroyer of Worlds"
eLevel=40
maxLife=1000000000
life=maxLife
atkPower=4
stunResist=1000000
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
affiliation=10
//--------------------
atkProg=0
atkTime=0
//--------------------

//Misc Data
xCenter=240
yGround=288
roomSpan=240

jeremyText="This is a legit unbeatable enemy. He has one billion HP and has attacks that are nearly undodgable. Who knew that birds were this indestructible."
chaoText="We kinda did ask for this, didn't we?"
devText="But really though, he can't be beaten."
extraInfo="Unbeatable."

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    if oPlayer1.x>=128
    {
      with oExit {instance_destroy()}
      var tempMplay;
      tempMplay=findMusic(835)
      playMusic(tempMplay,0,0)
      y=128
      activateBoss=1
      atkProg=1
    }
  }

  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
    oPlayer1.dashEnergy+=40

    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    atkTime+=1
    if atkTime mod 14=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<8;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=6; tFeather.image_blend=c_red; tFeather.direction=tDir
        tDir+=45
      }
    }
    if atkTime mod 27=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter()); tDir-=4
      for(i=0;i<3;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=13; tFeather.image_blend=c_red; tFeather.direction=tDir
        tDir+=4
      }
    }
    if atkTime mod 42=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<64;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=2; tFeather.image_blend=c_red; tFeather.direction=tDir
        tDir+=5.625
      }
    }
    if atkTime mod 59=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<32;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=7; tFeather.image_blend=c_red; tFeather.direction=tDir
        tDir+=11.25
      }
    }
    if atkTime mod 150=0
    {
      var tFeather,tDir;
      tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      for(i=0;i<32;i+=1)
      {
        tFeather=instance_create(x,y,oUnbeatableFeather); tFeather.bulletSpeed=7; tFeather.direction=tDir
        tFeather.bCanBeBlocked=1; tFeather.blockCost=300; tFeather.bParryOpp=1
        tDir+=11.25
      }
    }
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  var tempMplay;
  tempMplay=findMusic(0)
  playMusic(tempMplay,0,0)
  instance_destroy()
}
