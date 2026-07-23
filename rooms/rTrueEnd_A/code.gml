oIdentifier.bCanScan=0; oIdentifier.deactivate=1

backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=0; backFollow.depth=1499999
backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=1; backFollow.depth=1499999
backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=2; backFollow.depth=10
backFollow=instance_create(0,0,oBackWastelands)
backFollow.type=3; backFollow.depth=1499999

oPlayer1.x=1088
gameScene=instance_create(0,0,oTrueEndSeq)

var tempMplay;
tempMplay=findMusic(0)
playMusic(tempMplay,0,0)
