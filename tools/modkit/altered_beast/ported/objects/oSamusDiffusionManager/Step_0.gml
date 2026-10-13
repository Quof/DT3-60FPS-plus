if global.gamePaused=false
{
    //lifetime-=1
    lifetime-=1*gDeltaTime //60fps change
    if lifetime=0
    {
        instance_destroy()
    }
}
