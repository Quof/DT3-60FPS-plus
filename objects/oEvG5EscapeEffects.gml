#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
redFadeAlpha=0.3
redFadeTime=0
explosionDelay=0
explosionX=0
explosionY=0
expSize=0
expType=0
soundEffectTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//-------------------- Explosion Effect --------------------
explosionDelay-=1
if explosionDelay<=0
{
  explosionX=(view_xview[0]-8)+random(view_wview[0]+16)
  explosionY=(view_yview[0]-8)+random(view_hview[0]+16)
  expSize=random_range(0.75,1.25)

  var tEffect;
  tEffect=instance_create(explosionX,explosionY,oEffect)
  tEffect.image_speed=0.5; tEffect.image_xscale=expSize; tEffect.image_yscale=expSize; tEffect.depth=4
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  expType=irandom_range(1,2)
  if expType=1 {tEffect.sprite_index=sSamusMissileHit}
  else if expType=2 {tEffect.sprite_index=sSamusSMissileHit}
  explosionDelay=irandom_range(2,5)

  soundEffectTime-=1
  if soundEffectTime<=0
  {
    playSound(global.snd_MetroidBomb,0,0.91,1)
    soundEffectTime=irandom_range(2,6)
  }
}
//-------------------- Red Fade Effect --------------------
redFadeTime+=1
if redFadeTime>=1 and redFadeTime<=50 {redFadeAlpha+=0.002}
else if redFadeTime>=51 and redFadeTime<=100
{
  redFadeAlpha-=0.002
  if redFadeTime=100 {redFadeTime=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(redFadeAlpha)
draw_set_color(c_red)
draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,false)
