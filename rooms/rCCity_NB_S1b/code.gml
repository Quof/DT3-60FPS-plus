locationCheck(9)

if global.gameProgress=1060
  global.gameProgress=1070
global.partySplit=0
view_hspeed[0]=16*gDeltaTime; view_vspeed[0]=16*gDeltaTime //60fps change (added): this room's view follows the player at most 16px per step (room settings), and GM moves it that much every frame, so the camera caught up 2x/4x as fast at 60/120fps

gameScene=instance_create(0,0,oEvCh5MainA)

var tempMplay;
tempMplay=findMusic(3)
playMusic(tempMplay,0,0)
