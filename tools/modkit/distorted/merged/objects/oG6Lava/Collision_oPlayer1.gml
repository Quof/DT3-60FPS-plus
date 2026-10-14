if global.location!=58
{
redDmgHit(0)
}
else
{
    //if global.gamePaused=false {global.desertHeat-=15} //spsp ns; 5 seconds to death at -10 per frame
    if global.gamePaused=false {global.desertHeat-=15*gDeltaTime} //spsp ns; 5 seconds to death at -10 per frame. 60fps change: per frame
}
