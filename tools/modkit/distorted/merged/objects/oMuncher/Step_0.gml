if global.gamePaused=false
{
  atkProg+=1*gDeltaTime
  //if atkProg>=31 and atkProg<=38
  if atkProg>30 and atkProg<=38 //60fps change: covers every frame of ticks 31-38, so the Muncher moves the full 16px (15px at 60fps, 14.5px at 120fps)
  {
    //if spcheck=0 {y+=2}
    //else {x+=2}
    if spcheck=0 {y+=2*gDeltaTime} //60fps change: per frame
    else {x+=2*gDeltaTime} //60fps change: per frame
    if atkProg=38
    {
      if image_yscale=1 {image_index=0} //spsp ns extensions
      else {image_index=1}
    }
  }
  //else if atkProg>=69 and atkProg<=76
  else if atkProg>68 and atkProg<=76 //60fps change: see above
  {
    //if spcheck=0{y-=2}
    //else {x-=2} //spsp ns all this
    if spcheck=0 {y-=2*gDeltaTime} //60fps change: per frame
    else {x-=2*gDeltaTime} //spsp ns all this. 60fps change: per frame
    if atkProg=76
    {
      if image_yscale=1 {image_index=1}
      else {image_index=0}
      atkProg=0
    }
  }
}
/*
if global.gamePaused=false
{
  atkProg+=1
  if atkProg>=21 and atkProg<=28
  {
    y+=2
    if atkProg=28
      image_index=0
  }
  else if atkProg>=49 and atkProg<=56
  {
    y-=2
    if atkProg=56
    {
      image_index=1
      atkProg=0
    }
  }
}
