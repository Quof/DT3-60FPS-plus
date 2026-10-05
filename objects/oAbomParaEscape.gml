#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=0.4
image_yscale=0.4
xSpd=1
ySpd=4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  var tA; //speed changes per tick, decided like at 30fps (scrTickAcc)
  tA=0; if xSpd<8 {tA=0.1}
  xSpd=scrTickAcc(xSpd,tA,0)
  tA=0; if ySpd>-3 {tA=-0.2}
  ySpd=scrTickAcc(ySpd,tA,1)

  x+=(xSpd+scrTickAccB(0))*gDeltaTime
  y+=(ySpd+scrTickAccB(1))*gDeltaTime

  if x>=room_width+128 {instance_destroy()}

  var tEffect,tScale;
  if gDeltaDoTicks for(i=0;i<4;i+=1)
  {
    tScale=random(0.25)
    tEffect=instance_create(x+random_range(-32,32),y+random_range(-32,32),oEffect)
    tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=30; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_xscale=0.5+tScale; tEffect.image_yscale=0.5+tScale; tEffect.image_angle=random(360)
  }
}
