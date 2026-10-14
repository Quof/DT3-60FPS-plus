playSound(global.snd_ZeldaToMap,0,1,11025)
global.recAreaTrans+=1
global.recZeldaEnc+=1
global.newMapX=x
if room=rLink2_Overworld
  global.newMapY=y
else
  global.newMapY=y+10000
var tTileID,tTileLeft;
tTileID=tile_layer_find(1000000,x,y)
tTileLeft=tile_get_left(tTileID)
transition_steps=5
transition_kind=20
if tTileLeft=0 or tTileLeft=64
  room_goto_fixed(rLink2_EnRoad)
else if tTileLeft=16
  room_goto_fixed(rLink2_EnGrass)
else if tTileLeft=32
  room_goto_fixed(rLink2_EnDesert)
else if tTileLeft=48
  room_goto_fixed(rLink2_EnForest)
