#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

pastMessageAlpha=0
pastMessageSpr=sPastMessage_01
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  if room=rPttT_02 //------------------------------ [1] You must remember ------------------------------
  {
    if sceneProgress=0
    {
      if !instance_exists(oEvSpot_FlashTrigger)
      {
        createScreenText(70,100,-1,fnt_ScreenText,fa_left,"You must remember, Jeremy.",3,c_white,1,0)
        oScreenText.image_alpha=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=25 {oScreenText.image_alpha+=0.04}
      else if sceneDelay=90
      {
        myLingerText=instance_create(156,100,oLingerText)
        myLingerText.screenText="remember"
      }
      else if sceneDelay>=91 and sceneDelay<=115 {oScreenText.image_alpha-=0.04}
      else if sceneDelay>=200 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jeremy","Wait what? What am I supposed to remember?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
    }
  }
  else if room=rPttT_03 //------------------------------ [2] Flashback ------------------------------
  {
    if sceneProgress=0
    {
      if !instance_exists(oEvSpot_FlashTrigger)
      {
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=50 {pastMessageAlpha+=0.01}
      else if sceneDelay>=201 and sceneDelay<=250 {pastMessageAlpha-=0.01}
      else if sceneDelay>=260
      {
        pastMessageSpr=sPastMessage_02
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=50 {pastMessageAlpha+=0.01}
      else if sceneDelay>=201 and sceneDelay<=250 {pastMessageAlpha-=0.01}
      else if sceneDelay>=260
      {
        pastMessageSpr=sPastMessage_03
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=50 {pastMessageAlpha+=0.01}
      else if sceneDelay>=201 and sceneDelay<=250 {pastMessageAlpha-=0.01}
      else if sceneDelay>=260
      {
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
  else if room=rPttT_04 //------------------------------ [3] Jeremy & Chao talk ------------------------------
  {
    if sceneProgress=0
    {
      if !instance_exists(oEvSpot_FlashTrigger)
      {
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Chao","Jeremy, can you really do what that, uh... flashback was saying?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jeremy","I had forgotten I could even do that, though the problem now is I don't know how to do that.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if sceneDelay>=140 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Chao","It would probably be useful sometime if we figure it out.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay>=90 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jeremy","Considering we don't know what Hex has planned, definitely. Though I worry what such an action would do.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150
      }
      else if sceneDelay>=150 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Chao","What do you mean?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay>=60 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jeremy","How far back would an 'undo' send everything? Would that destabilize the program? Would we lose our memories? I have so many questions about what a function like that would do here.",0,3,oMessagePerson,0)
        newMessage.fadingTime=200
      }
      else if sceneDelay>=200 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        if global.gamePttT_Prog>=80
        {
          msgCreate(0,0,"Jeremy","In any case, let's continue. We need to figure out this puzzle.",0,2,oMessagePerson,0)
        }
        else
        {
          msgCreate(0,0,"Jeremy","In any case, let's continue. We still need to hunt down that Parasite... thing.",0,2,oMessagePerson,0)
        }
        newMessage.fadingTime=130
      }
      else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if room=rPttT_05 //------------------------------ [4] Do not forget ------------------------------
  {
    if sceneProgress=0
    {
      if !instance_exists(oEvSpot_FlashTrigger)
      {
        createScreenText(30,100,-1,fnt_ScreenText,fa_left,"Do not forget to undo what needs to be undone.",3,c_white,1,0)
        oScreenText.image_alpha=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay>=1 and sceneDelay<=25 {oScreenText.image_alpha+=0.04}
      else if sceneDelay=90
      {
        myLingerText=instance_create(170,100,oLingerText)
        myLingerText.screenText="undo"
      }
      else if sceneDelay>=91 and sceneDelay<=115 {oScreenText.image_alpha-=0.04}
      else if sceneDelay>=200 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jeremy","But what needs to be undone? This is so unclear. What did we mess up?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
  }
  else if room=rPttT_08 //------------------------------ [5] What we learned ------------------------------
  {
    if sceneProgress=0
    {
      if !instance_exists(oEvSpot_FlashTrigger)
      {
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jerry","What did we accomplish down here?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jeremy","We got rid of the parasite that took control of the Abomination.",0,2,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if sceneDelay>=110 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jerry","Did we need to? And what was up with all that flashback stuff?",0,2,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if sceneDelay>=110 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Chao","Something was warning us. It was telling us we need to do something.",0,2,oMessagePerson,0)
        newMessage.fadingTime=110
      }
      else if sceneDelay>=110 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jeremy","It was telling me how I can undo something, but I'm still not sure how.",0,2,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay>=130 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=6
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Chao","If we need to, we can look through the rooms and review any of that. ANYTHING in here could be a clue on what we need to do. Those words appearing, headers, everything.",0,3,oMessagePerson,0)
        newMessage.fadingTime=180
      }
      else if sceneDelay>=180 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Jerry","This is an annoying sounding puzzle.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay>=70 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=8
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        msgCreate(0,0,"Chao","Just note that all the clues are in this cave.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay>=120 {sceneDelay=0; sceneProgress+=1}
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if pastMessageAlpha>0
{
  draw_sprite_ext(pastMessageSpr,0,view_xview[0]+16,view_yview[0]+96,1,1,0,c_white,pastMessageAlpha)
}
