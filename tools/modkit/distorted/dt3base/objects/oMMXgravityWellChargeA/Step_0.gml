event_inherited()
if global.gamePaused=false
{
  lifeTime-=1*gDeltaTime
  if atkProg=0
  {
    if place_meeting(x,y,oNightmareEffect) {y-=6*gDeltaTime}
    else {y-=12*gDeltaTime}
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
      image_angle+=15*gDeltaTime
      if lifeTime mod 4=0
      {
        if instance_exists(oEnemyBase)
        {
          myTarget=instance_nearest(x,y,oEnemyBase)
          var tTargetCenterX,tTargetCenterY;
          tTargetCenterX=myTarget.bbox_left+(sprite_width/2)
          tTargetCenterY=myTarget.bbox_top+(sprite_height/2)
          _direction=point_direction(x,y,tTargetCenterX,tTargetCenterY)
        }
        else
        {
          _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        }
        var myAtk;
        myAtk=instance_create(x+lengthdir_x(6,_direction),y+lengthdir_y(6,_direction),oMMXgravityWellChargeB)
        myAtk._direction=_direction
      }
    }
    else
    {
      image_angle+=5*gDeltaTime
      if lifeTime mod 4=0
      {
        var myAtk;
        for(i=0;i<2;i+=1)
        {
          myAtk=instance_create(x+lengthdir_x(6,image_angle+(i*180)),y+lengthdir_y(6,image_angle+(i*180)),oMMXgravityWellChargeB)
          myAtk._direction=image_angle+(i*180)
        }
      }
    }
    if lifeTime=0 {instance_destroy()}
  }
}
correctSpeedDirection(self)
