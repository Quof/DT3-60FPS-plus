//Evil Boss Gallery: Evil Helmethead's room (the build's copy of rLink2_PalaceA_11): the gallery's fight as that room's
//code starts it (the camera held on the arena, its barriers, the player's status kept for Retry), with Evil Helmethead.
//The room's story object isn't made here, only the event holder it is (oGlobalEvent)
locationCheck(10)
global.zEncZone=1
instance_create(0,0,oGlobalEvent)
blackTop=instance_create(0,0,oG2_BlackTop)
var tempMplay,viewFix;
tempMplay=findMusic(802)
viewFix=instance_create(448,176,oMisc)
viewFix.type=0
viewFix.sprite_index=sNull
view_object[0]=viewFix
instance_create(240,240,oBossBarrier)
instance_create(640,240,oBossBarrier)
oPlayer1.x=448; oPlayer1.y=304
storeStatus(1)
boss=instance_create(576,304,oEvgHelmet)
boss.activateBoss=1
playMusic(tempMplay,0,0)
