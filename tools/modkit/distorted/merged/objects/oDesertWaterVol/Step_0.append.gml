if global.gamePaused=false and room=rDistortedAbom
{
  //y+=2 //spsp ns
  y+=2*gDeltaTime //60fps change: per frame
  if y>room_height+32 {instance_destroy()}
}
