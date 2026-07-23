#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dirChangeTime=irandom(30)
direction=choose(0,90,180,270)
timeTillExp=60+irandom(150)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewTrail;
tNewTrail=instance_create(x,y,oVaultLineTail)
tNewTrail.type=1; tNewTrail.size=size; tNewTrail.fadeSpd=fadeSpd;
tNewTrail.image_alpha=0.75; tNewTrail.image_blend=image_blend

dirChangeTime+=1
if dirChangeTime=40
{
  dirChangeTime=irandom(30)
  direction=choose(0,90,180,270)
}

timeTillExp-=1
if timeTillExp<=0
{
  var tDir;
  tDir=0
  for(i=0;i<10;i+=1)
  {
    var tFFScl;
    tFFScl=random(0.05)
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.image_alpha=0.1
    tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl; tEffect.direction=tDir
    tEffect.speed=random(0.5)+0.75; tEffect.fadeSpd=0.005; tEffect.image_blend=image_blend
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0
    tDir+=360/12
  }
  instance_destroy()
}

if checkScreenArea(x,y,16)=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_add)
draw_set_alpha(image_alpha)
draw_set_color(image_blend)
draw_rectangle(x,y,x+size,y+size,0)
draw_set_blend_mode(bm_normal)
