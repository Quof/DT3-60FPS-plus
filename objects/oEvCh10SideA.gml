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
  if room=rVault_1
  {
    if global.gameProgress=2170 //Having dreams - Claire
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
      if charDialogue[0]=0 and oPlayer1.x>=800
      {
        msgCreate(0,0,"Claire","Jeremy, I had a dream while I was unconscious.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=95 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Jeremy","You can't dream in a computer program.",0,1,oMessagePerson,0)
        newMessage.fadingTime=85; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Claire","Well I did! I wouldn't make up something like that!",0,1,oMessagePerson,0)
        newMessage.fadingTime=100; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=105 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=6
      {
        msgCreate(0,0,"Jeremy","I just doubt that's what it was.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=85 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=8
      {
        msgCreate(0,0,"Claire","Whatever. It was just weird is all. I saw a creature asking for my help.",0,1,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
      else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=125 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=10
      {
        msgCreate(0,0,"Jeremy","Why did it need your help?",0,1,oMessagePerson,0)
        newMessage.fadingTime=75; charDialogue[0]+=1
      }
      else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=12
      {
        msgCreate(0,0,"Claire","I couldn't tell too well, but it looked like something had attached itself to it. A parasite of some kind.",0,2,oMessagePerson,0)
        newMessage.fadingTime=145; charDialogue[0]+=1
      }
      else if charDialogue[0]=13 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=14
      {
        msgCreate(0,0,"Jeremy","What did the creature look like?",0,1,oMessagePerson,0)
        newMessage.fadingTime=75; charDialogue[0]+=1
      }
      else if charDialogue[0]=15 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=16
      {
        msgCreate(0,0,"Claire","I can't describe it, things were fuzzy, but something was definitely leeching off of it.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130; charDialogue[0]+=1
      }
      else if charDialogue[0]=17 {convo[0]+=1;if convo[0]>=135 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=18
      {
        msgCreate(0,0,"Jeremy","Huh...",0,0,oMessagePerson,0)
        newMessage.fadingTime=55; charDialogue[0]+=1
      }
    }
    else if global.gameProgress=2250 //Having dreams - Jerry
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
      if charDialogue[0]=0 and oPlayer1.x>=368
      {
        msgCreate(0,0,"Jerry","Something weird happened while I was asleep... I had a dream.",0,1,oMessagePerson,0)
        newMessage.fadingTime=95; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Claire","You too? What did you dream about?",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=85 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jerry","The two of us were confronted by a creature.",0,1,oMessagePerson,0)
        newMessage.fadingTime=85; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=6
      {
        msgCreate(0,0,"Claire","Grotesque?",0,1,oMessagePerson,0)
        newMessage.fadingTime=45; charDialogue[0]+=1
      }
      else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=50 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=8
      {
        msgCreate(0,0,"Jerry","Yes... It said something, but I couldn't understand all of it. I think it wanted our help.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130; charDialogue[0]+=1
      }
      else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=135 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=10
      {
        msgCreate(0,0,"Claire","In my dream, it said we would save everyone if we could help it.",0,2,oMessagePerson,0)
        newMessage.fadingTime=125; charDialogue[0]+=1
      }
      else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=130 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=12
      {
        msgCreate(0,0,"Jerry","Yeah. I don't know what it's talking about though.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
    }
  }
  else if global.gameProgress=2190 and room=rVault_2 //Sticks for platforms
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
    if charDialogue[0]=0 and oPlayer1.x>=2048
    {
      msgCreate(0,0,"Claire","Oh you have to be kidding...",0,1,oMessagePerson,0)
      newMessage.fadingTime=85; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jeremy","You might be happy to know that those are technically 4 pixels wide.",0,1,oMessagePerson,0)
      newMessage.fadingTime=130; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=135 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Claire","That really doesn't help much, Jeremy.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
  }
  else if global.gameProgress=2270 and room=rVault_4 //Time switch doors
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
    if charDialogue[0]=0 and oPlayer1.x>=384
    {
      msgCreate(0,0,"Hex","I'm sure you know this already. That door can only be opened if all the nearby switches are triggered quickly. Wouldn't want you getting stuck on something so easy.",0,3,oMessagePerson,0)
      newMessage.fadingTime=235; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=240 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jerry","We didn't like you before, and we still don't like you now.",0,1,oMessagePerson,0)
      newMessage.fadingTime=115; charDialogue[0]+=1
    }
  }
  else if global.gameProgress=2350 and room=rVault_8 //Hex taunts 1
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
    if charDialogue[0]=0 and oPlayer1.x>=1248
    {
      msgCreate(0,0,"Jeremy","Keep pressing onward, I'm going to try more searches for Chao.",0,2,oMessagePerson,0)
      newMessage.fadingTime=115; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=120 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Hex","You won't find her.",0,1,oMessagePerson,0)
      newMessage.fadingTime=75; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Claire","Oh go away. Jeremy, we'll find her!",0,1,oMessagePerson,0)
      newMessage.fadingTime=85; charDialogue[0]+=1
    }
  }
  else if global.gameProgress=2370 and room=rVault_9 //Color Zones
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
    if charDialogue[0]=0 and oPlayer1.x>=64
    {
      msgCreate(0,0,"Jeremy","Oh crap, I forgot to tell you about the Color Zones, in case you forgot. See that timer going down? When it hits 0, you need to be within whichever color is highlighted on the new HUD element.",0,3,oMessagePerson,0)
      if oColorIndControl.warnDelay=300 {newMessage.fadingTime=170}
      else {newMessage.fadingTime=340}
      charDialogue[0]+=1
      oColorIndControl.warnDelay=300
    }
  }
  else if global.gameProgress=2390 and room=rVault_10 //Hex taunts 2
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
      msgCreate(0,0,"Hex","Existence is a problem.",0,0,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=75 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Claire","You've got issues.",0,0,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=75 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Hex","I'm a computer program whose original purpose was to counter-act your hacking friend here. I should not exist. None of this should exist.",0,2,oMessagePerson,0)
      newMessage.fadingTime=150; charDialogue[0]+=1
    }
    else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=155 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=6
    {
      msgCreate(0,0,"Claire","But it does exist. It's the only world we have now, why fight it?",0,1,oMessagePerson,0)
      newMessage.fadingTime=100; charDialogue[0]+=1
    }
    else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=105 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=8
    {
      msgCreate(0,0,"Hex","The new girl thinks she can talk me down, how amusing.",0,2,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
    else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=95 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=10
    {
      msgCreate(0,0,"Claire","I wasn't trying to. I just don't get what you're trying to do.",0,2,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
    else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=95 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=12
    {
      msgCreate(0,0,"Hex","That's not for you to know.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
    else if charDialogue[0]=13 {convo[0]+=1;if convo[0]>=75 {charDialogue[0]+=1; convo[0]=0}}
  }
  else if global.gameProgress=2460 and room=rVault_15 //Cheap death
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
    if charDialogue[0]=0 and oPlayer1.x>=208 and oPlayer1.x<=304 and oPlayer1.y>=288
    {
      if global.activeCharacter=0
        msgCreate(160,224,"Jerry","WHAT THE DICK!?",0,1,oMessagePerson,0)
      else
        msgCreate(160,224,"Claire","THAT WAS CHEAP!!",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }
  }
}
