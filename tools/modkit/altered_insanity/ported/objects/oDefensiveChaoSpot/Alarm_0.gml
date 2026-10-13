if transformColor = 1
{
    image_blend=c_red
    
    decayTime = 60
    //direction = point_direction(x,y,oIdentifier.chaoTargetX,oIdentifier.chaoTargetY)
    //speed = moveSpd
    _direction = point_direction(x,y,oIdentifier.chaoTargetX,oIdentifier.chaoTargetY) //60fps change: _direction/_speed (correctSpeedDirection in the step)
    _speed = moveSpd //60fps change
    
}
if transformColor = 2
{
    image_blend=c_blue

    decayTime = 20
    image_xscale = 1
    image_yscale = 1
}
if transformColor = 3
{
    image_blend=c_green
    decayTime = 1
}
if transformColor = 4
{
    image_blend=c_yellow
    decayTime = 30
}
