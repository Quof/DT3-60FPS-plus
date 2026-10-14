if room=rAbomD or room=rAbomE or room=rAbomF
{
  x=oIdentifier.x
  y=oIdentifier.y
  //image_xscale-=0.000134      //rounding up 0.00013... (=1/7500, silver time)
  //image_yscale-=0.000134
  image_xscale-=0.000134*gDeltaTime      //rounding up 0.00013... (=1/7500, silver time). 60fps change: per frame
  image_yscale-=0.000134*gDeltaTime //60fps change: per frame
}
//also need image collision, not mask collision
