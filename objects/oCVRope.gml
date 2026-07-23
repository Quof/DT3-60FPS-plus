#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sCVRopeSeg
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
idAttach.x=x+xAdjust
idAttach.y=y+yAdjust
idAttach.yVel=0
#define Collision_oBelmontDagger
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  tEffect=instance_create(other.x,other.y,oEffect)
  tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
  tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5); tEffect.image_blend=c_ltgray
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
playSound(global.snd_Bite,0,0.94,44100)
awardAwesome(30)
if variable_local_exists("progUpdate")
{
  if progUpdate=1350
  {
    msgCreate(170,100,"","The barrier to the left has been lifted.",6,1,oMessagePerson,1)
    newMessage.fadingTime=100
  }
  global.gameProgress=progUpdate
}
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<image_yscale;i+=1)
  draw_sprite(sprite_index,0,x,y+(4*i))
