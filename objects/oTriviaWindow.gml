#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
windowX=0
windowY=0
cursorPos=1
cursorX=10
cursorY=81
newQuestionDelay=20 //If at 100, it is waiting for a question to be answered
cancelQuiz=0
bDoNotIncrement=0 //Used for question 50

currentQuestion=0 //The current question in the quiz's set
maxQuestion=10 //Max questions in quiz
numCorrect=0 //Number of questions answered correctly
triviaScore=0 //The score at the end of the quiz

triviaQ=""
triviaA1=""
triviaA2=""
triviaA3=""
triviaA4=""
triviaA5=""
triviaA6=""
rightAnswer=0

questionNum=0 //The question in the list (used for finding the question information)
numInList=51 //Number of questions in the list

bTriviaReady=0
bTriviaComplete=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if quizType=1
{
  myQuestion[0]=irandom_range(1,5)
  myQuestion[1]=irandom_range(6,10)
  myQuestion[2]=irandom_range(11,15)
  myQuestion[3]=irandom_range(16,20)
  myQuestion[4]=irandom_range(21,25)
  myQuestion[5]=irandom_range(26,30)
  myQuestion[6]=irandom_range(31,35)
  myQuestion[7]=irandom_range(36,40)
  myQuestion[8]=irandom_range(41,45)
  myQuestion[9]=irandom_range(46,49)
}
else if quizType=2
{
  maxQuestion=numInList
  for(i=0;i<numInList;i+=1)
  {
    myQuestion[i]=i+1
  }
}

if global.gameProgress=3860
{
  myQuestion[0]=1
  myQuestion[1]=5
  myQuestion[2]=9
  myQuestion[3]=14
  myQuestion[4]=19
  myQuestion[5]=22
  myQuestion[6]=26
  myQuestion[7]=31
  myQuestion[8]=34
  myQuestion[9]=38
}

