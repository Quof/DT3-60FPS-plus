event_inherited()
if active=true and global.gamePaused=false
{
    //speed-=spdDecay
    rupSpd=scrTickAcc(rupSpd,-spdDecay,0) //60fps change: each tick's slowdown spread over its frames, landing on the 30fps speed at the tick's end
    _speed=rupSpd+scrTickAccB(0) //60fps change: (scrTickAccB: the move matches the 30fps one, which slowed down first)

    //if speed = -maxSpd
    if rupSpd = -maxSpd //60fps change
    {
        instance_destroy();
    }
}
correctSpeedDirection(self) //60fps change (added): moves by _speed/_direction (the built-in speed moved it every frame)
