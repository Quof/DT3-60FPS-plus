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

xSpace=(image_xscale-1)*16
ySpace=(image_yscale-1)*16
shakeX=0
deathCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
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

  if y>=room_height+32
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background_part(tileMarioWorldA,64,176,16,16,x+shakeX,y) //top left
draw_background_part(tileMarioWorldA,96,176,16,16,x+xSpace+shakeX,y) //top right
draw_background_part(tileMarioWorldA,64,208,16,16,x+shakeX,y+ySpace) //bottom left
draw_background_part(tileMarioWorldA,96,208,16,16,x+xSpace+shakeX,y+ySpace) //bottom right

for(i=1;i<image_xscale-1;i+=1)
  draw_background_part(tileMarioWorldA,80,176,16,16,x+(i*16)+shakeX,y) //top mid
for(i=1;i<image_xscale-1;i+=1)
  draw_background_part(tileMarioWorldA,80,208,16,16,x+(i*16)+shakeX,y+ySpace) //bottom mid
for(i=1;i<image_yscale-1;i+=1)
  draw_background_part(tileMarioWorldA,64,192,16,16,x+shakeX,y+(i*16)) //left mid
for(i=1;i<image_yscale-1;i+=1)
  draw_background_part(tileMarioWorldA,96,196,16,16,x+xSpace+shakeX,y+(i*16)) //right mid

for(i=1;i<image_xscale-1;i+=1)
{
  for(ii=1;ii<image_yscale-1;ii+=1)
    draw_background_part(tileMarioWorldA,80,192,16,16,x+(i*16)+shakeX,y+(ii*16)) //middle
}
