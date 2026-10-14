//Distorted's 2x speed room: rExtGateE_3, entered through rExtGateE_2's exit (oExit sets global.distSpeedRoom there and
//clears it at rExtGateE_3's exit). The original set the frame rate to 60 for it, which in DT3+ is the FPS option; here
//the game speed doubles with global.modSpeedMul, which the game sets back to 1 in every room. Leaving the room another
//way (a game over, a warp) ends it as well, with the 2x sound and music pitch (global.modeSpeed) that goes with it.
if global.distSpeedRoom=1
{
  if room=rExtGateE_3 {global.modSpeedMul=2}
  else
  {
    global.distSpeedRoom=0
    global.modeSpeed=0
    if global.currentMusic!=0 {scrMusicFreq(findMusic(global.currentMusic),22050)}
  }
}
