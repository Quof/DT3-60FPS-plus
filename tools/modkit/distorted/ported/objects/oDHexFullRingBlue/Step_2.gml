if room=rAbomD or room=rAbomE or room=rAbomF
{
  x=oIdentifier.x
  y=oIdentifier.y
  //image_xscale-=0.00012      //rounding up 0.00013... (=1/7500, silver time = 250 seconds)
  //image_yscale-=0.00012      //new: allow 280 seconds => round up 1/(30*280) = 1/8400
  image_xscale-=0.00012*gDeltaTime //60fps change: per frame
  image_yscale-=0.00012*gDeltaTime //60fps change: per frame
}
//also need image collision, not mask collision
