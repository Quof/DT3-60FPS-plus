if global.gamePaused=0
{
    //decayTime -= 1
    decayTime -= 1*gDeltaTime //60fps change: per frame
    if decayTime<=0
    {
        //image_alpha-=0.1
        image_alpha-=0.1*gDeltaTime //60fps change: per frame
        if image_alpha<=0 {instance_destroy()}
    }

    //if (transformColor = 1)//red spawns explosions
    if (transformColor = 1) and gDeltaDoTicks //red spawns explosions //60fps change: once per 30fps tick (every frame made 2x/4x as many at 60/120fps)
    {
        tAtk = instance_create(x,y,oChaoExplosion)
        tAtk.atkPower = 50
        tAtk.image_xscale = 1
        tAtk.image_yscale = 1
    }
}
correctSpeedDirection(self) //60fps change (added): moves by _speed/_direction (it moved by the built-in speed, which GameMaker adds every frame)
