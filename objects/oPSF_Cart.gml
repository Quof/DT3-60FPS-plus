#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()

jumpProg=0
wheelAngle=0
railingY=305
bumperProg=0
bumperX=0
y+=1

yGround=y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
wheelAngle-=11

if global.gamePaused=false
{
  if jumpProg=1 //Bump cart
  {
    if cartSide=0 {bumperX=80}
    else if cartSide=1 {bumperX=272}
    for(i=0;i<5;i+=1)
    {
      myBumper[i]=instance_create(bumperX+(i*21),288,oLargeJumper)
      myBumper[i].image_xscale=2; myBumper[i].image_yscale=2; myBumper[i].visible=0
    }

    bumperProg=1
    yVel=-2
    jumpProg=2
  }
  else if jumpProg=2 //Fall
  {
    if yVel<4 {yVel+=0.2}

    if y>=railingY //Hit rails
    {
      yVel=0
      y=railingY
      jumpProg=0
    }
  }

  if bumperProg>0
  {
    bumperProg+=1
    if bumperProg=3
    {
      for(i=0;i<5;i+=1)
      {
        with myBumper[i] {x=240; y=-24}
      }
    }
    else if bumperProg=60
    {
      for(i=0;i<5;i+=1)
      {
        with myBumper[i] {instance_destroy()}
      }
      bumperProg=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<8;i+=1)
{
  draw_sprite_ext(sPSF_Cart_Wheel,0,x-56+(i*16),y+10,1,1,wheelAngle+(i*17),c_white,1)
}

draw_sprite(sprite_index,image_index,x,y)
