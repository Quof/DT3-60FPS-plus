//Evil Boss Gallery: Thunderbird's own draw, its eyes flashing before a swoop
event_inherited()
if evgMove=3 and evgStage=1
{
  if (floor(evgT/2) mod 2)=0
  {
    draw_set_color(make_color_rgb(255,240,120))
    draw_circle(x-5,y-6,3,0)
    draw_circle(x+5,y-6,3,0)
    draw_set_color(c_white)
  }
}
