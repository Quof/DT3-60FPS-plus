secondsLeft-=1

if (secondsLeft <= 0)
{
    oPlayer1.life-=oPlayer1.maxLife
}
else
{
    //alarm[0]=30
    alarm[0]=30/gDeltaTime //60fps change: alarms count frames (a second)
}
