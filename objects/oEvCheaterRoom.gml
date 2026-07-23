#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=1

global.optShowHUD=0

extCheatFlag=string_char_at(global.extraFlags,10)
if extCheatFlag="1" //If player force quit the game in the cheat room after Esc is disabled
{
  fadeColor=make_color_rgb(255,160,160)
  sceneProgress=100
}

preAchCheck=string_char_at(global.tokenRecognitionsSetTwo,1)
if preAchCheck="1" //If player has achievement for cheating
{
  fadeColor=make_color_rgb(200,200,255)
  sceneProgress=200
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sceneDelay+=1
if sceneProgress=0 //---------------------------------------- Intro (screen white) ----------------------------------------
{
  if sceneDelay=60
  {
    msgCreate(0,0,"The Voice","Now you've done it...",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=140
  {
    msgCreate(0,0,"The Voice","Why would do you this?",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=220
  {
    msgCreate(0,0,"The Voice","Was the game too hard?",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=300
  {
    msgCreate(0,0,"The Voice","Were you that desperate to get through that thing you couldn't get through?",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay=420
  {
    msgCreate(0,0,"The Voice","Or were you simply curious?",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=500
  {
    if global.gameCompleted=0
    {
      msgCreate(0,0,"The Voice","You've clearly not beaten the game yet. You're just a bad person.",0,3,oMessagePerson,0)
      newMessage.fadingTime=110; newMessage.depth=-150
    }
    else
    {
      msgCreate(0,0,"The Voice","You've already beaten the game, so why attempt to cheat?",0,3,oMessagePerson,0)
      newMessage.fadingTime=110; newMessage.depth=-150
    }
  }
  else if sceneDelay=620
  {
    msgCreate(0,0,"The Voice","Not that this matters, the point is you attempted to cheat.",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay>=740
  {
    global.gamePaused=0
    fadeAlpha-=0.02
    if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
  }
}
else if sceneProgress=1 //Taunt the player
{
  if sceneDelay=120
  {
    msgCreate(0,0,"The Voice","You may be wondering what'll happen to you here.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=230
  {
    msgCreate(0,0,"The Voice","You may also be wondering who I am.",0,3,oMessagePerson,0)
    newMessage.fadingTime=80; newMessage.depth=-150
  }
  else if sceneDelay=320
  {
    msgCreate(0,0,"The Voice","The second pondering of yours is not important, however the first...",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay=440
  {
    msgCreate(0,0,"The Voice","Yes, that's truly what you should be concerning yourself with.",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay=560
  {
    msgCreate(0,0,"The Voice","There are things I could do to you. Very bad things for your doing bad things.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=690
  {
    msgCreate(0,0,"The Voice","I could delete your save file...",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=770
  {
    msgCreate(0,0,"The Voice","I may have already done that.",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=850
  {
    msgCreate(0,0,"The Voice","Or I may not. I could have even made it impossible to beat the game now.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=980
  {
    msgCreate(0,0,"The Voice","Do you think this is a proper punishment for your crimes against the game?",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1120
  {
    msgCreate(0,0,"The Voice","You would simply delete it yourself or never play again.",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay=1240 //Write to save file to use if player force quits the save room
  {
    global.bCanUseEsc=0

    var tNewString;
    tNewString=string_delete(global.extraFlags,10,1)
    tNewString=string_insert("1",tNewString,10)
    global.extraFlags=tNewString

    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_string(sectionWrite,"129c",global.extraFlags)
    ini_close()

    msgCreate(0,0,"The Voice","What if I do something even more sinister...",0,3,oMessagePerson,0)
    newMessage.fadingTime=90; newMessage.depth=-150
  }
  else if sceneDelay=1340
  {
    msgCreate(0,0,"The Voice","That's right. You can't open the menu or use Esc to close the game now.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1470
  {
    msgCreate(0,0,"The Voice","You're stuck here forever now. For me to torment.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=1580 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=2 //Wait till player has moved
{
  if oPlayer1.x!=256 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=3 //Taunt player some more
{
  if sceneDelay=90
  {
    msgCreate(0,0,"The Voice","You'll never escape from this. I see you trying to find a way.",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay=210
  {
    msgCreate(0,0,"The Voice","I'm going to keep you here forever. We'll become the best of friends, you and I.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=340
  {
    msgCreate(0,0,"The Voice","Do I like cheaters like yourself? No, it's nothing like that.",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay=460
  {
    msgCreate(0,0,"The Voice","It's simply inevitable. We're going to spend the rest of eternity here together.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=590
  {
    msgCreate(0,0,"The Voice","You may hate me at first, but you'll come around.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=700
  {
    msgCreate(0,0,"The Voice","Why spend eternity alone without any friends?",0,3,oMessagePerson,0)
    newMessage.fadingTime=90; newMessage.depth=-150
  }
  else if sceneDelay=800
  {
    msgCreate(0,0,"The Voice","Does it make you sad that you can never leave?",0,3,oMessagePerson,0)
    newMessage.fadingTime=90; newMessage.depth=-150
  }
  else if sceneDelay=900
  {
    msgCreate(0,0,"The Voice","I suppose this is pretty harsh for just save editing.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=1010
  {
    msgCreate(0,0,"The Voice","I've had a change of heart. I'll remove the side barriers for you.",0,3,oMessagePerson,0)
    newMessage.fadingTime=110; newMessage.depth=-150
  }
  else if sceneDelay=1130
  {
    msgCreate(0,0,"The Voice","Drop down and you can return to the game. I know that's what you truly want.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1260
  {
    msgCreate(0,0,"The Voice","You don't want to spend the rest of your life here with me.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=1370
  {
    msgCreate(0,0,"The Voice","You just want to keep playing this game.",0,3,oMessagePerson,0)
    newMessage.fadingTime=80; newMessage.depth=-150
  }
  else if sceneDelay=1460
  {
    msgCreate(0,0,"The Voice","Go. Enjoy the game. I'll forget you tried to cheat. You were just curious is all.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1590
  {
    with oColl_CheaterBlock {instance_destroy()}
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=4 //Check if player goes down side pits
{
  if oPlayer1.y<=16 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=5 //Taunt player some more
{
  if sceneDelay=60
  {
    msgCreate(0,0,"The Voice","Hahahahahahahaha!! Did... did you really think I was going to let you go?",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=190
  {
    msgCreate(0,0,"The Voice","That's too great. Come on, seriously. Even you have to think that was a pretty funny trick.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=320
  {
    msgCreate(0,0,"The Voice","It's great that you actually thought I would let you go.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=520
  {
    msgCreate(0,0,"The Voice","Now for your punishment...",0,3,oMessagePerson,0)
    newMessage.fadingTime=80; newMessage.depth=-150
  }
  else if sceneDelay=610
  {
    msgCreate(0,0,"The Voice","I'm going to trap you here...",0,3,oMessagePerson,0)
    newMessage.fadingTime=80; newMessage.depth=-150
  }
  else if sceneDelay=760
  {
    msgCreate(0,0,"The Voice","For 5 minutes.",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=840
  {
    msgCreate(0,0,"The Voice","That's right, 5 whole minutes you must sit here.",0,3,oMessagePerson,0)
    newMessage.fadingTime=90; newMessage.depth=-150
  }
  else if sceneDelay=940
  {
    msgCreate(0,0,"The Voice","I want you to sit here and contemplate on why cheating is bad.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=1050
  {
    msgCreate(0,0,"The Voice","Oh yeah, and don't even think about attempting to force the game to close. Because...",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1180
  {
    msgCreate(0,0,"The Voice","Well, because I'll know.",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=1260
  {
    msgCreate(0,0,"The Voice","Now... your 5 minutes of thinking time starts as soon as this message box fades away.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1390 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=6 //Wait 5 minutes
{
  if sceneDelay=9000 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=7 //5 minutes over
{
  if sceneDelay=1
  {
    msgCreate(0,0,"The Voice","So, did you learn anything?",0,3,oMessagePerson,0)
    newMessage.fadingTime=90; newMessage.depth=-150
  }
  else if sceneDelay=100
  {
    msgCreate(0,0,"The Voice","No? Well how about 10 minutes this time?",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=220
  {
    msgCreate(0,0,"The Voice","I'm just messing with you. I suppose I shouldn't really keep you here anymore.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=350
  {
    msgCreate(0,0,"The Voice","How about this. You didn't try to circumvent the 5 minute wait. Maybe you did learn something.",0,3,oMessagePerson,0)
    newMessage.fadingTime=130; newMessage.depth=-150
  }
  else if sceneDelay=490
  {
    msgCreate(0,0,"The Voice","I'm proud of you for overcoming this part of yourself. Do you feel as if you've grown?",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=620
  {
    msgCreate(0,0,"The Voice","I feel that you have, and I'd like to give you something.",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=730
  {
    msgCreate(0,0,"The Voice","What is it? I'm glad you ask.",0,3,oMessagePerson,0)
    newMessage.fadingTime=80; newMessage.depth=-150
  }
  else if sceneDelay=820
  {
    msgCreate(0,0,"The Voice","It's a Recognition to commemorate this moment, so everyone will know that you've become a better person.",0,3,oMessagePerson,0)
    newMessage.fadingTime=140; newMessage.depth=-150
  }
  else if sceneDelay=970 //Achievement
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,1)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNoticeSS)
      tAchievement.myAchievement="Overcoming Yourself"; tAchievement.checkNum=1
    }
  }
  else if sceneDelay=971 //Write achievement to save file
  {
    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_string(sectionWrite,"143ss",global.tokenRecognitionsSetTwo)
    ini_close()
  }
  else if sceneDelay=1080
  {
    msgCreate(0,0,"The Voice","I guess I can let you go now.",0,3,oMessagePerson,0)
    newMessage.fadingTime=80; newMessage.depth=-150
  }
  else if sceneDelay=1190 //Set save file to allow player back into the game
  {
    var tNewString;
    tNewString=string_delete(global.extraFlags,10,1)
    tNewString=string_insert("0",tNewString,10)
    global.extraFlags=tNewString

    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_real(sectionWrite,"gamebeat",0)
    ini_write_string(sectionWrite,"129c",global.extraFlags)
    ini_close()
  }
  else if sceneDelay=1195 //Back to title screen
  {
    global.bCanUseEsc=1
    room_goto(rTitle)
  }
}
else if sceneProgress=100 //---------------------------------------- Player force quit (screen red) ----------------------------------------
{
  if sceneDelay=60
  {
    msgCreate(0,0,"The Voice","I warned you about this. About attempting to force the game to close to circumvent my punishment for your cheating ways.",0,3,oMessagePerson,0)
    newMessage.fadingTime=160; newMessage.depth=-150
  }
  else if sceneDelay=250
  {
    msgCreate(0,0,"The Voice","I told you I could see this. I... don't even know how to further punish you for this atrocity.",0,3,oMessagePerson,0)
    newMessage.fadingTime=130; newMessage.depth=-150
  }
  else if sceneDelay=390
  {
    msgCreate(0,0,"The Voice","Maybe I should simply never let you play the game again. Delete all the files so you can never play again.",0,3,oMessagePerson,0)
    newMessage.fadingTime=140; newMessage.depth=-150
  }
  else if sceneDelay=540
  {
    msgCreate(0,0,"The Voice","Oh what's that? You'd just download them again?",0,3,oMessagePerson,0)
    newMessage.fadingTime=100; newMessage.depth=-150
  }
  else if sceneDelay=650
  {
    msgCreate(0,0,"The Voice","I could always hide something somewhere that would simply cause your DT files to delete themselves again.",0,3,oMessagePerson,0)
    newMessage.fadingTime=140; newMessage.depth=-150
  }
  else if sceneDelay=800
  {
    msgCreate(0,0,"The Voice","However, I will do none of that. I have a feeling that any further punishment will simply be met with methods of subversion.",0,3,oMessagePerson,0)
    newMessage.fadingTime=160; newMessage.depth=-150
  }
  else if sceneDelay=970
  {
    msgCreate(0,0,"The Voice","Forget it. I'll just send you back to the title screen and let you keep on playing.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1100
  {
    msgCreate(0,0,"The Voice","Just know that I think you're a terrible person for attempting to cheat like that.",0,3,oMessagePerson,0)
    newMessage.fadingTime=120; newMessage.depth=-150
  }
  else if sceneDelay=1230
  {
    msgCreate(0,0,"The Voice","Also have fun.",0,3,oMessagePerson,0)
    newMessage.fadingTime=70; newMessage.depth=-150
  }
  else if sceneDelay=1330 //Set save file to allow player back into the game
  {
    var tNewString;
    tNewString=string_delete(global.extraFlags,10,1)
    tNewString=string_insert("0",tNewString,10)
    global.extraFlags=tNewString

    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_real(sectionWrite,"gamebeat",0)
    ini_write_string(sectionWrite,"129c",global.extraFlags)
    ini_close()
  }
  else if sceneDelay=1335 //Back to title screen
  {
    room_goto(rTitle)
  }
}
else if sceneProgress=200 //---------------------------------------- Player already has achievement (screen green) ----------------------------------------
{
  if sceneDelay=1
  {
    msgCreate(0,0,"The Voice","What are you doing back here? You already got your achievement. Stop trying to cheat when you know it doesn't work.",0,3,oMessagePerson,0)
    newMessage.fadingTime=160; newMessage.depth=-150
  }
  else if sceneDelay=170
  {
    msgCreate(0,0,"The Voice","I'm just going to send you back to the title screen. You really should just play the game like you're supposed to.",0,3,oMessagePerson,0)
    newMessage.fadingTime=160; newMessage.depth=-150
  }
  else if sceneDelay=340 //Remove 100 Internetz and allow player back into the game
  {
    global.pMoney-=100
    if global.pMoney<0 {global.pMoney=0}

    ini_open(global.paraString[0])
    sectionWrite="ALPHA"
    ini_write_real(sectionWrite,"gamebeat",0)
    ini_write_real(sectionWrite,"110",global.pMoney)
    ini_write_string(sectionWrite,"129c",global.extraFlags)
    ini_close()

    msgCreate(0,0,"The Voice","Oh yeah, I also took 100 Internetz from you for trying this again... It's already saved too. HA!",0,3,oMessagePerson,0)
    newMessage.fadingTime=150; newMessage.depth=-150
  }
  else if sceneDelay=530 //Back to title screen
  {
    room_goto(rTitle)
  }
}

if oPlayer1.y>=room_height+32 {oPlayer1.y=-16}
oPlayer1.idleTime=0
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
