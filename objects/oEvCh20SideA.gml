#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rWarshipB
  {
    if global.gameProgress=5060 //Jerry asks Claire about their relationship
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=320
      {
        msgCreate(0,0,"Jerry","Claire, there's something that's been on my mind lately.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Claire","What's going on, Jerry?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jerry","Well... eh, I've been thinking about, us. I mean, I know I wasn't the greatest to you before.",0,3,oMessagePerson,0)
        newMessage.fadingTime=160; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=160 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=6
      {
        msgCreate(0,0,"Claire","You're right about that.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60; charDialogue[0]+=1
      }
      else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=8
      {
        msgCreate(0,0,"Jerry","I want to try again, Claire. And I want to show you that I do care about you.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150; charDialogue[0]+=1
      }
      else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=10
      {
        msgCreate(0,0,"Claire","...",0,1,oMessagePerson,0)
        newMessage.fadingTime=40; charDialogue[0]+=1
      }
      else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=40 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=12
      {
        msgCreate(0,0,"Jerry","I'm sorry about before. I know an apology isn't worth anything on its own...",0,2,oMessagePerson,0)
        newMessage.fadingTime=140; charDialogue[0]+=1
      }
      else if charDialogue[0]=13 {convo[0]+=1;if convo[0]>=140 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=14
      {
        msgCreate(0,0,"Claire","When we get through this, we'll talk more.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=15 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=16
      {
        msgCreate(0,0,"Jerry","Huh, not even a tease or anything.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
      else if charDialogue[0]=17 {convo[0]+=1;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=18
      {
        msgCreate(0,0,"Claire","Let's get this done first.",0,1,oMessagePerson,0)
        newMessage.fadingTime=60; charDialogue[0]+=1
      }
      else if charDialogue[0]=19 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=20
      {
        msgCreate(0,0,"Jerry","Right on.",0,1,oMessagePerson,0)
        newMessage.fadingTime=50; charDialogue[0]+=1
      }
      else if charDialogue[0]=21 {convo[0]+=1;if convo[0]>=50 {charDialogue[0]+=1; convo[0]=0}}
    }
  }
  else if room=rWarshipZ_F
  {
    if global.gameProgress=5320 //Jeremy informs that this part isn't very long and Chao has a question
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=3616
      {
        msgCreate(0,0,"Jeremy","Good thing to note, this place isn't very long.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Chao","One that's bugging me. If you're here in the world proper with us, then are you still able to shut down the other power source?",0,3,oMessagePerson,0)
        newMessage.fadingTime=190; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=190 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jeremy","Yes, that won't be a problem. I've thought this all out.",0,3,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
    }
  }
  else if room=rWarshipZ_I
  {
    if global.gameProgress>=5500 //Jeremy blocks the path, not getting that ending again
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=432
      {
        msgCreate(0,0,"Jeremy","Seriously guys? We already know what happens if we go past this.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Jerry","Hey Jeremy, can you imagine if this is where it all ended and you didn't know about that undo trick you had?",0,2,oMessagePerson,0)
        newMessage.fadingTime=170; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=170 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jeremy","... Wow, thinking back on it. That would have been the worst.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      /*else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Jeremy","",0,1,oMessagePerson,0)
        newMessage.fadingTime=100; charDialogue[0]+=1
      }*/
    }
  }
}
