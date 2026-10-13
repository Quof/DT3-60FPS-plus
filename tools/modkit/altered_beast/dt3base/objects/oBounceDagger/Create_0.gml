event_inherited()
setCollisionBounds(-2,-2,2,2)

damageType="PIERCE"
weaponTag=31
atkLv=global.stBelmont_Dagger[0]
//atkPower=65+(global.stBelmont_Dagger[0]*2)+global.skillTree[12]
atkPower=65+(scrOmenLv(global.stBelmont_Dagger[0])*2)+global.skillTree[12] //dark omen change: the weapon level counts 10 lower while the New Dark Omen is on (scrOmenLv)
atkPower=weaponDmgMod(1,atkPower)
stunTime=7

bCollide=0
bCanHitSwitch=0
bulletSpeed=15
lifeTime=35
lingerFrame=0
noDestroyTime=1

if instance_exists(oEnemyBase)
{
  myTarget=instance_nearest(x,y,oEnemyBase)
  var tTargetCenterX,tTargetCenterY;
  tTargetCenterX=myTarget.bbox_left+(myTarget.sprite_width/2)
  tTargetCenterY=myTarget.bbox_top+(myTarget.sprite_height/2)
  _direction=point_direction(x,y,tTargetCenterX,tTargetCenterY)
  image_angle=_direction
}
else
{
  _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  image_angle=_direction
}

_speed=0
//_direction=0
//60fps change: the line above undid the aim at the target (above), so a bounced dagger always flew right while
//pointing at the target
_hspeed=0
_vspeed=0
