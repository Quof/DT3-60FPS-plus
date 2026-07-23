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
  if room=rMain_55
  {
    if global.gameProgress=3100 //Don't go into Neo Grime City
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
      if charDialogue[0]=0 and oPlayer1.x<=704
      {
        msgCreate(0,0,"Jeremy","Don't go into Neo Grime City. I've put up those barriers just in case. I know how you get curious.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=145 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Jerry","That's lame.",0,0,oMessagePerson,0)
        newMessage.fadingTime=55; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jeremy","Trust me, it's for your own safety.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
    }
  }
  else if room=rNGC_LC_A
  {
    if global.gameProgress=3200 //Destroy all the enemies
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
      if charDialogue[0]=0 and oPlayer1.x>=720
      {
        msgCreate(0,0,"Jeremy","It looks like there's a door at the end that won't open unless you defeat everything in here.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140; charDialogue[0]+=1
      }
    }
  }
  else if room=rNGC_LC_C
  {
    if global.gameProgress=3240 //Don't go into the light
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
      if charDialogue[0]=0 and oPlayer1.x>=352
      {
        msgCreate(0,0,"Claire","There's something in here, Jerry. I know it... We need to stay out of the light.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=130 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Jerry","Why?",0,0,oMessagePerson,0)
        newMessage.fadingTime=50; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=50 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Claire","Trust me on this. Stay out of line of sight while in the light.",0,1,oMessagePerson,0)
        newMessage.fadingTime=110; charDialogue[0]+=1
        global.gameProgress=3250
      }
    }
  }
}
