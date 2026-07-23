#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
effectSize[0]=1
effectSize[1]=1.25
effectSize[2]=1.5
effectAlpha[0]=0.75
effectAlpha[1]=0.5
effectAlpha[2]=0.25
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewString;
tNewString=string_delete(global.eGateProg,instrType,1)
tNewString=string_insert("9",tNewString,instrType)
global.eGateProg=tNewString

var tDir;
tDir=0
for(i=0;i<20;i+=1)
{
  var tFFScl;
  tFFScl=random(0.1)
  tEffect=instance_create(x,y,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_alpha=0.5; tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl
  tEffect.direction=tDir; tEffect.speed=random(0.25)+0.75
  tEffect.fadeSpd=0.01; tEffect.image_blend=c_teal
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  tDir+=360/20
}
tDir=0
for(i=0;i<40;i+=1)
{
  var tFFScl;
  tFFScl=random(0.1)
  tEffect=instance_create(x,y,oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_alpha=0.8; tEffect.image_xscale=0.2+tFFScl; tEffect.image_yscale=0.2+tFFScl
  tEffect.direction=tDir+irandom_range(-2,2); tEffect.friction=0.02; tEffect.speed=random(1)+2
  tEffect.fadeSpd=0.005; tEffect.image_blend=c_green
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
  tDir+=360/40
}

var tFlash;
tFlash=instance_create(0,0,oScreenFlash)
tFlash.fadeSpeed=0.2

if instrType=1
  currInstr="Full Moon Cello"
else if instrType=2
  currInstr="Conch Horn"
else if instrType=3
  currInstr="Sea Lily's Bell"
else if instrType=4
  currInstr="Surf Harp"
else if instrType=5
  currInstr="Wind Marimba"
else if instrType=6
  currInstr="Coral Triangle"
else if instrType=7
  currInstr="Organ of Evening Calm"
else if instrType=8
  currInstr="Thunder Drum"
msgCreate(170,72,"",string("You obtained the ") +string(currInstr) +string("!"),6,1,oMessagePerson,0)
newMessage.fadingTime=70

instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
for(i=0;i<3;i+=1) {draw_sprite_ext(sprite_index,instrType-1,x,y,effectSize[i],effectSize[i],0,c_white,effectAlpha[i])}
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,instrType-1,x,y,1,1,0,c_white,1)
