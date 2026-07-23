#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dispTime=65
myColor=make_color_rgb(251,166,2)

displayX=view_xview[0]+240
displayY=view_yview[0]+144

global.recBirdsSeen+=80
for(i=0;i<80;i+=1)
{
  myDir=choose(-1,1)
  tEffect=instance_create(displayX+random(24),displayY+random(24),oEffect)
  tEffect.sprite_index=sBlackCrowFly; tEffect.image_speed=0.25+random(0.1); tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.image_xscale=myDir; tEffect.newBlend=-1; tEffect.decay=180; tEffect.xSpd=random(4*myDir); tEffect.ySpd=-1-random(4); tEffect.depth=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  displayX=view_xview[0]+240
  displayY=view_yview[0]+144
  draw_sprite_ext(sprite_index,0,displayX,displayY,1,1,0,image_blend,image_alpha)
  draw_set_halign(fa_center)
  draw_set_alpha(image_alpha)
  draw_set_color(myColor)
  draw_set_font(fnt_GameOver)
  draw_text(displayX,displayY-18,myLevel)

  dispTime-=1
  if dispTime<=0
  {
    image_alpha-=0.04
    if image_alpha<=0 {instance_destroy()}
  }
}
