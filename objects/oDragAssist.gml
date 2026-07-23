#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
shotDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=1 //Spike Shield
  {
    sprite_index=sDrag_Assist1
    image_xscale=1.5; image_yscale=1.5
  }
  else if type=2 //Plasma Drone
  {
    sprite_index=sDrag_Assist2
    image_xscale=1; image_yscale=1
    shotDelay+=1
    if shotDelay>=25 and scrController(5) and oDragoonShip.bSucking=0
    {
      var tNewBullet;
      tNewBullet=instance_create(x,y,oDragShip_AShot2)
      tNewBullet.bulletSpeed=10; tNewBullet.atkPower=10
      if instance_exists(oCHAOS_Assault)
      {
        var myTarget;
        myTarget=instance_nearest(x,y,oCHAOS_Assault)
        tNewBullet.direction=point_direction(x,y,myTarget.x,myTarget.y)
      }
      shotDelay=0
    }
  }
}
#define Collision_oEProjectileBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sDrag_Assist1 and other.size=1
{
  var tEffect;
  tEffect=instance_create(other.x,other.y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  with other {instance_destroy()}
}
