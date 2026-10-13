if bRunThrough=0
{
  playSound(global.snd_ComicHit1,0,0.83,30000+(oC5RingManager.ringColl*1500))
  oC5RingManager.resetTime=32
  oC5RingManager.ringColl+=1
  image_index=2
  image_blend=c_black
  bRunThrough=1
}
