//Requires: mySpd
event_inherited()

startLatchTime=0
latchTimer=0
if !variable_local_exists("latchMax") //spsp ns
latchMax=105
if room=rLowFacK or room=rLowFacL
{
    //direction=270
    _direction=270 //60fps change: DT3+'s oStrikePoint_Ext moves by its own _direction
    mySpd=0
    latchMax=30
}
touchFrames=0
currSpd=0
