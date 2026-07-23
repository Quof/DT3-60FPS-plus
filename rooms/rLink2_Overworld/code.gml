locationCheck(10)
global.rbSwitchBlueOn=false
if !variable_global_exists("zEncZone") {global.zEncZone=1}

global.bCanSave=true
gameScene=instance_create(0,0,oEvCh4MainA)

var tempMplay;
tempMplay=findMusic(203)
playMusic(tempMplay,0,0)
