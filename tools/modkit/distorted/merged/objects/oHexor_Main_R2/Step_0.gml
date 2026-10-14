if global.gamePaused=false
{
  if bActive=true and life>0
  {
    //==================== SEQUENCE ====================
    atkTime+=1*gDeltaTime
    if atkPhase=0
    {
      if atkProg=0 //Intro dialogue
      {
        if atkTime=35
        {
          msgCreate(60,80,"Hexor","I'm still invulnerable to your attacks.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if atkTime=105
        {
          msgCreate(60,80,"Jeremy","We'll see.",0,1,oMessagePerson,0)
          newMessage.fadingTime=50
        }
        else if atkTime=115 {life=maxLife}
        else if atkTime=175
        {
          msgCreate(60,80,"Jeremy","Hey, what are you doing?",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=235
        {
          msgCreate(60,80,"Hexor","Simply being unbeatable.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime>=295
        {
          atkTime=0; atkProg=1
        }
      }
      else if atkProg=1 //Use Ganon Orb (First orb)
      {
        if atkTime=30
        {
          atkChoice=1; event_user(0)
          atkTime=0; atkProg=2
        }

        if bossProgress=1
        {
          atkTime=0; atkProg=3
        }
      }
      else if atkProg=2 //Wait for Ganon Orb to no longer exist (First orb)
      {
        if !instance_exists(oHexor_GanonOrb)
        {
          atkTime=0; atkProg=1
        }
      }
      else if atkProg=3 //Short dialogue
      {
        if atkTime=5
        {
          msgCreate(60,80,"Jeremy","Played that one too.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=65
        {
          msgCreate(60,80,"Hexor","How about this next one.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=110
        {
          extraAtkTime=100
          atkTime=0; atkProg=4
        }
      }
      else if atkProg=4 //Use Ganon Orb (All other uses)
      {
        if atkTime=30
        {
          atkChoice=1; event_user(0)
          atkTime=0; atkProg=5
        }

        if bossProgress=5
        {
          extraAtkTime=0
          atkTime=0; atkProg=6
        }
      }
      else if atkProg=5 //Wait for Ganon Orb to no longer exist (All other uses)
      {
        if !instance_exists(oHexor_GanonOrb)
        {
          atkTime=0; atkProg=4
        }
      }
      else if atkProg=6 //Second dialogue
      {
        if atkTime=50
        {
          msgCreate(60,80,"Hexor","One last time.",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=80 {extraAtkTime=100}
        else if atkTime>=100
        {
          atkTime=0; atkProg=7
        }
      }
      else if atkProg=7 //Use Ganon Orb (Final)
      {
        if atkTime=30
        {
          atkChoice=1; event_user(0)
          atkTime=0; atkProg=8
        }

        if bossProgress=6
        {
          extraAtkTime=0

          global.gamePaused=true
          oEvCh21MainA.sceneProgress=1
          atkTime=0; atkProg=9
        }
      }
      else if atkProg=8 //Wait for Ganon Orb to no longer exist (Final)
      {
        if !instance_exists(oHexor_GanonOrb)
        {
          atkTime=0; atkProg=7
        }
      }

      if extraAtkTime>=100 //2nd orb
      {
        //extraAtkTime+=1
        extraAtkTime+=1*gDeltaTime //60fps change: the extra machine spikes came 2x/4x as often at 60/120fps
        if bossProgress=1
        {
          if extraAtkTime=101
          {
            spawnX=400; spawnY=272; myDir=180
            atkChoice=2; event_user(0)
          }
          else if extraAtkTime>=240 {extraAtkTime=100}
        }
        else if bossProgress>=2 and bossProgress<=3 //3rd and 4th orb
        {
          if extraAtkTime=101
          {
            spawnX=400; spawnY=272; myDir=180
            atkChoice=2; event_user(0)
          }
          else if extraAtkTime=130
          {
            spawnX=80; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=200
          {
            spawnX=384; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime>=240 {extraAtkTime=100}
        }
        else if bossProgress=4 //5th orb
        {
          if extraAtkTime=101
          {
            spawnX=80; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=160
          {
            spawnX=384; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime>=230 {extraAtkTime=100}
        }
        else //Final Orb
        {
          if extraAtkTime=101
          {
            spawnX=96; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=140
          {
            spawnX=160; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=180
          {
            spawnX=240; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=220
          {
            spawnX=304; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime=260
          {
            spawnX=384; spawnY=80
            atkChoice=3; event_user(0)
          }
          else if extraAtkTime>=290 {extraAtkTime=100}
        }
      }
    }
  }

  if timesHitWithOrb=1 and bossProgress=0
  {
    orbHitMax=6
    orbSpdInc=1.5+0.1 //spsp
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=2 and bossProgress=1
  {
    orbHitMax=10+1 //spsp
    orbSpdInc=0.75+0.2 //spsp
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=3 and bossProgress=2
  {
    orbHitMax=8+2 //spsp
    orbSpdInc=1.5+0.2 //spsp
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=4 and bossProgress=3
  {
    orbHitMax=9+3 //spsp
    orbSpdInc=1.6+0.3 //spsp
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=5 and bossProgress=4 //To final
  {
    if true {orbHitMax=15}       //spsp
    extraAtkTime=100
    bossProgress+=1
  }
  else if timesHitWithOrb=6 and bossProgress=5
  {
    bossProgress+=1
  }

  enemyStepEvent()
}
else
{
  hspeed=0; vspeed=0
  speed=0
}
