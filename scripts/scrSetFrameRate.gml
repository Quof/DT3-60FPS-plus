/*
fps option change (added): sets the frame rate the game runs at (30, 60 or 120) the way F2 does (oGame): room_speed and
the delta time everything moves by (gDeltaTime = 30/fps). Used by Options > Graphics > FPS and by loadOptions.
argument0: frames per second
*/
global.gameFrameRate=argument0
room_speed=global.gameFrameRate
gDeltaTime=30/global.gameFrameRate
gDeltaTick=0.0
