#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpd, moveArc
event_inherited()
image_speed=0.2

//Enemy base statistics
eName="Fire Flea"
eLevel=22
maxLife=25
life=maxLife
pointWorth=5
atkPower=7
resType[0]=2
resType[1]=2
baseItemChance=25
baseDropIndex=50
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

bTouched=0
lightFrm=0

jeremyText="If you remember Super Metroid, then you know to not destroy them as they'll lower the amount of light you have in a room. Touching them will also have this effect. You also can't use dashing or invincibility frames to bypass this effect, just don't touch them at all. It'll only take destroying about 6 of them to nearly deplete all of your light."
chaoText="These were in Metroid Prime, but were called 'Plazmite' instead. They could also attack directly whereas these will simply fly around in a simple circle pattern."
devText="I liked the idea behind the Fire Fleas and decided I wanted to explore more with them, so quite a bit of Lower Norfair revolves around them getting in the way. Not only will they deal damage, but they have the other negative effect of the light getting dimmer when making contact with them."
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTouched=1
{
  playSound(global.snd_MetEnemyDieA,0,0.92,1)
  var tEffect;
  tEffect=instance_create(bbox_left+(abs(sprite_width)/2),bbox_top+(sprite_height/2),oEffect)
  tEffect.sprite_index=sSamusMissileHit; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
if oFireFleaRmLight.darkNum<7
{
  oFireFleaRmLight.darkNum+=1
  oFireFleaRmLight.image_alpha+=0.13
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    lightFrm+=0.15

    x+=moveSpd*cos(degtorad(direction))
    y-=moveSpd*sin(degtorad(direction))
    direction-=moveArc
  }
  enemyStepEvent()
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
bTouched=1
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sFireFleaLight,lightFrm,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
