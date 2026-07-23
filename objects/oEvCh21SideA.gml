#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
whitePixel=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rCh21_Main_75
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
    if charDialogue[0]=0 and oPlayer1.x<=64
    {
      msgCreate(0,0,"Jeremy","Let's not go messing things up for ourselves. We've done enough of that already.",0,2,oMessagePerson,0)
      newMessage.fadingTime=140; charDialogue[0]+=1
    }
  }
  else if room=rAbomC and global.gameProgress=5540
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
    if charDialogue[0]=0 and oPlayer1.x>=192
    {
      msgCreate(0,0,"Jeremy","That thing is going to look different in here and we'll need a different approach. That you can be sure of.",0,2,oMessagePerson,0)
      newMessage.fadingTime=150; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jerry","Have any idea yet?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Jeremy","I'm gathering data now.",0,1,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[0]+=1
    }
  }
  else if room=rDistortionA and global.gameProgress=5600
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
    if charDialogue[0]=0 and oPlayer1.x>=560
    {
      msgCreate(0,0,"Hex","What are you doing, Jeremy?",0,1,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2 and oPlayer1.x>=1120
    {
      msgCreate(0,0,"Hex","How did you do this? How did you know?",0,1,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4 and oPlayer1.x>=1600
    {
      var tNewEnemy,tNewWall;
      tNewEnemy=instance_create(1776,96,oDistortedCry)
      tNewWall=instance_create(1840,0,oDistWall); tNewWall.image_yscale=22
      charDialogue[0]+=1
    }
    else if charDialogue[0]=5
    {
      if !instance_exists(oDistortedCry)
      {
        msgCreate(0,0,"Hex","Why would you come here knowing I have control in this space?",0,1,oMessagePerson,0)
        newMessage.fadingTime=110
        with oDistWall {instance_destroy()}
        charDialogue[0]+=1
      }
    }
  }
  else if room=rDistortionB and global.gameProgress=5610
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
    if charDialogue[0]=0 and oPlayer1.x>=176
    {
      var tNewWall;
      tNewWall=instance_create(1840,0,oDistWall); tNewWall.image_yscale=22
      msgCreate(0,0,"Hex","We were all going to die together... except for you.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2 and oPlayer1.x>=768
    {
      msgCreate(0,0,"Hex","You were supposed to think you won. Then you would get to watch them all die around you.",0,2,oMessagePerson,0)
      newMessage.fadingTime=110; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=110 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4 and oPlayer1.x>=1280
    {
      msgCreate(0,0,"Hex","It was going to be perfect.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
    else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=6
    {
      msgCreate(0,0,"Jeremy","Shut up, Hex. Your plan wouldn't have worked... It didn't work that way.",0,2,oMessagePerson,0)
      newMessage.fadingTime=110; charDialogue[0]+=1
    }
    else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=110 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=8
    {
      with oDistWall {instance_destroy()}
      msgCreate(0,0,"Hex","Oh, so you CAN speak. I have to ask. How did you see it?",0,2,oMessagePerson,0)
      newMessage.fadingTime=110; charDialogue[0]+=1
    }
  }
  else if room=rDistortionC and global.gameProgress=5620
  {
    if sceneProgress=0
    {
      for (i=0;i<=3;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=160
    {
      msgCreate(0,0,"Hex","So you don't want to speak?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jeremy","What's left to talk about, Hex? I already know what you have to say.",0,2,oMessagePerson,0)
      newMessage.fadingTime=110; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=110 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Hex","Then tell me, how did you do it?",0,1,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[0]+=1
    }
    else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=6
    {
      msgCreate(0,0,"Jeremy","I'm not giving you that satisfaction. All you need to know is I'm coming for you.",0,2,oMessagePerson,0)
      newMessage.fadingTime=120; charDialogue[0]+=1
    }
    else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=120 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=8
    {
      msgCreate(0,0,"Hex","You won't win in here. There's no point in trying.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100; charDialogue[0]+=1
    }
    else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=10
    {
      msgCreate(0,0,"Jeremy","That's nice.",0,0,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }
    else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=12
    {
      msgCreate(0,0,"Hex","...",0,0,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }
    else if charDialogue[0]=13 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}

    if charDialogue[1]=0 and oPlayer1.x>=1232 and oPlayer1.y<=800 //Gray wall
    {
      instance_create(0,0,oDist_GrayOverlay)
      charDialogue[1]+=1
    }

    if charDialogue[2]=0 and oPlayer1.x<=1328 and oPlayer1.y<=528 //White pixel
    {
      whitePixel=1
      charDialogue[2]+=1
    }
  }
  else if room=rDistortionD and global.gameProgress=5630
  {
    if sceneProgress=0
    {
      for (i=0;i<=3;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=160
    {
      msgCreate(0,0,"Hex","Look where we are. Back where we first met.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jeremy","You going to summon up an advancing wall of death?",0,1,oMessagePerson,0)
      newMessage.fadingTime=100; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Hex","Not this time.",0,0,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }
    else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=6
    {
      msgCreate(0,0,"Jeremy","And I know why. Because you can't. You're all talk here. You say you have control, but you don't.",0,2,oMessagePerson,0)
      newMessage.fadingTime=140; charDialogue[0]+=1
    }
    else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=140 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=8
    {
      msgCreate(0,0,"Hex","I have other...",0,1,oMessagePerson,0)
      newMessage.fadingTime=100; charDialogue[0]+=1
    }
    else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=25 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=10
    {
      msgCreate(0,0,"Jeremy","Shut up, Hex! You're all talk and you have nothing. Don't say another word to me, I don't want to hear it. I'm coming for you and if you try to run, I will find you.",0,3,oMessagePerson,0)
      newMessage.fadingTime=170; charDialogue[0]+=1
    }
    else if charDialogue[0]=11 {convo[0]+=1;if convo[0]>=190 {charDialogue[0]+=1; convo[0]=0}}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rDistortionC
{
  if whitePixel=1
  {
    draw_set_alpha(1)
    draw_set_color(c_white)
    draw_point(floor(view_xview[0]+164),floor(view_yview[0]+112))
  }
}
