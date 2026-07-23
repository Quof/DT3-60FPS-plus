#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_alpha=0
effectSize[0]=1
effectSize[1]=1.25
effectSize[2]=1.5
effectAlpha[0]=0.75
effectAlpha[1]=0.5
effectAlpha[2]=0.25

instrProg=0
activeTime=0
bCanTakeDamage=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if instrProg=0
  {
    image_alpha+=0.02
    if image_alpha=1
    {
      activeTime=500+(image_index*180)
      instrProg+=1
    }
  }
  else if instrProg=1
  {
    if bCanTakeDamage=0
    {
      activeTime-=1
      if activeTime<=0 {bCanTakeDamage=1}
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanTakeDamage=1
{
  activeTime=1360+(image_index*40)
  bCanTakeDamage=0
  playSound(global.snd_SwitchHit,0,0.95,25000)
  if other.bCanPierce=0
  {
    with other {instance_destroy()}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanTakeDamage=0
{
  if image_alpha=1
  {
    for (i=0;i<3;i+=1)
    {
      if effectSize[i]<1.75
      {
        effectSize[i]+=0.01
        effectAlpha[i]-=0.01
      }
      else
      {
        effectSize[i]=1
        effectAlpha[i]=0.75
      }
    }
    draw_set_blend_mode(bm_add)
    draw_set_alpha(0.4)
    draw_circle_color(x,y,20,make_color_rgb(240,160,70),c_black,false)
    draw_set_alpha(0.3)
    draw_circle_color(x,y,35,make_color_rgb(240,160,70),c_black,false)
    draw_set_alpha(0.2)
    draw_circle_color(x,y,50,make_color_rgb(240,160,70),c_black,false)
    for(i=0;i<3;i+=1) {draw_sprite_ext(sprite_index,image_index,x,y,effectSize[i],effectSize[i],0,c_white,effectAlpha[i])}
    draw_set_blend_mode(bm_normal)
  }
  draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,image_alpha)
}
else
{
  draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_gray,image_alpha)
}
