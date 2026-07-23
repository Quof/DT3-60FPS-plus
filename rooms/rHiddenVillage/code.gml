locationCheck(86)

gameScene=instance_create(0,0,oEvCh19MainA)
mapScene=instance_create(0,0,oEvCh19SideA)
solidColor=instance_create(0,1200,oSolidBackgroundColor)
solidColor.image_blend=make_color_rgb(80,72,88)
solidColor.image_xscale=room_width; solidColor.image_yscale=80

birdSpawner=instance_create(0,0,oSpawnGrayBirds)
infiniteDash=instance_create(0,0,oInfiniteDash)

var tempMplay;
if global.gameProgress>=4570 {tempMplay=findMusic(27)}
else {tempMplay=findMusic(0)}
playMusic(tempMplay,0,0)
