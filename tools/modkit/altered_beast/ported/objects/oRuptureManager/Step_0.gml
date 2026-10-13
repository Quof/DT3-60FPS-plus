if global.gamePaused=false
{
    //rockTime+=1
    rockTime+=1*gDeltaTime //60fps change
    if rockTime = timeBetweenRocks
    {
        playSound(global.snd_DT_BoulderHit,0,0.92,10000)
        rock = instance_create(x+rockSpacing*curRock,y,oRupture)
        rock.maxSpd = curRock*2+4.5
        rock.image_xscale = 1 - ((curRock-1) * 0.15)
        rock = instance_create(x-rockSpacing*curRock,y,oRupture)
        rock.image_xscale = 1 - ((curRock-1) * 0.15)
        rock.maxSpd = curRock*2+4.5
        curRock+=1
        rockTime=0
        if curRock > maxRocks
        {
            instance_destroy();
        }
    }
}
