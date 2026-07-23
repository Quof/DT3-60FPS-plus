locationCheck(70)

global.canPause=1

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backLavaCave
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.6
backFollow.depth=1499999

backFore=instance_create(0,0,oBackSpriteStaticRepeat)
backFore.sprite_index=sCh18AnimFore; backFore.depth=0; backFore.image_speed=0.2; backFore.image_alpha=0.15
backFore.xRepeat=round((room_width+128)/128); backFore.yRepeat=round((room_height+128)/128)

gameScene=instance_create(0,0,oEvCh18MainA)
mapScene=instance_create(0,0,oEvCh18SideA)

instance_create(0,304,oCh18LavaFloor)
instance_create(0,0,oCh18LavaCaveEffects)

var tempMplay;
tempMplay=findMusic(23)
playMusic(tempMplay,0,0)
