#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: myDir,atkTime
event_inherited()
bActive=true
bCanDealDamage=false

//Enemy base statistics
eName="Hex Shield Orb"
eLevel=40
maxLife=750
life=maxLife
resType[1]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0

chainFrm=0
myDist=0
shieldProg=0
extendOut=1

atkTime=85
atkDelay=185

jeremyText="These provide Hex with complete invulnerability while they exist. I don't even need to look into their data to get that. Aside from that, they seem to sap energy from Hex, so leaving them around is beneficial... Wait a minute. How does this make any sense? What sort of thing is Hex doing here? Shields that sap his energy?"
chaoText="This guy has all sorts of surprises, I can tell.#There's something really big I found out just now too. All of Hex's attacks that are red outlined will go right through the idle shield, so you can't rely on that if you're trying to hide in the idle partner's shield."
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
    chainFrm+=0.33
    if shieldProg=0
    {
      myDist+=2
      if myDist>=80 {shieldProg=1}
    }
    else if shieldProg=1
    {
      //Attack
      atkTime+=1
      if atkTime=atkDelay
      {
        var tEffect,tDir;
        tDir=0
        for(i=0;i<6;i+=1)
        {
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sHexShieldConnector; tEffect.image_speed=0.3; tEffect.direction=tDir; tEffect.speed=3; tEffect.friction=0.05
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
          tDir+=60
        }
      }
      else if atkTime=atkDelay+30
      {
        var tAtk,tDir;
        tDir=220
        for(i=0;i<3;i+=1)
        {
          tAtk=instance_create(x,y,oPassBullet)
          tAtk.sprite_index=sHexShieldConnector; tAtk.atkPower=atkPower; tAtk.image_xscale=2; tAtk.image_yscale=0.5
          tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=tDir
          tDir+=50
        }
        atkTime=0
      }

      //Orbit around Hex
      myDir+=2
      if extendOut=1
      {
        myDist+=1
        if myDist>=112 {extendOut=0}
      }
      else
      {
        myDist-=1
        if myDist<=72 {extendOut=1}
      }
    }
    x=oHex_Final_Main.x+lengthdir_x(myDist,myDir)
    y=oHex_Final_Main.y+lengthdir_y(myDist,myDir)

    if oHex_Final_Main.bossProgress=0 //Start Hex on swap deterrent
    {
      if life<=maxLife/2 and oHex_Final_Main.bSwapDeter=0
      {
        msgCreate(0,0,"Hex","I've got an idea.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
        oHex_Final_Main.bSwapDeter=1
      }
    }
  }
  else if life<=0
  {
    var tEffect,tXspd;
    for(i=0;i<12;i+=1)
    {
      tXspd=random_range(-2,2)
      tEffect=instance_create(x+random_range(-7,7),y+random_range(-7,7),oEffectGrav)
      tEffect.type=2; tEffect.sprite_index=sHexShieldConnector; tEffect.image_speed=0.5
      tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=0
      tEffect.grav=0.3; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    }
    instance_destroy()
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  draw_sprite(sHexShieldConnector,chainFrm+1,oHex_Final_Main.x+lengthdir_x(myDist*(0.2*(i+1)),myDir),oHex_Final_Main.y+lengthdir_y(myDist*(0.2*(i+1)),myDir))
}
event_inherited()
