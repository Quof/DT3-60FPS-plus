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
  if room=rHPF_A
  {
    if global.gameProgress<=3940 //I don't like those cameras
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
      if charDialogue[0]=0 and oPlayer1.x>=1728
      {
        msgCreate(0,0,"Jerry","I really don't like those cameras.",0,2,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Claire","They ARE pretty creepy.",0,0,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
    }
  }
  else if room=rHPF_C
  {
    if global.gameProgress<=3960 //A door blocks the way
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
      if charDialogue[0]=0 and oPlayer1.x>=1584
      {
        global.gameProgress=3960
        msgCreate(0,0,"Jerry","Hey, that bot said all security doors would be open for us!",0,2,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=120 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Jeremy","Hmm, hold on a second, I'll see if I can hack the door open.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=200 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jeremy","Damn, I can't do it from here for some reason.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=6
      {
        msgCreate(0,0,"Chao","I think I can open the door if we head back to that terminal 2 rooms back.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130; charDialogue[0]+=1
      }
      else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=130 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=8
      {
        msgCreate(0,0,"Jeremy","It's worth a shot, go check it out you guys.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
    }
  }
}
