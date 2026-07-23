#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
showMyText=0
helpTextInner=make_color_rgb(219,192,235)
helpTextOuter=make_color_rgb(28,16,3)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if showMyText>0 {showMyText-=1}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMyText=2
if global.gamePaused=false and (oKeyCodes.kCodePressed[3]=1 or oKeyCodes.kCodePressed[4]=1)
{
  resetKeyCodes()
  if oPlayer1.currentMoney!=404
  {
    if scrController(3) {myCost=1000}
    else if scrController(4) {myCost=3000}

    if oPlayer1.currentMoney>=myCost
    {
      var tBottleCheck;
      for(i=0;i<2;i+=1)
      {
        tBottleCheck=oPlayer1.pBottles[i]
        if tBottleCheck="1"
        {
          playSound(global.snd_MenuConfirm,0,1,1)
          oPlayer1.currentMoney-=myCost //Take money
          global.pMoney-=myCost
          global.recInterSpent+=myCost

          if (current_hour=4 or current_hour=16) and current_minute=4 //Time is 4:04 AM or PM
          {
            msgCreate(120,120,"","The vending machine stole your money... WHAT AN ASS! Guess it breaks at this specific time.",7,2,oMessagePerson,0)
            newMessage.fadingTime=150
            var tCheckAchieve;
            tCheckAchieve=string_char_at(global.tokenRecognitions,38)
            if tCheckAchieve="0"
            {
              var tAchievement;
              tAchievement=instance_create(0,0,oAchievementNotice)
              tAchievement.myAchievement="Vending Machine Error"; tAchievement.checkNum=38
            }
          }
          else
          {
            var tNewString;
            tNewString=string_delete(global.extraItems,i+1,1)
            if myCost=1000
            {
              msgCreate(120,120,"","You filled a bottle with an Energy Drink!",7,2,oMessagePerson,0)
              newMessage.fadingTime=65
              oPlayer1.pBottles[i]="2"
              tNewString=string_insert("2",tNewString,i+1)
            }
            else if myCost=3000
            {
              msgCreate(120,120,"","You filled a bottle with a TURBO SMOOTHIE!#HOW AWESOME IS THAT?!",7,2,oMessagePerson,0)
              newMessage.fadingTime=80
              oPlayer1.pBottles[i]="3"
              tNewString=string_insert("3",tNewString,i+1)
            }
            global.extraItems=tNewString
          }
          break;
        }
      }
    }
    else //Not enough internetz
    {
      playSound(global.snd_Error,0,1,1)
      msgCreate(120,120,"","Not enough Internetz.",7,2,oMessagePerson,0)
      newMessage.fadingTime=35
    }
  }
  else //Money count is 404
  {
    playSound(global.snd_Error,0,1,1)
    msgCreate(120,120,"","There is an error with your current Internetz balance. Please check your balance and try again later.",7,2,oMessagePerson,0)
    newMessage.fadingTime=55
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if showMyText>0
{
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_middle)
  textDropShadow("PRESS UP TO BUY AN ENERGY DRINK#1000 INTERNETZ#RESTORES HALF YOUR HEARTS##PRESS DOWN TO BUY A TURBO SMOOTHIE#3000 INTERNETZ#FULLY RESTORES ALL OF YOUR HEARTS",x,y-120,helpTextInner,helpTextOuter,4)
}
