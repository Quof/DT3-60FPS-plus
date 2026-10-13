event_inherited()
if global.gamePaused=false
{
    //lifeTime-=1
    lifeTime-=1*gDeltaTime //60fps change
    if lifeTime=0
    {
        instance_destroy()
    }
}
