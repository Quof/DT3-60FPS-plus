#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-7,-7,7,7)
lightFrm=0
global.recAtkNum+=1
global.stMega_Gravity[2]+=1

atkProg=0
lifeTime=10
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  lifeTime-=1
  if atkProg=0
  {
    if place_meeting(x,y,oNightmareEffect) {y-=6}
    else {y-=12}
    if lifeTime=0
    {
      lifeTime=45
      atkProg=1
    }
  }
  else if atkProg=1
  {
    if bAiming=1
    {
      image_angle+=15
      if lifeTime mod 4=0
      {
        if instance_exists(oEnemyBase)
        {
          myTarget=instance_nearest(x,y,oEnemyBase)
          var tTargetCenterX,tTargetCenterY;
          tTargetCenterX=myTarget.bbox_left+(sprite_width/2)
          tTargetCenterY=myTarget.bbox_top+(sprite_height/2)
          direction=point_direction(x,y,tTargetCenterX,tTargetCenterY)
        }
        else
        {
          direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        }
        var myAtk;
        myAtk=instance_create(x+lengthdir_x(6,direction),y+lengthdir_y(6,direction),oMMXgravityWellChargeB)
        myAtk.direction=direction
      }
    }
    else
    {
      image_angle+=5
      if lifeTime mod 4=0
      {
        var myAtk;
        for(i=0;i<2;i+=1)
        {
          myAtk=instance_create(x+lengthdir_x(6,image_angle+(i*180)),y+lengthdir_y(6,image_angle+(i*180)),oMMXgravityWellChargeB)
          myAtk.direction=image_angle+(i*180)
        }
      }
    }
    if lifeTime=0 {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lightFrm+=0.5
draw_sprite(sMMXgravityWell5,lightFrm,x,y)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
