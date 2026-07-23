#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
viscidTop=1
makeActive()

//variables for the fall platform
grav=0.2             //how fast it falls
shaking=0            //is the platform shaking
timeUntilFall=25     //time till platform falls

shakeX=0
deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  image_xscale=6
  image_yscale=2
  colVolumeFollow=instance_create(x+16,y+32,oInvisibleSolid)
  colVolumeFollow.image_xscale=4
  colVolumeFollow.image_yscale=5+((platHeight-1)*4)
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks
{
  if shaking
  {
    timeUntilFall-=1
    if timeUntilFall<=0
    {
      shakeX=0
      yAcc=grav
      if yVel>3
        yVel=3
    }
    else
    {
      if shakeX=1
        shakeX=-1
      else
        shakeX=1
    }
  }
  else
  {
    //if the character stands on the platform, start the timer
    if isCollisionCharacterTop(1,0)
      shaking=1
  }

  if type=0
  {
    colVolumeFollow.x=x+16
    colVolumeFollow.y=y+32
  }

  if y>=room_height+32
  {
    with colVolumeFollow
      instance_destroy()
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Castlevania Courtyard
{
  draw_background_part(tileCastlevaniaE,80,112,16,32,x+shakeX,y) //left
  draw_background_part(tileCastlevaniaE,0,0,64,48,x+16+shakeX,y) //mid
  draw_background_part(tileCastlevaniaE,96,112,16,32,x+80+shakeX,y) //right

  for(i=0;i<platHeight;i+=1)
  {
    draw_background_part(tileCastlevaniaE,0,128,32,64,x+16+shakeX,y+48+(i*64)) //bottom left
    draw_background_part(tileCastlevaniaE,48,128,32,64,x+48+shakeX,y+48+(i*64)) //bottom right
  }
}
