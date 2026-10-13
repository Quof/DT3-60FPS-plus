if global.gamePaused=false
{
  if myDist<64 {myDist+=16*gDeltaTime}
  myDir+=8*gDeltaTime
  x=warTarget.x+lengthdir_x(myDist,myDir)
  y=warTarget.y-26+lengthdir_y(myDist,myDir)
  if global.activeCharacter!=3
  {
  image_angle=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  }
  else
  {
    image_angle=point_direction(x,y,oIdentifier.x,returnPlayerYCenter())
  }

  atkTime+=1*gDeltaTime
  if atkTime>=28
  {
    var tEffect,tAtk;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.7; tEffect.image_yscale=0.7
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tAtk=instance_create(x,y+7,oPassBullet)
    tAtk.sprite_index=sWarmasterD_EX_Ball; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
    tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.image_speed=0.33; tAtk._direction=image_angle
    instance_destroy()
  }
}
