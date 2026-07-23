#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if room=rLink2_PalaceF_9
{
  charDialogue[0]=0; convo[0]=0
  gameProgCheck=string_char_at(global.gameGate2Prog,2)
  sceneProgress=10
  if gameProgCheck="2"
  {
    sceneProgress=0
  }
}
else if room=rLink2_PalaceF_10
{
  charDialogue[0]=0; convo[0]=0
  gameProgCheck=string_char_at(global.gameGate2Prog,2)
  if gameProgCheck="0" //First visit
  {
    var tNewString;
    tNewString=string_delete(global.gameGate2Prog,2,1)
    tNewString=string_insert("1",tNewString,2)
    global.gameGate2Prog=tNewString
    gameProgCheck="1"
  }

  sceneProgress=10
  if gameProgCheck="1"
  {
    sceneProgress=0
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rLink2_PalaceA_7 //Flank player
  {
    if sceneProgress=0
    {
      for (i=0;i<=0;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=760 and oPlayer1.x<=776
    {
      createEnemy(608,272,oWolfos,0,1,1)
      createEnemy(928,272,oWolfos,0,1,1)
      charDialogue[0]+=1
    }
  }
  else if room=rLink2_PalaceA_8 //Cheating fireballs
  {
    if sceneProgress=0
    {
      for (i=0;i<=0;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=1328 and oPlayer1.x<=1632 and oPlayer1.y>=256
    {
      msgCreate(80,120,"Jerry","Holy cheating fireballs Jeremy!!",0,1,oMessagePerson,0)
      newMessage.fadingTime=120; charDialogue[0]+=1
    }
  }
  else if room=rLink2_PalaceF_9 //Poe and the door
  {
    if sceneProgress=0
    {
      if oPlayer1.x<=528
      {
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,2,1)
        tNewString=string_insert("3",tNewString,2)
        global.gameGate2Prog=tNewString
        gameProgCheck="3"
        msgCreate(0,0,"Dylan, the Poe","You did well to get here. I will do as I said and remove the door for you. You're lucky, I was going to use the weapon here on you, but someone took it. Oh well, carry on adventurer.",6,3,oMessagePerson,0)
        newMessage.fadingTime=220; charDialogue[0]+=1
        sceneProgress+=1
      }
    }
    if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=350 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Dylan, the Poe","Why are you still here?",6,3,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=120 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Dylan, the Poe","Please go away and stop staring at me.",6,3,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[0]+=1
    }
    else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=120 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=6
    {
      msgCreate(0,0,"Dylan, the Poe","...Wow, humans are annoying. No really, just go away. You already won and got what you wanted!",6,3,oMessagePerson,0)
      newMessage.fadingTime=130; charDialogue[0]+=1
    }
    else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=180 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=8
    {
      msgCreate(0,0,"Dylan, the Poe","Whatever, I'll go away then.",6,3,oMessagePerson,0)
      newMessage.fadingTime=80; charDialogue[0]+=1
    }
    else if charDialogue[0]=9
    {
      convo[0]+=1
      if convo[0]>=70
      {
        oMisc.image_alpha-=0.05
        if oMisc.image_alpha<=0
        {
          msgCreate(0,0,"Dylan, the Poe","HAHAHAHAHAHA!!!! TAKE THAT!!!!",6,3,oMessagePerson,0)
          newMessage.fadingTime=70
          var tNewAttack;
          for(i=0;i<96;i+=1)
          {
            var tNewAttack;
            tNewAttack=instance_create(oMisc.x,oMisc.y+12,oGravityBullet)
            tNewAttack.atkPower=5; tNewAttack.sprite_index=sBDBomb; tNewAttack.damageType="EXPLOSION"
            tNewAttack.xVel=random_range(-6,6); tNewAttack.yVel=-2-random(5)
          }
          charDialogue[0]+=1
        }
      }
    }
  }
  else if room=rLink2_PalaceF_10 //Poe and the fire
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=160
      {
        var tNewString;
        tNewString=string_delete(global.gameGate2Prog,2,1)
        tNewString=string_insert("2",tNewString,2)
        global.gameGate2Prog=tNewString
        gameProgCheck="2"
        msgCreate(0,0,"Dylan, the Poe","I will remove this door from your path, but only if you play a game with me.",6,1,oMessagePerson,0)
        newMessage.fadingTime=130; charDialogue[0]+=1
        sceneProgress+=1
      }
    }
    if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=130 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Dylan, the Poe","Get to the top of the Palace, where a powerful weapon lies, without shifting any rooms. If you shift any room, return here, so that I may taunt you and we can start again.",6,3,oMessagePerson,0)
      newMessage.fadingTime=250; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=250 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Dylan, the Poe","And just in case you're confused. You can not shift any rooms from this point on. If you have to, you fail and will have to return to me to try again. And just in case you're somehow still confused, any rooms you've flipped already don't count.",6,3,oMessagePerson,0)
      newMessage.fadingTime=240; charDialogue[0]+=1
    }
    else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=240 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=6
    {
      msgCreate(0,0,"Jeremy","Heads up, Jerry. If you do have to return here, all you need to do to trigger this sequence is start his dialogue. No need to wait for it to end... His behavior is set, so that was an easy look up. Also he was talking about the bombs.",0,3,oMessagePerson,0)
      newMessage.fadingTime=230; charDialogue[0]+=1
    }
  }
  else if room=rLink2_Checkpoint
  {
    if oPlayer1.x<room_width/2
      global.zEncZone=1
    else
      global.zEncZone=2
  }
  else if room=rLink2_MountPass //Flank player
  {
    if oPlayer1.x<room_width/2
      global.zEncZone=3
    else
      global.zEncZone=4

    if sceneProgress=0
    {
      for (i=0;i<=0;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=1952 and oPlayer1.x<=1984
    {
      createEnemy(1776,272,oGreenOrc,0,1,1)
      createEnemy(2160,272,oGreenOrc,0,1,1)
      charDialogue[0]+=1
    }
  }
}
