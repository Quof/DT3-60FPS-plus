//Evil Boss Gallery: Evil Bowser landing on bricks (Bowser's: they break, atkProg 4). A reinforced brick (evgHard, the
//room's code: the top row) only cracks the first time; the stomp that cracked it (evgCrackId) can't also break it, the
//next one does
if atkProg=4
{
  with other
  {
    if evgHard=1
    {
      evgHard=0
      evgCrackId=other.stompId
      image_blend=make_color_rgb(255,170,150)
      playSound(global.snd_HardHit2,0,0.9,20000)
      for(i=0;i<2;i+=1)
      {
        newEffect=instance_create(x+8,y+8,oEfMarioBlock)
        newEffect.type=i
      }
    }
    else if evgCrackId!=other.stompId
    {
      for(i=0;i<4;i+=1)
      {
        newEffect=instance_create(x+8,y+8,oEfMarioBlock)
        newEffect.type=i
      }
      instance_destroy()
    }
  }
}
