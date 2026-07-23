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
  if room=rWepFacB
  {
    if global.gameProgress=4260 //Hex and the Warmaster speak
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
      if charDialogue[0]=0 and oPlayer1.x<=400
      {
        msgCreate(0,0,"?????","They'll be here soon according to my scouts.",6,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Hex","They'll be too late to stop it from happening.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"?????","So is it true, can you not see them anymore?",6,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=6
      {
        msgCreate(0,0,"Hex","Yes, I was unaware that removing the Virus would also remove my ability to see their location.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150; charDialogue[0]+=1
      }
      else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=8
      {
        msgCreate(0,0,"?????","I'm sure the program fixed the bug is all.",6,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=10
      {
        msgCreate(0,0,"Hex","It doesn't matter, your scouts can keep us informed.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=12
      {
        msgCreate(0,0,"?????","Since they will arrive soon, I will prepare the troops.",6,2,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=13
      {
        convo[0]+=1
        if convo[0]=90
        {
          (363322).sprite_index=sWarmasterA_Run;
          (363322).image_speed=0.4; (363322).image_xscale=-1.25;
        }
        else if convo[0]>=91 and convo[0]<=106 {(363322).x-=6}
        else if convo[0]>=107
        {
          (363322).sprite_index=sWarmasterA_Idle; (363322).image_speed=0.15;
          charDialogue[0]+=1; convo[0]=0
        }
      }
      else if charDialogue[0]=14
      {
        msgCreate(0,0,"Hex","One more thing, Warmaster.",0,2,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=15 {convo[0]+=1;if convo[0]>=80 {(363322).image_xscale=1.25; charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=16
      {
        msgCreate(0,0,"Warmaster","What is it?",6,2,oMessagePerson,0)
        newMessage.fadingTime=60; charDialogue[0]+=1
      }
      else if charDialogue[0]=17 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=18
      {
        msgCreate(0,0,"Hex","Prepare the mechs instead.",0,2,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
      else if charDialogue[0]=19
      {
        convo[0]+=1
        if convo[0]=80
        {
          (363322).sprite_index=sWarmasterA_Run;
          (363322).image_speed=0.4; (363322).image_xscale=-1.25;
        }
        else if convo[0]>=81 and convo[0]<=106 {(363322).x-=6}

        if convo[0]>=101 and convo[0]<=120
        {
          (363323).image_alpha-=0.05
        }
        else if convo[0]>=121
        {
          with (363322) {instance_destroy()}
          with (363323) {instance_destroy()}
          charDialogue[0]+=1; convo[0]=0
        }
      }
    }
  }
  else if room=rLowFacE
  {
    if global.gameProgress=4370 //Horde of robots
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
      if charDialogue[0]=0 and oPlayer1.x>=704
      {
        msgCreate(0,0,"Jeremy","Oh wow, there's way more than I thought. There are rooms and rooms of these here.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Chao","CHAOS is planning a full on invasion.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jeremy","I'm going to place one of the bombs here. We can hit all the storage rooms with it.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=6
      {
        msgCreate(0,0,"Jerry","Is there going to be some sort of timer?",0,1,oMessagePerson,0)
        newMessage.fadingTime=100; charDialogue[0]+=1
      }
      else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=8
      {
        msgCreate(0,0,"Jeremy","No, I'll set them off when we're ready. We need to find what it is that CHAOS is hiding down here.",0,2,oMessagePerson,0)
        newMessage.fadingTime=180; charDialogue[0]+=1
      }
      else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=180 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=10
      {
        msgCreate(0,0,"Jerry","Isn't this it?",0,0,oMessagePerson,0)
        newMessage.fadingTime=60; charDialogue[0]+=1
      }
      else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=12
      {
        msgCreate(0,0,"Jeremy","There's something else they have down here, I know it. Keep on going, I've removed the barrier at the end of this storage room.",0,3,oMessagePerson,0)
        newMessage.fadingTime=220; charDialogue[0]+=1
        global.gameProgress=4380
      }
    }
  }
  else if room=rLowFacH
  {
    if global.gameProgress=4400 //You go instead, Claire
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
      if charDialogue[0]=0 and oPlayer1.x>=128
      {
        msgCreate(0,0,"Jerry","I'll let you handle this one, Claire.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=110 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2 and oPlayer1.x<=512
      {
        if global.activeCharacter=0
        {
          msgCreate(0,0,"Claire","Oh really? I'll get right on that.",0,1,oMessagePerson,0)
          newMessage.fadingTime=90; charDialogue[0]+=1
        }
        else
        {
          msgCreate(0,0,"Jerry","Wow Claire, just wow. I was kidding!",0,1,oMessagePerson,0)
          newMessage.fadingTime=90; charDialogue[0]+=1
        }
      }
    }
  }
  else if room=rLowFacS
  {
    if global.gameProgress=4470 //Save, trust me
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
      if charDialogue[0]=0 and oPlayer1.x>=144
      {
        msgCreate(0,0,"Jeremy","Seriously you guys. Save your game here if you haven't done so in awhile.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
    }
  }
  else if room=rLavaCaveD
  {
    if global.gameProgress=4490 //Mario and the way out
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
      if charDialogue[0]=0 and oPlayer1.x>=96
      {
        msgCreate(0,0,"Jeremy","If you're ever in a bind like that back there, just know that your Mario abilities can't be blocked. Anyway, I found the way out.",0,3,oMessagePerson,0)
        newMessage.fadingTime=220; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=220 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Chao","You sure about that exit?",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jeremy","I know it's a long shot, but I think it'll work. There's no other way out that I can see anyway.",0,2,oMessagePerson,0)
        newMessage.fadingTime=170; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=170 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=6
      {
        msgCreate(0,0,"Jerry","What exactly is this way out?",0,1,oMessagePerson,0)
        newMessage.fadingTime=100; charDialogue[0]+=1
      }
      else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=8
      {
        msgCreate(0,0,"Jeremy","A lava geyser.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
      else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=10
      {
        msgCreate(0,0,"Jerry","Is that even safe!?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
      else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=12
      {
        msgCreate(0,0,"Jeremy","Of course!! Maybe, I mean in theory, you can just ride the rocks.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150; charDialogue[0]+=1
      }
      else if charDialogue[0]=13 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=14
      {
        msgCreate(0,0,"Jerry","Yep, we're dead.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=15 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=16
      {
        msgCreate(0,0,"Jeremy","Jokes aside, you should be fine.",0,1,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
      else if charDialogue[0]=17 {convo[0]+=1;if convo[0]>=120 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=18
      {
        msgCreate(0,0,"Jerry","'Should' being the word that scares me.",0,1,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
    }
  }
}
