///Basic shot from circle

var tNewAttack,tDir;//,tFindClosest;

tDir=point_direction(x,y,oIdentifier.chaoTargetX,oIdentifier.chaoTargetY)
tNewAttack=instance_create(x,y,oVP_ChaoBullet)
//tNewAttack.direction=tDir; tNewAttack.image_angle=tDir
tNewAttack._direction=tDir; tNewAttack.image_angle=tDir //60fps change: the Chao bullet moves by _direction/_speed (as oVP_AtkSpot's)
