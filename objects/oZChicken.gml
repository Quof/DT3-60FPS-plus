#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-6,-14,6,-1)
image_speed=0
bShowHealthBar=false
hoverAlpha=-1
bActive=1

//Enemy base statistics
eName="Chicken"
eLevel=20
maxLife=50000
life=maxLife
pointWorth=500
atkPower=8
stunResist=50
affiliation=2
dieEffect=0
hitSound=global.snd_Cucco1
initDir=0
flyTime=0
runAcc=1
flyAcc=8

hopTime=0
hopNum=0
hopSeq=0
hopMax=8+irandom(4)
hopSpd=5+irandom(2)
peckTime=0
runFromPlayer=0
hitCount=0
bSpotted=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  bCanDealDamage=0
  bCanTakeDamage=1
  jeremyText="These just move around, they're not your enemy."
  chaoText="Aww, it's so cute!!"
  devText="I just had to."
  extraInfo="The most passive creature."
}
else
{
  bIsBoss=false
  bCanDealDamage=1
  bCanTakeDamage=0
  baseColor=make_color_rgb(255,210,210)
  image_blend=baseColor
  jeremyText="You dug your own grave."
  chaoText="It's your fault for angering them."
  devText="I just had to."
  extraInfo="Death from EVERY DIRECTION!!"
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and stunnedTime=0 and life>0
  {
    if type=0 //Walk around
    {
      if runFromPlayer=0
      {
        hopTime+=1
        if hopSeq=0 //Hop hop hop
        {
          if hopTime mod hopSpd=0
          {
            xVel=runAcc*image_xscale
            y-=2
            yVel=-2.5
            image_index=choose(2,3)
            hopNum+=1
          }

          if hopNum=hopMax
          {
            hopTime=0
            hopNum=0
            hopMax=70+irandom(50)
            image_index=0
            hopSeq=1
          }
        }
        else if hopSeq=1 //Wait
        {
          peckTime+=1
          if peckTime=4 {image_index=1}
          else if peckTime=8 {image_index=0}
          else if peckTime=12 {image_index=1}
          else if peckTime=16 {image_index=0}
          else if peckTime=20 {image_index=1}
          else if peckTime=24 {image_index=0}
          else if peckTime>=56 {peckTime=irandom_range(-10,5)}

          if hopTime=hopMax
          {
            hopTime=hopSpd-1
            hopMax=8+irandom(4)
            hopSpd=6+irandom(2)
            image_xscale=choose(-1,1)
            hopSeq=0
          }
        }
      }
      else
      {
        if x<oPlayer1.x {image_xscale=-1}
        else {image_xscale=1}
        xVel=(runAcc*2)*image_xscale

        if runFromPlayer mod 3=0
        {
          if image_index=2 {image_index=3}
          else {image_index=2}
        }
        runFromPlayer-=1
      }

      yVel+=1
      if isCollisionBottom(1)
      {
        if runFromPlayer=0
        {
          if image_index!=1 {image_index=0}
          xVel=0
        }
        yVel=0
      }
      if isCollisionLeft(1) {xVel=runAcc; image_xscale=1}
      if isCollisionRight(1) {xVel=-runAcc; image_xscale=-1}
      if isCollisionSolid() {y-=2}
      moveTo(xVel,yVel)
      if y>room_height+24 {instance_destroy()}
    }
    else if type=1 //Attack player
    {
      flyTime+=1
      if initDir=0
      {
        myDir=player_sprite_center()
        initDir=1
      }
      if flyTime mod 3=0
      {
        if image_index=2 {image_index=3}
        else {image_index=2}
      }
      direction=myDir
      speed=flyAcc
      if direction>90 and direction<270 {image_xscale=-1}
      else {image_xscale=1}
    }
  }
  else if life<=0
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,28)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="Chicken'd Out"; tAchievement.checkNum=28
    }
    tEffect=instance_create(x,y-7,oEffect)
    tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
else {speed=0}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if flyTime>=30
{
  instance_destroy()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tEffect,txSpd,tLen,tDir;
for(i=0;i<3;i+=1)
{
  txSpd=random_range(-1,1)
  tLen=random(6)
  tDir=random(360)
  tEffect=instance_create(x,y-8,oEffectGrav)
  tEffect.x=x+lengthdir_x(tLen,tDir); tEffect.y=y-8+lengthdir_y(tLen,tDir); tEffect.type=2
  tEffect.sprite_index=sZChickFeather; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.fadeSpd=0.03
  tEffect.xSpd=txSpd; tEffect.ySpd=-3-random(2); tEffect.grav=0.4; tEffect.rotation=-4*txSpd
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
}
runFromPlayer=90
hitCount+=1

if hitCount=5 //Achievement
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,5)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNoticeSS)
    tAchievement.myAchievement="Chicken Menace"; tAchievement.checkNum=5
  }
}
if hitCount>=5
{
  with oZAggressiveChickSpawn {instance_destroy()}
  var tChickSpawn;
  tChickSpawn=instance_create(0,0,oZAggressiveChickSpawn)
  hitCount=0
}
