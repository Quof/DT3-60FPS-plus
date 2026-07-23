#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bMoving=0
wheelRotate=0
rotateSpd=6
connectionColor=make_color_rgb(62,132,146)

myGrapplePoints[0]=instance_create(x+30,y+91,oStrikeChainPoint)
myGrapplePoints[1]=instance_create(x+30,y+185,oStrikeChainPoint)
myGrapplePoints[2]=instance_create(x+79,y+135,oStrikeChainPoint)
myGrapplePoints[3]=instance_create(x+79,y+236,oStrikeChainPoint)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bMoving=1
  {
    wheelRotate+=rotateSpd
    x+=2
    y+=2

    if oGame.time mod 1=0
    {
      var tEffect;
      tEffect=instance_create(x,y-10,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect.direction=random_range(160,290)
      tEffect=instance_create(x+107,y+97,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect.direction=random_range(160,290)
      tEffect=instance_create(x+107,y+334,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect.direction=random_range(-20,110)
      tEffect=instance_create(x,y+227,oEffectSpark)
      tEffect.depth=26; tEffect.fadeSpd=0.04; tEffect.moveSpd=2+random(2); tEffect.direction=random_range(-20,110)
    }
    if x>=2144 {bMoving=0}
  }
  myGrapplePoints[0].x=x+30; myGrapplePoints[0].y=y+91
  myGrapplePoints[1].x=x+30; myGrapplePoints[1].y=y+185
  myGrapplePoints[2].x=x+79; myGrapplePoints[2].y=y+135
  myGrapplePoints[3].x=x+79; myGrapplePoints[3].y=y+236
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(connectionColor)
draw_set_alpha(1)
draw_line_width(x,y,x+107,y+107,2) //Top
draw_line_width(x+107,y+107,x+107,y+324,2) //Right
draw_line_width(x+107,y+324,x,y+217,2) //Bottom
draw_line_width(x,y+217,x,y,2) //Left
draw_line_width(x,y,x+107,y+324,2) //Diag A
draw_line_width(x+107,y+107,x,y+217,2) //Diag B
draw_sprite_ext(sCh18Wheel,image_index,x,y,image_xscale,image_yscale,wheelRotate,image_blend,image_alpha) //Top-left
draw_sprite_ext(sCh18Wheel,image_index,x+107,y+107,image_xscale,image_yscale,wheelRotate,image_blend,image_alpha) //Top-right
draw_sprite_ext(sCh18Wheel,image_index,x+107,y+324,image_xscale,image_yscale,-wheelRotate,image_blend,image_alpha) //Bottom-right
draw_sprite_ext(sCh18Wheel,image_index,x,y+217,image_xscale,image_yscale,-wheelRotate,image_blend,image_alpha) //Bottom-left
