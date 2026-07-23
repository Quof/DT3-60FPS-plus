#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oPlayer1.sprite_index=sJerryDamaged
awardAwesome(500)
global.checkForDeath=1
global.hitsTaken=0
global.killStreak=0
global.gamePaused=true
global.bCanGameOver=true
failColor=c_white

failMessage=":3 :3 :3 :3 :3"
hintMessage="You know you want to keep going, so we limited your options."

//Reset ammo and player momentum
staticEffect=0
oPlayer1.xVel=0
oPlayer1.yVel=0
oPlayer1.xAcc=0
oPlayer1.yAcc=0

//Set up menu
backAlpha=0
backColor=c_white

showOptions=0
useCommands=false

menuSelections=1
GOCursorInc=34
GOMenuMax=1
GOMenuMin=1
GOCursorPos=1
GOCursorY=135

confirmPressNum=0
gameOverProg=0
gameOverTime=0

stopLoopingSounds()
stopAllMusic()
playSound(global.snd_GameOver,0,1,1)

image_speed=0.2
for (i=0;i<7;i+=1) {background_foreground[i]=false}
background_visible[7]=true
background_foreground[7]=true
view_angle[0]=0

confirmFadeOut=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if staticEffect>=2 //fade to black
{
  staticEffect+=1
  if staticEffect=3
  {
    background_alpha[7]=0
    backAlpha=1
  }
  else if staticEffect=10
  {
    backColor=c_black
    if showOptions=0 {showOptions=1}
  }
}
else //static effect
{
  staticEffect+=0.04
  if staticEffect>=1.4 {staticEffect=2}
  background_alpha[7]=staticEffect
}

if showOptions>0 and useCommands=false //Start options
{
  showOptions+=1
  if showOptions=2 {playSound(global.snd_Continue,0,1,1)}
  if showOptions=5
  {
    useCommands=true
  }
}

if useCommands=true
{
  if gameOverProg=0
  {
    if oKeyCodes.kCodePressed[4]=1 //Down
    {
      playSound(global.snd_MenuCursor,0,1,1)
    }
    if oKeyCodes.kCodePressed[3]=1 //Up
    {
      playSound(global.snd_MenuCursor,0,1,1)
    }
    if oKeyCodes.kCodePressed[5]=1 //Confirm
    {
      resetKeyCodes()
      if confirmPressNum<=82 {playSound(global.snd_Error,0,1,1)}
      confirmPressNum+=1
      if confirmPressNum=3
      {
        hintMessage="Hmm, something seems to be wrong. Maybe you should keep pressing the button."
      }
      else if confirmPressNum=10
      {
        hintMessage="Yep, something is wrong. Perhaps mashing fast would do the trick."
      }
      else if confirmPressNum=30
      {
        hintMessage="STOP!!"
      }
      else if confirmPressNum=36
      {
        hintMessage="Why didn't you stop though?"
      }
      else if confirmPressNum=45
      {
        hintMessage="You have a problem."
      }
      else if confirmPressNum=50
      {
        hintMessage="Do you really want to try again that badly?"
      }
      else if confirmPressNum=60
      {
        hintMessage="The last attack is impossible to dodge, there's no point in trying again."
      }
      else if confirmPressNum=66
      {
        hintMessage="I'm a buggy menu, continuing to mash the confirm button is not going to magically make this work."
      }
      else if confirmPressNum=75
      {
        hintMessage="True insanity tries the same thing and gets that different result."
      }
      else if confirmPressNum=80
      {
        hintMessage="This"
      }
      else if confirmPressNum=81
      {
        hintMessage="will"
      }
      else if confirmPressNum=82
      {
        hintMessage="not"
      }
      else if confirmPressNum=83
      {
        playSound(global.snd_Retry,0,1,1)
        hintMessage="!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        gameOverProg=1
      }
    }
  }
  else if gameOverProg=1 //Final fade out
  {
    gameOverTime+=1
    if gameOverTime>=1 and gameOverTime<=100 {confirmFadeOut+=0.01}
    else if gameOverTime>=110
    {
      global.gamePaused=false; global.gameOver=false
      //Ammo
      global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
      room_restart()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Background
draw_set_alpha(backAlpha)
draw_set_color(backColor)
draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,false)

if showOptions>0
{
  //Game Over
  draw_set_halign(fa_center)
  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_set_font(fnt_GameOver)
  draw_text(view_xview[0]+240,view_yview[0]+30,"GAME OVER")
  draw_set_font(fnt_Points)
  draw_set_color(failColor)
  draw_text(view_xview[0]+240,view_yview[0]+68,failMessage)
  draw_set_font(fnt_GOoptions)
  draw_set_color(c_white)
  menuStartY=135

  //Display menu selection braces
  for(i=0;i<menuSelections;i+=1)
  {
    draw_sprite(sGameOverCursor,0,view_xview[0]+240,view_yview[0]+menuStartY+(i*34))
  }
  //Display cursor
  if useCommands=true
    draw_sprite(sGameOverCursor,1,view_xview[0]+240,view_yview[0]+GOCursorY)

  //Display menu selections
  draw_text(view_xview[0]+240,view_yview[0]+126,"Retry Encounter")

  //Display hint
  draw_set_font(fnt_Points)
  draw_set_halign(fa_left)
  draw_text_ext(view_xview[0]+68,view_yview[0]+300,hintMessage,12,344)

  //Final fade out
  draw_set_alpha(confirmFadeOut)
  draw_set_color(c_black)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,false)
}
