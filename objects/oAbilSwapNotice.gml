#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
lifeTime=60
bDisplay=1
abilCount=0
textColFill=make_color_rgb(255,248,155)
textColBorder=make_color_rgb(16,8,8)

if global.activeCharacter=0 //Jerry
{
  if global.activeAbility[0]=1
  {
    abilCount=3
    currAbil="LINK"
    textColFill=make_color_rgb(0,255,0)
    atkType[0]=0
    atkType[1]=1
    atkType[2]=4
  }
  else if global.activeAbility[0]=2
  {
    abilCount=3
    currAbil="MEGA MAN"
    textColFill=make_color_rgb(80,170,255)
    atkType[0]=3
    atkType[1]=2
    atkType[2]=5
  }
  else if global.activeAbility[0]=3
  {
    abilCount=2
    currAbil="JERRY"
    atkType[0]=3
    atkType[1]=5
  }
  else if global.activeAbility[0]=4
  {
    currAbil="DEFENDER"
  }
  else {bDisplay=0}
}
else //Claire
{
  if global.activeAbility[1]=1
  {
    abilCount=3
    currAbil="BELMONT"
    textColFill=make_color_rgb(230,200,0)
    atkType[0]=0
    atkType[1]=1
    atkType[2]=2
  }
  else if global.activeAbility[1]=2
  {
    abilCount=3
    currAbil="SAMUS"
    textColFill=make_color_rgb(230,20,20)
    atkType[0]=3
    atkType[1]=5
    atkType[2]=4
  }
  else if global.activeAbility[1]=3
  {
    abilCount=2
    currAbil="CLAIRE"
    atkType[0]=0
    atkType[1]=1
  }
  else if global.activeAbility[1]=4
  {
    currAbil="DEFENDER"
  }
  else {bDisplay=0}
}
if abilCount=2 {xOffset=20}
else {xOffset=32}

if bDisplay=0 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lifeTime-=1
if lifeTime<=20
{
  image_alpha-=0.05
  if lifeTime=0
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_set_alpha(image_alpha)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_center)
  textDropShadow(currAbil,oPlayer1.x,oPlayer1.y-78,textColFill,textColBorder,3)
  if abilCount>0
  {
    for(i=0;i<abilCount;i+=1)
    {
      draw_sprite_ext(sPauseM_AtkTypes,atkType[i],oPlayer1.x-xOffset+(i*24),oPlayer1.y-69,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    }
  }
}
