#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_direction=45
moveSpd=4
_speed=moveSpd
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
  _speed=moveSpd

  //instance_create(x,y,oFBallAE)
  if gDeltaDoTicks {instance_create(x,y,oFBallAE)} //60fps change: one trail image per tick (was 2x/4x as many at 60/120fps)

  if x<-8 //Player misses
  {
    playSound(global.snd_PlayerDamaged[0],0,1,14000+random(3000))
    _direction=45
    x=xstart; y=ystart
    //if global.bOneHitKillMode=1 {oFB_PlayerPaddle.life-=10000}
    if global.bOneHitKillMode=1 or global.omenActive=1 {oFB_PlayerPaddle.life-=10000} //dark omen change: also with the New Dark Omen on (scrOmenState), as in Achilles Mode
    else {oFB_PlayerPaddle.life-=100}
    if moveSpd>6 {moveSpd=6}
  }
  else if x>room_width+8 //Hexor misses
  {
    playSound(global.snd_MetEnemyDieA,0,1,12000+random(3000))
    var tNewInvert; tNewInvert=instance_create(0,0,oScreenInvert); tNewInvert.invertTime=6
    _direction=315
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
    checkIfStuck+=1*gDeltaTime
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
      _direction=315
      x=xstart; y=ystart
      if moveSpd>6 {moveSpd=6}
    }
  }
  else {checkIfStuck=0}
  xPrev=x
}
else
{
  _speed=0
}
correctSpeedDirection(self)
#define Collision_oFB_Solid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//move_bounce_solid(0)
direction=_direction; speed=_speed //60fps change (added): move_bounce_solid works on GM's built-in direction/speed, but the ball moves with _direction/_speed now (built-in speed 0), so it never bounced
move_bounce_solid(0)
_direction=direction; speed=0 //60fps change (added): take the bounced direction back, and keep GM's built-in motion off
playSound(global.snd_MenuShift,0,1,10000+random(3000))
bounceNum+=1

if moveSpd=4 and bounceNum>=6 {bounceNum=0; moveSpd+=1}
else if moveSpd=5 and bounceNum>=9 {bounceNum=0; moveSpd+=1}
else if moveSpd=6 and bounceNum>=13 {bounceNum=0; moveSpd+=1}
else if moveSpd=7 and bounceNum>=17 {bounceNum=0; moveSpd+=1}
