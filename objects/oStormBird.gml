#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.5
bActive=true

//Enemy base statistics
eName="Storm Bird"
eLevel=15
maxLife=30
life=maxLife
pointWorth=5
atkPower=5
resType[0]=2
resType[1]=2
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
runAcc=1.4
atkProg=0
bSpotted=0

jeremyText="All it does is fly outword for a moment and then straight for you."
chaoText="Have you noticed that there are a lot of birds lately? I wonder what's up with that..."
devText="Around the time that I was making this level, I was working at a crap job. However, birds were often very common, and I observed them quite a bit. It was one of the few things I enjoyed about the job and a lot of times, I looked forward to going to work to see what the birds would do. A few minor additions in the form of birds were added to DT3 during this time."
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
    if direction>=91 and direction<=269 {image_xscale=-1}
    else {image_xscale=1}

    speed=9
    atkProg+=1
    if atkProg=9 {direction=player_sprite_center()}
  }
  else
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMExplosion
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
