#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
makeActive()
setCollisionBounds(-7,-24,7,-1)
runAcc=1
bWalking=false
walkingTime=round(random(60)+30)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  npcWalk(sNPCToad,0,round(random(60)+30),sNPCToad,0.2,round(random(60)+30))
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  resetKeyCodes()
  global.recPeopleTalkNum+=1

  if talker="Upset Gamer Toad" //Achievement for talking to Upset Toad in Gate 1
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,20)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="Useless Achievement"; tAchievement.checkNum=20
    }
  }
  bWalking=false
  xVel=0
  image_speed=0; image_index=0
  walkingTime=150
  if x<=oPlayer1.x {image_xscale=1}
  else {image_xscale=-1}
  npcTextBox()
}
