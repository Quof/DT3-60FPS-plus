if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if xSpd<0
      image_xscale=-1
    if type=0 //Summon type
    {
      var tA; //sideways speed-up happens after the move at 30fps: above 30fps it's spread before it (scrTickAcc, scrTickAccBPre)
      tA=0.1*((xSpd>=0 and xSpd<5)-(xSpd<0 and xSpd>-5))
      if gDeltaTime!=1 {xSpd=scrTickAcc(xSpd,tA,0)}
      x+=(xSpd+scrTickAccBPre(0))*gDeltaTime
      if ySpd<6 {ySpd=scrGravAcc(ySpd,0.4,-1)} //moves then accelerates: second half after the move, original line kept for 30fps (see scrGravAcc)
      y-=ySpd*gDeltaTime
      if gDeltaTime==1 {xSpd+=tA}
      if gDeltaTime==1 {if ySpd<6 {ySpd+=0.4}}

      if y<=-16
        instance_destroy()
    }
    else if type=1 //Attack type
    {
      x+=xSpd*gDeltaTime
      if findTargetX>inactiveDist
        instance_destroy()
    }
  }
  else if life<=0
  {
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
    oCackletta.myBats-=1
    if oCackletta.myBats=0
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,5)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Fourth Trimester"; tAchievement.checkNum=5
      }
    }
    instance_destroy()
  }
  enemyStepEvent()
}
