#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
quizType=0
cursorPos=1
cursorY=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if x<=oPlayer1.x {image_xscale=1}
else {image_xscale=-1}

if quizType=1
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorPos=1 {cursorPos=3}
    else if cursorPos=2 {cursorPos=1}
    else if cursorPos=3 {cursorPos=2}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if cursorPos=1 {cursorPos=2}
    else if cursorPos=2 {cursorPos=3}
    else if cursorPos=3 {cursorPos=1}
  }

  if cursorPos=1 {cursorY=3}
  else if cursorPos=2 {cursorY=15}
  else if cursorPos=3 {cursorY=27}

  if oKeyCodes.kCodePressed[5]=1
  {
    resetKeyCodes()
    if cursorPos=1
    {
      myTrivia=instance_create(0,0,oTriviaWindow)
      myTrivia.quizType=1
    }
    else if cursorPos=2
    {
      myTrivia=instance_create(0,0,oTriviaWindow)
      myTrivia.quizType=2
    }
    else if cursorPos=3
    {
      global.gamePaused=false
      msgCreate(170,20,"Trivia Lord","You make me sad.",6,0,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    quizType=0
    cursorPos=1
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  /*if global.gameProgress<=3870
  {
    myTrivia=instance_create(0,0,oTriviaWindow)
    myTrivia.quizType=1
  }
  else {quizType=1}*/
  quizType=1
  scenePChk(x-24,y,0,0.1,1)
  global.gamePaused=true
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if quizType=1
{
  myMenuX=view_xview[0]+120
  myMenuY=view_yview[0]+120
  menuSizeX=136
  menuSizeY=41
  draw_set_alpha(1)
  draw_set_halign(fa_left)
  draw_set_color(c_gray)
  draw_set_font(fnt_EnemyName)
  draw_rectangle(myMenuX,myMenuY,myMenuX+menuSizeX,myMenuY+menuSizeY,0)
  draw_set_color(c_white)
  draw_rectangle(myMenuX+1,myMenuY+1,myMenuX+menuSizeX-1,myMenuY+menuSizeY-1,1)
  draw_set_color(c_black)
  draw_rectangle(myMenuX,myMenuY,myMenuX+menuSizeX,myMenuY+menuSizeY,1)
  draw_text(myMenuX+5,myMenuY+2,"Take 10 Question Quiz")
  draw_text(myMenuX+5,myMenuY+14,"Take Full Quiz")
  draw_text(myMenuX+5,myMenuY+26,"I Hate Being Quizzed")
  draw_rectangle(myMenuX+3,myMenuY+cursorY,myMenuX+130,myMenuY+cursorY+11,1)
}
