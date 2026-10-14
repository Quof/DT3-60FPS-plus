if global.gamePaused=false //and myGrapplePoint.bGrappled=0
{
    //if pause>0 {pause-=1}
    if pause>0 {pause-=1*gDeltaTime} //60fps change: per frame (the trail below is kept per frame, so the orb trails the player by a frame)
    else if pause=0 {x=Xtrail[delay-1]; y=Ytrail[delay-1]}
    
    for(i=1;i<delay;i+=1)
    {
        Xtrail[i]=Xtrail[i-1]
        Ytrail[i]=Ytrail[i-1]
    }
    Xtrail[0]=oPlayer1.x; Ytrail[0]=oPlayer1.y-40
}
myGrapplePoint.x=x
myGrapplePoint.y=y
