#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
claireFrame=0
treadFrame=0

moveSpd=4

gunSpd=3
gunAngle=45
minAngle=21
maxAngle=108

fireRate=3
gunSpread=3
bombTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //Truck control
  if scrController(1)
  {
    if x>32 {x-=moveSpd}
  }
  else if scrController(2)
  {
    if x<384 {x+=moveSpd}
  }

  //Turret control
  if scrController(3)
  {
    if gunAngle<maxAngle {gunAngle+=gunSpd}
  }
  else if scrController(4)
  {
    if gunAngle>minAngle {gunAngle-=gunSpd}
  }

  //Fire
  if scrController(5)
  {
    if oGame.time mod fireRate=0
    {
      playSound(global.snd_MMBuster[1],0,0.85,31000)
      var tNewAtk,tDir,tOffset;
      tOffset=gunAngle+random_range(-5,5)
      tDir=gunAngle+random_range(-gunSpread,gunSpread)
      tNewAtk=instance_create(x+11+lengthdir_x(40,tOffset),y-66+lengthdir_y(40,tOffset),oTruckShot)
      tNewAtk.direction=tDir; tNewAtk.image_angle=tDir
    }
  }

  //Bomb
  if bombTime>0 {bombTime-=1}
  if scrController(6)
  {
    if bombTime=0
    {
      playSound(global.snd_BombLaunch,0,0.92,32000)
      var tNewAtk;
      tNewAtk=instance_create(x-23,y-37,oTruckBomb)
      tNewAtk.xVel=-1.5; tNewAtk.yVel=-2
      bombTime=40
    }
  }
}

//Keep player object on truck
oPlayer1.x=x-9
oPlayer1.y=y-28
oPlayer1.sprite_index=sJerryOnTruck
claireFrame+=0.33
treadFrame+=0.33
#define Collision_oZakoCannonfodder
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
other.life=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sJerryOnTruck,claireFrame,x-9,y-28,image_xscale,image_yscale,image_angle,image_blend,oPlayer1.image_alpha)
draw_sprite_ext(sClaireCasting,claireFrame,x+48,y-30,image_xscale,image_yscale,image_angle,image_blend,oPlayer1.image_alpha)
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,oPlayer1.image_alpha)

draw_sprite_ext(sTeamTruckTreads,treadFrame,x,y,image_xscale,image_yscale,image_angle,image_blend,oPlayer1.image_alpha)
draw_sprite_ext(sTeamTruckGun,0,x+11,y-66,image_xscale,image_yscale,gunAngle,image_blend,oPlayer1.image_alpha)

draw_set_color(c_black)
draw_set_alpha(0.1)
draw_line(x+11+lengthdir_x(40,gunAngle),y-66+lengthdir_y(40,gunAngle),x+11+lengthdir_x(512,gunAngle),y-66+lengthdir_y(512,gunAngle))
