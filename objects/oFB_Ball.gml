#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
direction=45
moveSpd=4
speed=moveSpd
bounceNum=0

checkIfStuck=0
xPrev=0
achievementSaveCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  speed=moveSpd

  instance_create(x,y,oFBallAE)

  if x<-8 //Player misses
  {
    playSound(global.snd_PlayerDamaged[0],0,1,14000+random(3000))
    direction=45
    x=xstart; y=ystart
    if global.bOneHitKillMode=1 {oFB_PlayerPaddle.life-=10000}
    else {oFB_PlayerPaddle.life-=100}
    if moveSpd>6 {moveSpd=6}
  }
  else if x>room_width+8 //Hexor misses
  {
    playSound(global.snd_MetEnemyDieA,0,1,12000+random(3000))
    var tNewInvert; tNewInvert=instance_create(0,0,oScreenInvert); tNewInvert.invertTime=6
    direction=315
    x=xstart; y=ystart
    oFB_HexorPaddle.life-=50
    if moveSpd>6 {moveSpd=6}
  }

  if achievementSaveCheck=1 //Save achievement
  {
    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_string(sectionWrite,"143ss",global.tokenRecognitionsSetTwo)
    ini_close()
    achievementSaveCheck=2
  }

  if x=xPrev //Check if player got ball stuck
  {
    checkIfStuck+=1
    if checkIfStuck=30
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,11)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNoticeSS)
        tAchievement.myAchievement="Dishonest Pong"; tAchievement.checkNum=11
        achievementSaveCheck=1
      }
      msgCreate(140,140,"Hexor","Stop trying to cheat, Jeremy.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
      checkIfStuck=0
      direction=315
      x=xstart; y=ystart
      if moveSpd>6 {moveSpd=6}
    }
  }
  else {checkIfStuck=0}
  xPrev=x
}
else
{
  speed=0
}
#define Collision_oFB_Solid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
move_bounce_solid(0)
playSound(global.snd_MenuShift,0,1,10000+random(3000))
bounceNum+=1

if moveSpd=4 and bounceNum>=6 {bounceNum=0; moveSpd+=1}
else if moveSpd=5 and bounceNum>=9 {bounceNum=0; moveSpd+=1}
else if moveSpd=6 and bounceNum>=13 {bounceNum=0; moveSpd+=1}
else if moveSpd=7 and bounceNum>=17 {bounceNum=0; moveSpd+=1}
