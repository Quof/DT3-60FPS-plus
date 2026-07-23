locationCheck(34)
global.mapTeleport=41

instance_create(0,0,oWM_A)

backFollowA=instance_create(32,64,oBackgroundFollow) //360 x center
backFollowA.type=4; backFollowA.backSet=backCV_DraculaRm
backFollowA.image_xscale=1.28; backFollowA.image_yscale=1.28; backFollowA.depth=1499999
backFollowB=instance_create(686,64,oBackgroundFollow)
backFollowB.type=4; backFollowB.backSet=backCV_DraculaRm
backFollowB.image_xscale=-1.28; backFollowB.image_yscale=1.28; backFollowB.depth=1499999

var tempMplay;
tempMplay=findMusic(835)
playMusic(tempMplay,0,0)
