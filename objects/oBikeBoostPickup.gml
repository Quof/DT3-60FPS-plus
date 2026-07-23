#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oPlayer1.attackState=oPlayer1.ACT_IN_BIKE
  {
    if point_distance(oPlayer1.x,0,x,0)<16 and point_distance(0,oPlayer1.y-26,0,y)<28
    {
      if oPlayer1.bikeBoost<300
      {
        oPlayer1.bikeBoost+=10
        if oPlayer1.bikeBoost>300 {oPlayer1.bikeBoost=300}
      }
      playSound(global.snd_HealthPickup,0,0.8,40000)
      awardAwesome(10)
      tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
      tEffect.sprite_index=sHeal
      tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-(oPlayer1.sprite_height/2)
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
