visible=1
behavior=2
if variable_local_exists("diveIn")
{
  sprite_index=sDiveBird_Fly
  image_speed=0.33
  //x=choose(-48,room_width+48) //Test
  //y=ystart+random_range(-room_height/1.75,room_height/1.75) //Test
  image_blend=make_color_rgb(170+random(85),170+random(85),170+random(85)) //Test
  visible=0
  bDoNotDestroy=1
  flyBackTime=irandom(60)
  behavior=0
}
