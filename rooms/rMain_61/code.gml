locationCheck(61)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=5
backFollow.backSet=backStarrySkiesA1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.9
backFollow.depth=1499999
backFollow.SetA=backStarrySkiesA1
backFollow.SetB=backStarrySkiesA2
backFollow.cycleSpd=20

gameScene=instance_create(0,0,oEvCh18MainA)
instance_create(0,0,oCh18_SnowflakeSpawn)
instance_create(0,0,oCh18Snowstorm)
instance_create(0,0,oCh18CloudySky)

tile_layer_hide(999990)
indexCheck=string_char_at(global.gameOptShortcuts,3)
if indexCheck="1"
{
  tile_layer_show(999990)
  var tNewCol;
  tNewCol=instance_create(208,192,oInvisibleSolid); tNewCol.image_xscale=3
  tNewCol=instance_create(112,272,oInvisibleSolid); tNewCol.image_xscale=3
  tNewCol=instance_create(272,448,oInvisibleSolid); tNewCol.image_xscale=3
  tNewCol=instance_create(304,592,oInvisibleSolid); tNewCol.image_xscale=3
}

var tempMplay;
tempMplay=findMusic(21)
playMusic(tempMplay,0,0)
