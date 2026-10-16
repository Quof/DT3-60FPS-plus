//Evil Boss Gallery: Evil Bowser's room (the build's copy of rMario1_4Boss): the gallery's fight as that room's code
//starts it (the camera held on the arena, its barriers, the player in the middle), with Evil Bowser. The top row of
//bricks is reinforced (evgHard: his first stomp on one only cracks it; evgCrackId the stomp that did) and darker. The
//room's story objects aren't made here, only the event holder they are (oGlobalEvent)
instance_create(0,0,oGlobalEvent)
var tempMplay,viewFix;
tempMplay=findMusic(801)
viewFix=instance_create(720,176,oMisc)
viewFix.type=0
viewFix.sprite_index=sNull
view_object[0]=viewFix
instance_create(560,192,oBossBarrier)
instance_create(864,192,oBossBarrier)
oPlayer1.x=720; oPlayer1.y=272
with (oMarioBreakBlock)
{
  evgHard=(y=272)
  evgCrackId=-1
  if evgHard=1 {image_blend=make_color_rgb(165,135,180)}
}
boss=instance_create(816,272,oEvgBowser)
boss.viewFix=viewFix
boss.activateBoss=1
playMusic(tempMplay,0,0)
scrMusicFreq(global.msc_BowserFight,22050) //(the game's: scaled to the file's own sample rate)
