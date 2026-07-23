#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
tickMod=60
motherTime=0
motherSpawn=0
musicChangeVol=10000

if global.tempAction[2]=1 //If caught by mother
{
  var tFlash; tFlash=instance_create(x,y,oScreenFlash); tFlash.fadeSpeed=0.05
  global.gateHLamps="111111111"
  global.tempAction[0]=0
  global.gamePaused=false
  global.tempAction[2]=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if global.gateHProg=0 //============================== Claire wants out ==============================
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
    if charDialogue[0]=0 and oPlayer1.x>=464
    {
      msgCreate(0,0,"Claire","The door is locked...",0,1,oMessagePerson,0)
      newMessage.fadingTime=60; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=70 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Claire","Hey Jeremy, can you unlock this door for me?",0,1,oMessagePerson,0)
      newMessage.fadingTime=100; charDialogue[0]+=1
    }
    else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=110 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=4
    {
      msgCreate(0,0,"Claire","Jeremy?",0,1,oMessagePerson,0)
      newMessage.fadingTime=50; charDialogue[0]+=1
    }
    else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=6
    {
      msgCreate(0,0,"Claire","You guys? Can any of you hear me?",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
    else if charDialogue[0]=7 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=8
    {
      msgCreate(0,0,"Claire","Jeremy, if you can hear me, get me out of here!",0,1,oMessagePerson,0)
      newMessage.fadingTime=100; charDialogue[0]+=1
    }
    else if charDialogue[0]=9 {convo[0]+=1;if convo[0]>=110 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=10
    {
      msgCreate(0,0,"Claire","You guys seriously, get me out of here, I don't want to be here!",0,2,oMessagePerson,0)
      newMessage.fadingTime=110; charDialogue[0]=0
      global.gateHProg=1
    }
  }
  else if global.gateHProg=1 //============================== Music starts ==============================
  {
    sceneDelay+=1
    if sceneDelay=120
    {
      playSound(global.snd_DoorUnlock,0,0.95,42000)
      (427566).type=1
    }
    if sceneDelay=160
    {
      var tempMplay;
      tempMplay=findMusic(906)
      playMusic(tempMplay,0,0)
      global.gateHProg=2
    }
  }
  else if global.gateHProg=2 //============================== First visit to Claire's room ==============================
  {
    if room=rExtGateH_4
    {
      if oPlayer1.x>=72
      {
        msgCreate(0,0,"Claire","This reminds me of... my room back home.",0,2,oMessagePerson,0)
        newMessage.fadingTime=80
        global.gateHProg=3
      }
    }
  }
  else if global.gateHProg=5 //============================== Mother walks by behind the window ==============================
  {
    if room=rExtGateH_2
    {
      if sceneProgress=0
      {
        if oPlayer1.x<=912
        {
          var myImage;
          myImage=instance_create(792,304,oCMother_Image)
          sceneProgress=1
        }
      }
    }
  }
  else if global.gateHProg=6 //============================== 2nd note read ==============================
  {
    if room=rExtGateH_2
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        playSound(global.snd_DoorUnlock,0,0.95,42000)
        (427572).type=1
      }
    }
  }
  else if global.gateHProg=10 //============================== 4th note read ==============================
  {
    if room=rExtGateH_5
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        playSound(global.snd_DoorKnock,0,1,1)
        (428151).y-=256
        global.gateHProg=11
      }
    }
  }
  else if global.gateHProg=13 //============================== 5th note read (As mother spawns) ==============================
  {
    if room=rExtGateH_2
    {
      if sceneProgress=0
      {
        if global.tempAction[0]=2
        {
          playSound(global.snd_DoorClose,0,1,1)
          sceneProgress+=1
        } 
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=30
        {
          playSound(global.snd_DoorUnlock,0,0.95,42000)
          (427572).type=1
          global.gateHProg=14
        }
      }
    }
  }
  else if global.gateHProg=17 //============================== 7th note read ==============================
  {
    if room=rExtGateH_3
    {
      if sceneProgress=0
      {
        sceneDelay+=1
        if sceneDelay=35
        {
          playSound(global.snd_DoorUnlock,0,0.95,42000)
          (428007).type=1
          global.gateHProg=18
        }
      }
    }
  }
  else if global.gateHProg=31 //============================== 14th note read ==============================
  {
    if room=rExtGateH_7
    {
      if sceneProgress=0
      {
        if oPlayer1.x<=352
        {
          instance_create(656,304,oClaireMother)
          sceneProgress=1
        }
      }
    }
  }
  else if global.gateHProg=32 //============================== Through the window for the last time ==============================
  {
    if room=rExtGateH_6
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=736
        {
          msgCreate(0,0,"Claire","I never wanted to see this place again. Just one more door and I'm done...",0,2,oMessagePerson,0)
          newMessage.fadingTime=130
          sceneProgress+=1
          global.gateHProg=33
        }
      }
    }
  }
  else if global.gateHProg=33 //============================== Running from the mother ==============================
  {
    if room=rExtGateH_8
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=160
        {
          playSound(global.snd_VO_GH_02,0,1,1)
          instance_create(-32,304,oClaireMother)
          sceneProgress=1
        }
      }
      else if sceneProgress=1
      {
        
      }
    }
  }
  
  //****************************** Spawn Claire's mother ******************************
  if global.tempAction[0]=1 //Slight delay
  {
    motherTime+=1
    if motherTime=10
    {
      if global.gateHProg<30 {playSound(global.snd_VO_GH_01,0,1,1)}
      musicChangeVol=global.optMusic*100
      musicLoadCheck=findMusic(906)
    }
    else if motherTime>=11 and motherTime<=99
    {
      musicChangeVol-=100
      SS_SetSoundVol(musicLoadCheck,musicChangeVol)
      if musicChangeVol<=6000
      {
        var tempMplay;
        tempMplay=findMusic(907)
        playMusic(tempMplay,0,0)
        musicChangeVol=0
        musicLoadCheck=findMusic(907)
        SS_SetSoundVol(musicLoadCheck,musicChangeVol)
        motherTime=100
      }
    }
    else if motherTime>=100
    {
      musicChangeVol+=250
      SS_SetSoundVol(musicLoadCheck,musicChangeVol)
      if musicChangeVol>=global.optMusic*100
      {
        motherTime=0
        global.tempAction[0]=2
      }
    }
  }
  else if global.tempAction[0]=2
  {
    if motherSpawn=0
    {
      if room=rExtGateH_1
      {
        instance_create(1472,304,oClaireMother)
      }
      else if room=rExtGateH_2
      {
        if global.newMapX<=128 {instance_create(896,304,oClaireMother)}
        else if global.newMapX>=944 and global.newMapX<=1200 {instance_create(1504,304,oClaireMother)}
        else if global.newMapX>=1520 {instance_create(608,304,oClaireMother)}
      }
      else if room=rExtGateH_3
      {
        if global.gateHProg<=22
        {
          instance_create(1344,304,oClaireMother)
        }
        else
        {
          if global.newMapX<=128 {instance_create(1344,304,oClaireMother)}
          else if global.newMapX>=560 {instance_create(864,304,oClaireMother)}
        }
      }
      motherSpawn=1
    }
  }
  //****************************************************************************************************
}

if room=rExtGateH_6 //Clock ticking
{
  tickMod+=1
  if tickMod mod 70=0
  {
    playSound(global.snd_ClockTick,0,0.95,1)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*draw_set_color(c_gray)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(view_xview[0]+8,view_yview[0]+16,global.gateHProg)
draw_text(view_xview[0]+8,view_yview[0]+26,global.gateHLamps)
