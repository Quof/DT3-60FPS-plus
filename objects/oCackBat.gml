#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Cack Bat"
eLevel=6
maxLife=100
life=maxLife
atkPower=4
pointWorth=4
affiliation=1
inactiveDist*=1.25
dieEffect=0
jeremyText="A bat summoned by Cackletta. It will only fly across the room in a futile attempt to get in your way. Fortunately for you, they actually work against her."
chaoText="These are gross looking. Claire is right, Cackletta has no taste."
devText="When I started making the death sequence for this encounter, that's when I knew I wanted to periodically have unique death animations in DT3. Aside from the 'oh that's kinda cool' factor, it makes things a little more dramatic at times, at least I think so. Visually, DT1 was very mediocre, and since I've gotten a lot better in presenting, it was only right to take a bit of extra time and place nifty things like that in."
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
    if xSpd<0
      image_xscale=-1
    if type=0 //Summon type
    {
      x+=xSpd*gDeltaTime
      y-=ySpd*gDeltaTime
      if xSpd>=0 and xSpd<5
        xSpd+=0.1*gDeltaTime
      else if xSpd<0 and xSpd>-5
        xSpd-=0.1*gDeltaTime
      if ySpd<6
        ySpd+=0.4*gDeltaTime

      if y<=-16
        instance_destroy()
    }
    else if type=1 //Attack type
    {
      x+=xSpd*gDeltaTime
      if findTargetX>inactiveDist
        instance_destroy()
    }
  }
  else if life<=0
  {
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
    oCackletta.myBats-=1
    if oCackletta.myBats=0
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,5)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Fourth Trimester"; tAchievement.checkNum=5
      }
    }
    instance_destroy()
  }
  enemyStepEvent()
}
