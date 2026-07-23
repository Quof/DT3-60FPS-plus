locationCheck(39)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2; backFollow.backSet=backFarreachesA
backFollow.xMoveScale=0.6; backFollow.yMoveScale=0.89
backFollow.depth=1499999; backFollow.image_blend=make_color_rgb(170,170,170)

backFollow=instance_create(64,64,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(240,32,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(128,224,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(32,288,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(160,272,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(176,368,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;
backFollow=instance_create(256,128,oBackSpriteStatic)
backFollow.sprite_index=sEfEnergyRip; backFollow.image_speed=0.02+random(0.03); backFollow.image_alpha=0.1
backFollow.image_xscale=3; backFollow.image_yscale=3;

gameScene=instance_create(-8,144,oEvCh9MainA)

ringManager=instance_create(0,0,oCh9RingManager)
ringManager.doorID=(GID(245865))
ringManager.itemIndex=38; ringManager.ringMax=21

var tempMplay;
if global.gameProgress>=2130 {tempMplay=findMusic(202)}
else {tempMplay=findMusic(10)}
playMusic(tempMplay,0,0)
