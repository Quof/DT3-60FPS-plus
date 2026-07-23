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
eName="Bullet Bill"
eLevel=3
maxLife=500
life=maxLife
pointWorth=2
atkPower=4
resType[1]=2
resType[2]=5
resType[3]=1
resType[4]=5
stunResist=6
baseItemChance=5
pickupDropMod=70
moneyWorth=0
affiliation=1
bGenEnemy=1
dieEffect=0

jeremyText="You know how these go. Fired in 1 direction only and the blasters won't fire if you're too close because they get scared for some reason."
chaoText="Aww, Jeremy already said what they do!"
devText="It's a Bullet Bill... Just a basic enemy that's great for a nuisance or place to give the player a Mario boost. Including the Mario bounce can bring up some interesting design choices. When placing Mario based enemies outside of Gate 1, or rather the areas that aren't around it, it's 'usually' to put their boost to some use."
if global.location=91
{
  eLevel=30
  pointWorth=20
  atkPower=12
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
    if bVert=0
    {
      x+=bulletSpeed
    }
    else
    {
      y+=bulletSpeed
    }
  }
  else if life<=0
  {
    if bJumpedOn=0
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,39)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Top Gun"; tAchievement.checkNum=39
      }
    }
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
