#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if global.activeCharacter=0
  {
    with oPlayer1
    {
      grappleState=0
      attackState=ACT_IN_BIKE
      facing=RIGHT
      image_index=0
      maxSlope=11; maxDownSlope=11
      setCollisionBounds(-16,-28,16,-1)
    }
    instance_create(0,0,oBikeViewFollow)
    view_object[0]=oBikeViewFollow

    for(i=0;i<doorID.image_yscale;i+=1)
    {
      tEffect=instance_create(doorID.x+8,doorID.y+8+(i*16),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    with doorID {instance_destroy()}
    instance_destroy()
  }
  else
  {
    msgCreate(170,100,"","Claire cannot use the bike because she doesn't have the keys.",6,1,oMessagePerson,0)
    newMessage.fadingTime=70
  }
}