bTriviaReady=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTriviaReady=1
{
  if newQuestionDelay=100
  {
    if oKeyCodes.kCodePressed[1]=1 //Left
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorPos=1 {cursorPos=4}
      else if cursorPos=2 {cursorPos=5}
      else if cursorPos=3 {cursorPos=6}
      else if cursorPos=4 {cursorPos=1}
      else if cursorPos=5 {cursorPos=2}
      else if cursorPos=6 {cursorPos=3}
    }
    else if oKeyCodes.kCodePressed[2]=1 //Right
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorPos=1 {cursorPos=4}
      else if cursorPos=2 {cursorPos=5}
      else if cursorPos=3 {cursorPos=6}
      else if cursorPos=4 {cursorPos=1}
      else if cursorPos=5 {cursorPos=2}
      else if cursorPos=6 {cursorPos=3}
    }
    else if oKeyCodes.kCodePressed[3]=1 //Up
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorPos=1 {cursorPos=3}
      else if cursorPos=2 {cursorPos=1}
      else if cursorPos=3 {cursorPos=2}
      else if cursorPos=4 {cursorPos=6}
      else if cursorPos=5 {cursorPos=4}
      else if cursorPos=6 {cursorPos=5}
    }
    else if oKeyCodes.kCodePressed[4]=1 //Down
    {
      playSound(global.snd_MenuCursor,0,1,1)
      if cursorPos=1 {cursorPos=2}
      else if cursorPos=2 {cursorPos=3}
      else if cursorPos=3 {cursorPos=1}
      else if cursorPos=4 {cursorPos=5}
      else if cursorPos=5 {cursorPos=6}
      else if cursorPos=6 {cursorPos=4}
    }
    else if oKeyCodes.kCodePressed[5]=1 //Confirm
    {
      if questionNum>0
      {
        if questionNum=50 //Question 50
        {
          if cursorPos=rightAnswer
          {
            msgCreate(170,20,"Trivia Lord","Correct!!",6,0,oMessagePerson,0)
            newMessage.fadingTime=35
            playSound(global.snd_MarioCoin,0,1,1)
            numCorrect+=1
            if currentQuestion=maxQuestion {newQuestionDelay=200}
            else {newQuestionDelay=30}
          }
          else if cursorPos=6 //Answer "No." on question 50
          {
            msgCreate(170,20,"Trivia Lord","But thou must!",6,0,oMessagePerson,0)
            newMessage.fadingTime=60
            playSound(global.snd_Error,0,1,1)
            newQuestionDelay=55
            bDoNotIncrement=1
            var tCheckAchieve;
            tCheckAchieve=string_char_at(global.tokenRecognitions,46)
            if tCheckAchieve="0"
            {
              var tAchievement;
              tAchievement=instance_create(0,0,oAchievementNotice)
              tAchievement.myAchievement="But Thou Must"; tAchievement.checkNum=46
            }
          }
          else
          {
            msgCreate(170,20,"Trivia Lord","So wrong.",7,0,oMessagePerson,0)
            newMessage.fadingTime=35
            playSound(global.snd_Error,0,1,1)
            if currentQuestion=maxQuestion {newQuestionDelay=200}
            else {newQuestionDelay=30}
          }
        }
        else //Questions
        {
          if cursorPos=rightAnswer
          {
            msgCreate(170,20,"Trivia Lord","Correct!!",6,0,oMessagePerson,0)
            newMessage.fadingTime=35
            playSound(global.snd_MarioCoin,0,1,1)
            numCorrect+=1
            if currentQuestion=maxQuestion {newQuestionDelay=200}
            else {newQuestionDelay=30}
          }
          else
          {
            msgCreate(170,20,"Trivia Lord","So wrong.",7,0,oMessagePerson,0)
            newMessage.fadingTime=35
            playSound(global.snd_Error,0,1,1)
            if currentQuestion=maxQuestion {newQuestionDelay=200}
            else {newQuestionDelay=30}
          }
        }
      }
    }

    if cancelQuiz>0 {cancelQuiz-=1}
    if global.gameProgress>=3870
    {
      if oKeyCodes.kCodePressed[6]=1 and bTriviaComplete=0 //Cancel Trivia
      {
        if cancelQuiz=0 {cancelQuiz=45}
        else
        {
          resetKeyCodes()
          global.gamePaused=false
          instance_destroy()
        }
      }
    }

    if global.debugMenu=true //Debug commands
    {
      if oKeyCodes.kCodePressed[8]=1 //New Ordered Question
      {
        npcTrivia(questionOrder)
        if questionOrder>numInList {questionOrder=1}
      }
      else if oKeyCodes.kCodePressed[9]=1 //New Random Question
      {
        npcTrivia(irandom_range(1,numInList))
      }
      else if oKeyCodes.kCodePressed[10]=1 //New Specific Question
      {
        npcTrivia(numInList)
      }
    }
    //Place cursor
    if cursorPos=1 {cursorX=10; cursorY=81}
    else if cursorPos=2 {cursorX=10; cursorY=105}
    else if cursorPos=3 {cursorX=10; cursorY=129}
    else if cursorPos=4 {cursorX=168; cursorY=81}
    else if cursorPos=5 {cursorX=168; cursorY=105}
    else if cursorPos=6 {cursorX=168; cursorY=129}
  }

  //Set next question
  if newQuestionDelay<=60
  {
    newQuestionDelay-=1
    if newQuestionDelay<=0
    {
      if bDoNotIncrement=0 {currentQuestion+=1}
      bDoNotIncrement=0
      questionNum=myQuestion[currentQuestion-1]
      npcTrivia(questionNum)
      if questionNum=10 or questionNum=13 or questionNum=45 or questionNum=51 {global.recBirdsSeen+=1}
      else if questionNum=28 {global.recBirdsSeen+=2}
      newQuestionDelay=100
    }
  }
  //Trivia finished
  if newQuestionDelay>=200 //Tally up score
  {
    newQuestionDelay+=1
    if newQuestionDelay=230 {bTriviaComplete=1}
    else if newQuestionDelay=280
    {
      triviaScore=numCorrect/maxQuestion
      triviaScore=round(triviaScore*100)

      msgCreate(40,180,"Trivia Lord",string("You got a score of ") +string(triviaScore) +string("%."),6,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if newQuestionDelay=350 //Award points
    {
      if triviaScore=100
      {
        if global.yoshiDoll<=3
        {
          msgCreate(40,180,"Trivia Lord","AMAZING!! YOU GOT THEM ALL CORRECT!! TAKE ALL THESE YOSHI DOLLS!! ALL OF THEM!!",6,2,oMessagePerson,0)
          global.yoshiDoll=4
        }
        else
        {
          msgCreate(40,180,"Trivia Lord","YOU MUST REALLY LOVE THIS!! YOU GOT THEM ALL CORRECT AGAIN!! UNFORTUNATELY I HAVE NO MORE PRIZES TO GIVE!!",6,2,oMessagePerson,0)
        }

        if maxQuestion=numInList //Achievement if full quiz and 100%
        {
          var tCheckAchieve;
          tCheckAchieve=string_char_at(global.tokenRecognitions,25)
          if tCheckAchieve="0"
          {
            var tAchievement;
            tAchievement=instance_create(0,0,oAchievementNotice)
            tAchievement.myAchievement="You Know Everything"; tAchievement.checkNum=25
          }
        }
      }
      else if triviaScore>=80 and triviaScore<=99
      {
        if global.yoshiDoll<=2
        {
          msgCreate(40,180,"Trivia Lord","That was great! You got most of them correct! Take this Yoshi Doll as a prize!!",6,2,oMessagePerson,0)
          global.yoshiDoll=3
        }
        else
        {
          msgCreate(40,180,"Trivia Lord","Hey, you scored very well, but you've gotten this prize already, so no reward.",6,2,oMessagePerson,0)
        }
      }
      else if triviaScore>=50 and triviaScore<=79
      {
        if global.yoshiDoll<=1
        {
          msgCreate(40,180,"Trivia Lord","That was sort of okay-ish. Here's a Yoshi Doll prize for getting that many correct.",6,2,oMessagePerson,0)
          global.yoshiDoll=2
        }
        else
        {
          msgCreate(40,180,"Trivia Lord","You kinda did okay. You've gotten this prize already, so I can't award you anything.",6,2,oMessagePerson,0)
        }
      }
      else if triviaScore<=49
      {
        if global.yoshiDoll=0
        {
          msgCreate(40,180,"Trivia Lord","That wasn't very good at all, but here's a Yoshi Doll as a participation prize.",6,2,oMessagePerson,0)
          global.yoshiDoll=1
        }
        else
        {
          msgCreate(40,180,"Trivia Lord","You didn't do very well and you've already gotten the prize for this so...YOU GET NOTHING!!",6,2,oMessagePerson,0)
        }
      }
      newMessage.fadingTime=120
    }
    else if newQuestionDelay=470 //End quiz
    {
      if global.gameProgress=3860 //First quiz
      {
        oEvCh15MainA.sceneProgress=50
      }
      else
      {
        global.gamePaused=false
      }
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTriviaReady=1
{
  //Set window position
  windowX=view_xview[0]+70
  windowY=view_yview[0]+32
  draw_sprite(sTriviaWindow,0,windowX,windowY)
  if bTriviaComplete=0
  {
    //Display current question
    draw_set_alpha(1)
    draw_set_color(c_white)
    draw_set_halign(fa_right)
    draw_set_font(fnt_EnemyName)
    if currentQuestion>0 {draw_text(windowX+112,windowY+3,string(currentQuestion) +string(" / ") +string(maxQuestion))}
    if global.debugMenu=true //Display question number from list
    {
      if questionNum>0 {draw_text(windowX+326,windowY+3,string("[") +string(questionNum) +string("]"))}
    }
    //Display question
    draw_set_halign(fa_left)
    draw_set_font(fnt_Points)
    draw_text_ext(windowX+6,windowY+18,triviaQ,13,330)
    //Display answer choices
    draw_set_font(fnt_EnemyName)
    draw_text(windowX+32,windowY+86,triviaA1)
    draw_text(windowX+32,windowY+110,triviaA2)
    draw_text(windowX+32,windowY+134,triviaA3)
    draw_text(windowX+190,windowY+86,triviaA4)
    draw_text(windowX+190,windowY+110,triviaA5)
    draw_text(windowX+190,windowY+134,triviaA6)
    //Display cursor
    draw_set_color(c_green)
    draw_set_alpha(0.2)
    draw_rectangle(windowX+cursorX,cursorY+windowY,windowX+cursorX+156,cursorY+windowY+23,0)
    draw_set_alpha(1)
    draw_rectangle(windowX+cursorX,cursorY+windowY,windowX+cursorX+156,cursorY+windowY+23,1)
    draw_rectangle(windowX+cursorX+1,cursorY+windowY+1,windowX+cursorX+155,cursorY+windowY+22,1)

    //Display cancel confirmation
    if cancelQuiz>0
    {
      draw_set_font(fnt_ColorTime)
      draw_set_halign(fa_center)
      draw_set_color(c_red)
      draw_set_alpha(0.1+(cancelQuiz/50))
      draw_text(windowX+170,windowY+80,"PRESS CANCEL AGAIN#TO QUIT THE TRIVIA")
    }
  }
}
if bTriviaComplete=1
{
  resultsX=windowX+109
  resultsY=windowY+3
  draw_sprite(rTriviaResults,0,resultsX,resultsY)
  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_set_halign(fa_right)
  draw_set_font(fnt_EnemyName)
  draw_text(resultsX+118,resultsY+16,maxQuestion)
  draw_text(resultsX+118,resultsY+27,numCorrect)
}
