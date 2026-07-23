#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-10,-18,10,30)
image_speed=0.2

//Enemy base statistics
eName="Ball De Voux"
eLevel=16
maxLife=190
life=maxLife
pointWorth=22
atkPower=5
resType[0]=2
resType[1]=2
stunResist=4
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
initDir=0
xScaleStore=0
runAcc=2
inactiveDist=10000

jeremyText="All it does is walk forward and act like red-shelled Koopas. Eh... really not that spectacular."
chaoText="Jeremy doesn't seem to like this 'walk forward only' AI. It does have the slightly unique invulnerable legs. The other thing I'm detecting is that these can come in multiple sizes."
devText="While they're definitely harder to code and bug test at times, I enjoy making these enemies with multiple parts. It's just another thing that DT3 will be making heavy use of later as well."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(round(-10*image_xscale),round(-18*image_yscale),round(10*image_xscale),round(30*image_yscale))
runAcc=1.1+image_xscale

myLegs=instance_create(x,y,oBallDeVouxLegs)
myLegs.ownerID=id
myLegs.atkPower=atkPower
myLegs.image_speed=image_speed
myLegs.image_xscale=image_xscale
myLegs.image_yscale=image_yscale

xScaleStore=image_xscale


maxLife=round(190*image_xscale)
life=maxLife
atkPower=round(5+image_xscale)
pointWorth=round(22*image_xscale)
stunResist=round(4+(image_xscale))
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if xScaleStore>0
  {
    if bActive=true and stunnedTime=0 and life>0
    {
      if initDir=0
      {
        xVel=runAcc
        if x>oPlayer1.x
          xVel*=-1
        initDir=1
      }

      //Check if at cliff edge and turn around
      tDrop=0
      if aiCheckHoriz(1,1,0,8,round(34*image_yscale))
      {
        if aiCheckVert(0,1,8,8,round(34*image_yscale))=1
          tDrop=1
      }
      if tDrop=0
      {
        xVel*=-1
      }

      yVel+=0.2
      if isCollisionBottom(1)
        yVel=0
      if isCollisionLeft(1) and xVel<0
        xVel=runAcc
      if isCollisionRight(1) and xVel>0
        xVel=-runAcc
      if isCollisionSolid()
        y-=2

      if xVel>0
        image_xscale=xScaleStore
      else
        image_xscale=-xScaleStore

      moveTo(xVel,yVel)
      myLegs.x=x; myLegs.y=y; myLegs.image_xscale=image_xscale
      if y>room_height+24
      {
        if questType>0
          enemyQuest(questType)
        instance_destroy()
      }
    }
    else if life<=0
    {
      if image_xscale=0.25 or image_xscale=-0.25
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,35)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Picking on the Little Guy"; tAchievement.checkNum=35
        }
      }
      playSound(global.snd_EnemyDieMM,0,1,1)
      tEffect=instance_create(x,y-20,oEffect)
      tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      with myLegs {instance_destroy()}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
