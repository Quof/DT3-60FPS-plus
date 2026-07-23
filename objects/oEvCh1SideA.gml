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
  if global.gameProgress=30 and room=rMain_2 //Key tutorial
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
    if charDialogue[0]=0 and oPlayer1.y<=192 and instance_number(oDoorKey)=2
    {
      msgCreate(0,0,"Jeremy","You can use that key to unlock locked doors.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1*gDeltaTime;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jerry","Really Jeremy?#REALLY?!",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }

    if charDialogue[1]=0 and oPlayer1.x>=880 and instance_number(oDoorKey)=1
    {
      msgCreate(0,0,"Jerry","Yeah, you didn't need to tell me about keys and locked doors.",0,1,oMessagePerson,0)
      newMessage.fadingTime=120; charDialogue[1]+=1
    }
    else if charDialogue[1]=1 and oPlayer1.y<=272 and instance_number(oDoorKey)=1
    {
      msgCreate(240,200,"Jerry","It's a bit too calm here... and boring.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[1]+=1
    }
    else if charDialogue[1]=2 {convo[1]+=1*gDeltaTime;if convo[1]>=100 {charDialogue[1]+=1; convo[1]=0}}
    else if charDialogue[1]=3
    {
      msgCreate(240,200,"Chao","I like it.",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[1]+=1
    }
    else if charDialogue[1]=4 {convo[1]+=1*gDeltaTime;if convo[1]>=70 {charDialogue[1]+=1; convo[1]=0}}
    else if charDialogue[1]=5
    {
      msgCreate(240,200,"Jeremy","Figures.",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[1]+=1
    }
    else if charDialogue[1]=6 {convo[1]+=1*gDeltaTime;if convo[1]>=70 {charDialogue[1]+=1; convo[1]=0}}
    else if charDialogue[1]=7
    {
      msgCreate(240,200,"Chao","Hmm?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[1]+=1
    }
    else if charDialogue[1]=8 {convo[1]+=1*gDeltaTime;if convo[1]>=70 {charDialogue[1]+=1; convo[1]=0}}
    else if charDialogue[1]=9
    {
      msgCreate(240,200,"Jeremy","Oh nothing.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[1]+=1
    }

    if charDialogue[2]=0 and oPlayer1.x>=1392
    {
      msgCreate(0,0,"Jeremy","You can't do anything to the Koopa, just run by it.",0,1,oMessagePerson,0)
      newMessage.fadingTime=110; charDialogue[2]+=1
    }
  }
  else if global.gameProgress=40 and room=rMain_3 //Drop through platform tutorial
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
    if charDialogue[0]=0 and oPlayer1.x>=176
    {
      msgCreate(0,0,"Jeremy","I know how familiar you are with bottomless pits.",0,1,oMessagePerson,0)
      newMessage.fadingTime=120; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1*gDeltaTime;if convo[0]>=130 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jerry","And it begins again.",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }

    if charDialogue[1]=0 and oPlayer1.x<=208 and oPlayer1.y<=144
    {
      msgCreate(0,0,"Jeremy","You can drop through some platforms by pressing [Down].",0,1,oMessagePerson,0)
      newMessage.fadingTime=120; charDialogue[1]+=1
    }
  }
  else if global.gameProgress=60 and room=rMain_4 //Useless banter (Jerry & Claire)
  {
    if sceneProgress=0
    {
      for (i=0;i<=2;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.y<=448 and instance_number(oDoorKey)=3
    {
      msgCreate(0,0,"Claire","You missed something.",0,1,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1*gDeltaTime;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jerry","I KNOW!",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1*gDeltaTime;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Claire","Just making sure you caught that.",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }

    if charDialogue[1]=0 and global.hitsTaken>=1
    {
      msgCreate(0,0,"Claire","You're not supposed to get hit.",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[1]+=1
    }
    else if charDialogue[1]=1 {convo[1]+=1*gDeltaTime;if convo[1]>=100 {charDialogue[1]+=1; convo[1]=0}}
    else if charDialogue[1]=2
    {
      msgCreate(0,0,"Jerry","I'll keep that in mind.",0,1,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[1]+=1
    }

    if charDialogue[2]=0 and instance_number(oDoorKey)=1
    {
      with (118684)
      {
        effect_create_above(ef_firework,x,bbox_bottom-(sprite_height/2),0,make_color_rgb(random(255),random(255),random(255)))
        instance_destroy()
      }
      with (118914)
      {
        effect_create_above(ef_firework,x,bbox_bottom-(sprite_height/2),0,make_color_rgb(random(255),random(255),random(255)))
        instance_destroy()
      }
      charDialogue[2]+=1
    }
  }
  else if global.gameProgress=90 and room=rMain_5 //Turn back
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
    if charDialogue[0]=0 and oPlayer1.x>=1568
    {
      msgCreate(0,0,"Jeremy","Turn around, you can't go this way yet.#I altered some terrain back there for you to get higher up.",0,2,oMessagePerson,0)
      newMessage.fadingTime=170; charDialogue[0]+=1
      tile_layer_show(999998)
      newSolid=instance_create(448,800,oInvisibleSolid)
      newSolid.image_yscale=3
      newSolid=instance_create(512,784,oInvisibleSolid)
      newSolid.image_yscale=4
      newSolid=instance_create(464,768,oInvisibleSolid)
      newSolid.image_xscale=3; newSolid.image_yscale=5
    }
    else if charDialogue[0]=1 {convo[0]+=1*gDeltaTime;if convo[0]>=180 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jerry","What's going on?",0,1,oMessagePerson,0)
      newMessage.fadingTime=50; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1*gDeltaTime;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Jeremy","Those 2 Hammer Bros are keeping that doorway there. You can't fight them as you are so you'll need to go around them instead.",0,2,oMessagePerson,0)
      newMessage.fadingTime=190; charDialogue[0]+=1
      global.gameProgress=100
    }
  }
}
