#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bDestroyOnDeactivate=true
inactiveDist=128

//Enemy base statistics
eName="Skull Head"
eLevel=8
maxLife=105
life=maxLife
pointWorth=8
atkPower=4
resType[1]=2
resType[2]=2
baseItemChance=25
pickupDropMod=10
moneyWorth=0
affiliation=2
bGenEnemy=1
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

runAcc=3
bobAmount=3.8
bobTime=irandom(50)
if x>oPlayer1.x
  runAcc*=-1
xVel=runAcc
if xVel>0
  image_xscale=1
else
  image_xscale=-1

jeremyText="They just bob up and down while flying across the screen. Also they're really annoying."
chaoText="Eww, these kinds of enemies can be so annoying. Especially when they keep coming."
devText="Designing something to be difficult but doesn't feel cheap or overwhelming can get hard. I can only judge what is 'difficult' to a certain degree. There are a few ways I gauge what is too hard and too easy, but they can only come into play when the scenario in question is 'complete.' From there, I typically talk with the testers about what they think."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {

    bobTime+=1
    if bobTime>=1 and bobTime<=20
      y+=bobAmount
    else if bobTime>=25 and bobTime<=44
      y-=bobAmount
    else if bobTime>=49
      bobTime=0
    x+=xVel
  }
  enemyStepEvent()
}
