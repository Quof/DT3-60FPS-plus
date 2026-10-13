if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if oPlayer1.state=oPlayer1.STANDING or oPlayer1.state=oPlayer1.RUNNING or oPlayer1.state=oPlayer1.DUCKING or oPlayer1.state=oPlayer1.LOOKING_UP
  {
    global.recPeopleTalkNum+=1
    with oMessageNPCchat {instance_destroy()}
    sceneProgress=0
    scenePChk(oPlayer1.x,oPlayer1.y,0,0.1,1)
    if oPlayer1.x<=x {oPlayer1.x=x-32; oPlayer1.image_xscale=1}
    else {oPlayer1.x=x+32; oPlayer1.image_xscale=-1}

    if sprite_index=sWarmasterA_Idle
    {
      if x<=oPlayer1.x {image_xscale=1.25}
      else {image_xscale=-1.25}
    }
    else
    {
      if x<=oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }
    bTalking=1
    global.gamePaused=true
  }
}
