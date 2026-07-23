#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_black
fadeAlpha=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Alt ending for going into Abomination before finishing the Instrument quest
if sceneProgress=0
{
  if oPlayer1.x>=288
  {
    msgCreate(32,64,"Jeremy","What did you guys break this time?",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
    sceneProgress+=1
  }
}
else if sceneProgress=1
{
  sceneDelay+=1
  if sceneDelay=70
  {
    msgCreate(32,128,"Jerry","Nothing! We're just looking for something.",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
  }
  else if sceneDelay=140
  {
    msgCreate(32,128,"Jeremy","Oooh right. I remember what we're looking for now.",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=2
{
  if oPlayer1.x>=752
  {
    msgCreate(32,64,"Claire","Do you guys think it's in here?",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
    sceneProgress+=1
  }
}
else if sceneProgress=3
{
  sceneDelay+=1
  if sceneDelay=70
  {
    msgCreate(32,128,"Jerry","I bet it is. They probably hid it in here.",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=4
{
  if oPlayer1.x>=1248
  {
    msgCreate(32,64,"Chao","It's so here you guys. I can feel it.",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
    sceneProgress+=1
  }
}
else if sceneProgress=5
{
  sceneDelay+=1
  if sceneDelay=70
  {
    msgCreate(32,128,"Jeremy","Just keep going forward.",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=6
{
  if oPlayer1.x>=1888
  {
    msgCreate(32,64,"Chao","This is it. I think we're almost there!",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
    sceneProgress+=1
  }
}
else if sceneProgress=7
{
  sceneDelay+=1
  if sceneDelay=70
  {
    msgCreate(32,128,"Jeremy","Excitement you guys!",0,1,oMessagePerson,0)
    newMessage.fadingTime=60
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=8
{
  if oPlayer1.x>=2400 and oPlayer1.y>=448
  {
    stopAllMusic()
    sceneProgress+=1
  }
}
else if sceneProgress=9
{
  fadeAlpha+=0.1
  if fadeAlpha>=1
  {
    sceneProgress+=1
  }
}
else if sceneProgress=10
{
  if oPlayer1.x>=2400 and oPlayer1.y>=928
  {
    msgCreate(32,128,"Chao","You guys... WE FOUND IT!",0,1,oMessagePerson,0)
    newMessage.fadingTime=60
    var tempMplay;
    tempMplay=findMusic(9)
    playMusic(tempMplay,0,1)
    sceneProgress+=1
  }
}
else if sceneProgress=11
{
  sceneDelay+=1
  if sceneDelay=60
  {
    msgCreate(32,128,"Jerry","We finally found it after all this time!",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
  }
  else if sceneDelay=140
  {
    msgCreate(32,128,"Claire","It's... beautiful!",0,1,oMessagePerson,0)
    newMessage.fadingTime=50
  }
  else if sceneDelay=190
  {
    msgCreate(32,128,"Jeremy","It took some exploring, but we did it.",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
  }
  else if sceneDelay=270
  {
    msgCreate(32,128,"Jerry","I feel so much better now. How about you guys?",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
  }
  else if sceneDelay=350
  {
    msgCreate(32,128,"Claire","I'm feeling it too. Chao?",0,1,oMessagePerson,0)
    newMessage.fadingTime=60
  }
  else if sceneDelay=410
  {
    msgCreate(32,128,"Chao","Yeah... everything's going to be okay now. I can feel it.",0,1,oMessagePerson,0)
    newMessage.fadingTime=100
  }
  else if sceneDelay=510
  {
    msgCreate(32,128,"Jeremy","Well, I guess this is it. Now that we've found...",0,1,oMessagePerson,0)
    newMessage.fadingTime=90
  }
  else if sceneDelay=599
  {
    oPlayer1.x=2688; oPlayer1.y=1088
  }
  else if sceneDelay=600
  {
    fadeAlpha=0
    msgCreate(32,128,"Jeremy","The Distorted Travesty.",0,1,oMessagePerson,0)
    newMessage.fadingTime=90
    stopAllMusic()
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=12
{
  sceneDelay+=1
  if sceneDelay=90
  {
    msgCreate(32,128,"Jerry","What does this actually mean for us?",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
  }
  else if sceneDelay=170
  {
    msgCreate(32,128,"Jeremy","It means we beat the game and can now stop playing it.",0,1,oMessagePerson,0)
    newMessage.fadingTime=100
  }
  else if sceneDelay=270
  {
    msgCreate(32,128,"Jerry","Yeah, guess there's nothing else to do now.",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
  }
  else if sceneDelay=350
  {
    msgCreate(32,128,"Claire","You guys wanna go play some other video games?",0,1,oMessagePerson,0)
    newMessage.fadingTime=90
  }
  else if sceneDelay=440
  {
    msgCreate(32,128,"Jerry","Mmm, yeah. Yeah I do.",0,1,oMessagePerson,0)
    newMessage.fadingTime=60
  }
  else if sceneDelay=500
  {
    msgCreate(32,128,"Chao","I'd like to play too!",0,1,oMessagePerson,0)
    newMessage.fadingTime=60
  }
  else if sceneDelay=560
  {
    msgCreate(32,128,"Jerry","Oh yeah? What game would you play, Chao?",0,1,oMessagePerson,0)
    newMessage.fadingTime=90
  }
  else if sceneDelay=650
  {
    msgCreate(32,128,"Jeremy","I'm curious about that too.",0,1,oMessagePerson,0)
    newMessage.fadingTime=80
  }
  else if sceneDelay=730
  {
    msgCreate(32,128,"Chao","Hmm... I'd play...",0,1,oMessagePerson,0)
    newMessage.fadingTime=120
  }
  else if sceneDelay=850
  {
    msgCreate(32,128,"Chao","DISTORTED TRAVESTY 4!!",0,1,oMessagePerson,0)
    newMessage.fadingTime=30
  }
  else if sceneDelay=860
  {
    global.gamePaused=1
    instance_create(0,0,oEvCreditsFast)
  }
}

keyWaitForInput()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
