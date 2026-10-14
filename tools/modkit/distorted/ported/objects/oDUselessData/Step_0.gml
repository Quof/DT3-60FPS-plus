if global.gamePaused=false
{
  enemyStepEvent()
  if room=rTD_Lv4 //spsp ns
  {
    //goom+=1
    goom+=1*gDeltaTime //60fps change: per frame
    if goom>=60 {instance_create(x,y+8,oGoomba); goom=0}
}
}
