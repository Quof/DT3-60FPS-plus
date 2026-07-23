locationCheck(41)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=0
backFollow.backSet=backCCityBackA
backFollow.wSize=480
backFollow.hSize=352

gameScene=instance_create(0,0,oEvCh11MainA)
infiniteDash=instance_create(0,0,oInfiniteDash)

var tempMplay;
tempMplay=findMusic(2)
playMusic(tempMplay,0,0)
