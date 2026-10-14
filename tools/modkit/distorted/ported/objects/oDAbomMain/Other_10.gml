///Form weak spot
var myWeakSpot;
myWeakSpot=instance_create(formWeakSpotX,formWeakSpotY,oDAbomHitSpotA)
//myWeakSpot.direction=formWeakSpotDir
myWeakSpot._direction=formWeakSpotDir //60fps change: DT3+'s weak spots use _direction
myWeakSpot.heartOffsetX=formWeakSpotHeartOffsetX
myWeakSpot.HPSet=myHitSpotHP[myHitCounter]
myHitCounter+=1
