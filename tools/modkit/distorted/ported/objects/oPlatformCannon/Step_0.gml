if global.gamePaused=false
{
    //shotTime+=1
    shotTime+=1*gDeltaTime //60fps change: per frame
    if shotTime>=shotDelay
    {
        var newPlat;
        newPlat=instance_create(x,y,oMovingPlatform)
        newPlat.xDir=platXSpeed
        newPlat.yDir=platYSpeed
        newPlat.shiftChange=platDecay
        newPlat.sprite_index=platSprite
        newPlat.depth=platDepth
        newPlat.decay=platDecay
        shotTime=0
    }
}
