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
if global.gameProgress=2530 and room=rVault_23 //----- [1] Start autorun -----
{
  if global.bossTrack=0
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=384
      {
        global.gamePaused=true
        oPlayer1.y+=4
        if oPlayer1.y>=208
        {
          scenePChk(384,208,0,0.1,1)
          stopPlayer()
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Huh... this exit should be painless and easy, hold on.",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Holding.",0,3,oMessageCutscene,1)
    else if sceneProgress=3
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        oEvCh10MainA.sceneProgress=1
        sceneDelay=0; sceneProgress+=1
      }
    }
  }
}

keyWaitForInput()
