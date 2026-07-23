#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.1

//Enemy base statistics
eName="Vampire Bat"
eLevel=12
maxLife=140
life=maxLife
pointWorth=10
atkPower=4
resType[2]=4
resType[5]=2
stunResist=1
baseItemChance=40
baseDropIndex=90
affiliation=3
dieEffect=0
initDir=0
bobTime=0
runAcc=2
detectDistY=184
inactiveDist*=2
tauntPlayer=0

deathAnim=0

jeremyText="What can I really say about these things? They just fly in one direction. I mentioned these to Jerry way back before all this Virus nonsense."
chaoText="Just in case you don't know, these fly right through walls."
devText="This bat AI is totally recycled from the bat in DT1. Ctrl-C and Ctrl-V made this bat what it is now in DT3."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=1; myShadow.maxShadowDist=192
}
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
    if tauntPlayer>0 {tauntPlayer-=1}
    if initDir=false
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1

      if xVel>0
        image_xscale=1
      else
        image_xscale=-1
      initDir=true
    }
    bobTime+=1
    if bobTime>=1 and bobTime<=20
      y+=0.7
    else if bobTime>=21 and bobTime<=40
    {
      y-=0.7
      if bobTime=40
        bobTime=0
    }
    x+=xVel
    if findTargetX>inactiveDist/2
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-6,6),y+random_range(-12,12),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0
{
  if tauntPlayer=0
  {
    if oPlayer1.dashInvulnerabilityTime=0 and oPlayer1.bCanTakeHit=true and random(100)<60
    {
      var newMessage,ranMessage;
      ranMessage=irandom_range(1,2)
      newMessage=instance_create(x-46,y-40,oEnemyChat)
      if ranMessage=1 {newMessage.enemyMessage="I'm a goddamn bat!"}
      else if ranMessage=2 {newMessage.enemyMessage="I never wanted to fly into you!"}
      tauntPlayer=30
    }
  }
}
event_inherited()
