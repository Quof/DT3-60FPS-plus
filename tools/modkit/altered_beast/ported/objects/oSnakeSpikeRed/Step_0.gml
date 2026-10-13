if global.gamePaused=false
{
    if active=0
    {
        //fadeInFrames-=1
        //image_alpha += 0.025
        fadeInFrames-=1*gDeltaTime //60fps change: per frame (lands on 0 exactly: 30 is a whole number of steps at 60/120fps)
        image_alpha += 0.025*gDeltaTime //60fps change: per frame
        if fadeInFrames = 0
        {
            active = 1
            image_alpha=1
            image_blend=c_white
        }
    }
}
