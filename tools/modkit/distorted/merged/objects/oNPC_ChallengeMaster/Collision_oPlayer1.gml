if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false and trailStarted=0
{
  global.recPeopleTalkNum+=1
  if x<=oPlayer1.x {image_xscale=1}
  else {image_xscale=-1}
  
  if room=rCCity_SGrove and true and global.newMapX=624      //spsp
  {
    with oEnemyBarrier {instance_destroy()}
    with oDHexTunnel {instance_destroy()}
    trialTime=0; trialProg=0; trailStarted=3
    exit
  }

  var tCurseCheck;
  tCurseCheck=0
  for(i=0;i<3;i+=1)
  {
    if global.activeCharacter=0
    {
      if global.equipJerry[i]=10 {tCurseCheck+=1}
      else if global.equipJerry[i]=11 {tCurseCheck+=1}
      else if global.equipJerry[i]=12 {tCurseCheck+=1}
    }
    else
    {
      if global.equipClaire[i]=10 {tCurseCheck+=1}
      else if global.equipClaire[i]=11 {tCurseCheck+=1}
      else if global.equipClaire[i]=12 {tCurseCheck+=1}
    }
  }

  if trialCheck="0"
  {
    if room=rCCity_SGrove //Final cursed arena
    {
      var tChkChall,tQuickChk;
      tChkChall=0
      for(i=0;i<7;i+=1)
      {
        tQuickChk=string_char_at(global.trialMasterQuest,i+1)
        if tQuickChk="1" {tChkChall+=1}
      }

      if tChkChall>=5
      {
        if tCurseCheck=3 //Have Gear Equip
        {
          msgCreate(80,120,"Challenge Master","You are ready.#FOR A VERY LONG FIGHT!!",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
          global.canCharSwap=1
          enemyBarrier=instance_create(432,-16,oEnemyBarrier); enemyBarrier.image_yscale=10
          trailStarted=1
        }
        else //Need Cursed Gear
        {
          msgCreate(80,120,"Challenge Master","Only one who is cursed may attempt my trials.#RETURN WHEN YOU ARE TRULY READY!!",0,2,oMessagePerson,0)
          newMessage.fadingTime=90
        }
      }
      else //Need Other challenges complete
      {
        msgCreate(80,120,"Challenge Master","You are not worthy of this.#RETURN TO ME WHEN YOU HAVE COMPLETED AT LEAST 5 OF MY OTHER CHALLENGES!!",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
    else //Other arenas
    {
      if tCurseCheck=3 //Have Gear Equip
      {
        msgCreate(80,120,"Challenge Master","You who are cursed.#YOU ARE READY FOR MY TRIAL!!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
        global.canCharSwap=1
        oExit.y+=room_height
        trailStarted=1
      }
      else //Need Cursed Gear
      {
        msgCreate(80,120,"Challenge Master","Only one who is cursed may attempt my trials.#RETURN WHEN YOU ARE TRULY READY!!",0,2,oMessagePerson,0)
        newMessage.fadingTime=80
      }
    }
  }
  else //Trial completed
  {
    if room=rCCity_SGrove //spsp ns
    {
      msgCreate(80,120,"Challenge Master","Incroyable...",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else
    {
    msgCreate(80,120,"Challenge Master","You have already completed this trial.#BE GONE FROM MY SIGHT!!",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
  }
}
}
