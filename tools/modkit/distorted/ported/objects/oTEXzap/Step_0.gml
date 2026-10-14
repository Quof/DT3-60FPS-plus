if global.gamePaused=false
{
    //speed=fast
    _speed=fast //60fps change: DT3+'s _speed (correctSpeedDirection moves it, below)
    if y<-160 or y>512 {instance_destroy()}
}
//else {speed=0}
else {_speed=0} //60fps change: DT3+'s _speed
correctSpeedDirection(self) //60fps change (added): moves it by _speed/_direction (set by oThunderbirdEX)
