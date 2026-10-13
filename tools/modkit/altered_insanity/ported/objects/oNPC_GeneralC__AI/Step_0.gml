if global.gamePaused=true and bTalking=1
{
  if bWaitForInput=false
    msgCreate(0,0,myChar[sceneProgress],myString[sceneProgress],0,3,oMessageCutscene,1)

  keyWaitForInput()

  if sceneProgress>=maxString
  {
    if progTag>0 //Check for game state progress
    {
      global.gameProgress+=progTag
      progTag=0
      with oNPC_GeneralC //Set new npc state if needed
      {
        event_user(0)
      }
    }
    sceneProgress=0
    bTalking=0
    global.gamePaused=false
  }
}
