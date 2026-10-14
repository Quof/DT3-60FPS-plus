if global.gamePaused=false
{
  if life>0
  {
    //spsp ns movement
    myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
    myDist=round(myDist/32)
    if myDist>dDist //5
      myDist=dDist //5
    else if myDist<mDist //3
      myDist=mDist //3
    maxSpeed=myDist
     
    //(60fps change: the speeds change per tick, decided like at 30fps: scrTickAcc; tA is this tick's change)
    var tA;
    tA=0
    if x>oPlayer1.x
    {
      //if currHspd>-maxSpeed {currHspd-=currAcc}
      if currHspd>-maxSpeed {tA=-currAcc} //60fps change
      else {currHspd=-maxSpeed}
    }
    else if x<oPlayer1.x
    {
      //if currHspd<maxSpeed {currHspd+=currAcc}
      if currHspd<maxSpeed {tA=currAcc} //60fps change
      else {currHspd=maxSpeed}
    }
    currHspd=scrTickAcc(currHspd,tA,0) //60fps change (added)
    tA=0
    if y>oPlayer1.y-26
    {
      //if currVspd>-maxSpeed {currVspd-=currAcc}
      if currVspd>-maxSpeed {tA=-currAcc} //60fps change
      else {currVspd=-maxSpeed}
    }
    else if y<oPlayer1.y-26
    {
      //if currVspd<maxSpeed {currVspd+=currAcc}
      if currVspd<maxSpeed {tA=currAcc} //60fps change
      else {currVspd=maxSpeed}
    }
    currVspd=scrTickAcc(currVspd,tA,1) //60fps change (added)
    //x+=currHspd
    //y+=currVspd
    x+=(currHspd+scrTickAccB(0))*gDeltaTime //60fps change
    y+=(currVspd+scrTickAccB(1))*gDeltaTime //60fps change
    //if x>room_width+64 or x<-64 {currHspd=-currHspd}
    //if y>room_height+64 or y<-64 {currVspd=-currVspd}
    //60fps change: turned back towards the room, rather than flipped: with smaller steps a frame, a flip could come
    //again before it was back in, every frame
    if x>room_width+64 {currHspd=-abs(currHspd)} else if x<-64 {currHspd=abs(currHspd)}
    if y>room_height+64 {currVspd=-abs(currVspd)} else if y<-64 {currVspd=abs(currVspd)}
    
    //if oEvAbom.instrumentActNum=8 {bCanTakeDamage=1}
    if oDAbomMain.instrumentActNum=8 {bCanTakeDamage=1}
    else {bCanTakeDamage=0}

    seqTime+=1*gDeltaTime
    if seqTime=220
    {
      var tAttack,tDir;
      tDir=0
      for(i=0;i<16;i+=1)
      {
        tAttack=instance_create(x,y,oAbomParaShot)
        tAttack._direction=tDir
        tDir+=360/16
      }
      seqTime=0
    }
  }
  enemyStepEvent()

  if life<=0
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      with oEnemyBase {bCanDealDamage=0}
      bCanTakeDamage=0
      /*
      oAbominationMain.sequence=16
      oAbominationMain.seqTime=0
      oEvAbom.instrumentProg=3
      */
      oDAbomMain.sequence=16
      oDAbomMain.seqTime=0
      //oEvAbom.instrumentProg=3
      //spsp ns will need an Ersatz for this and the =4 line in oDAbomMain
    }
  }
}
