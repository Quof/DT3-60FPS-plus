#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_yscale=-1
image_speed=0.2
visible=false
hoverAlpha=-1

//Enemy base statistics
eName="Podobo"
atkPower=8
damageType="ELEMENTAL"
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
affiliation=1
bCanTakeDamage=false
bShowHealthBar=false
detectDistX=120
detectDistY=272
rising=0
yVel=0
glowScl=1.1

jeremyText="It simply propels itself out of lava pits at set locations. I've always wondered about the mechanics behind a living fireball that can thrust itself that high."
chaoText="Interesting bit of somewhat irrelevant information. Back in the day, there was a Youtube Lets Player that said the word 'Podobo' a lot. Probably because he played so many Super Mario World hacks."
devText="In the code for DT1, these are actually labeled as 'Lava Guy' instead of 'Podobo'. I don't remember why anymore. That tag remains for DT3."
extraInfo="Completely immune to damage."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks != 0
{
  if bActive=0 {makeEnemyActive(1)}
  if bActive=true and rising>=0
  {
    glowScl+=0.025
    if glowScl>=1.4 {glowScl=1.1}
    if rising=0
    {
      playSound(global.snd_Fireball,0,0.85,33075)
      yVel=10
      visible=true
      rising=1
    }
    if yVel<0
      image_yscale=1
    else
      image_yscale=-1
    yVel-=0.3
    y+=yVel
    if yVel<1 and y<ystart
    {
      var tEffect;
      tEffect=instance_create(x+2,ystart-4,oEffectGrav)
      tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_yscale=-1
      tEffect.type=1; tEffect.decay=12 tEffect.xSpd=1; tEffect.ySpd=2; tEffect.grav=-0.3; tEffect.image_blend=image_blend
      tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0
      tEffect=instance_create(x-2,ystart-4,oEffectGrav)
      tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_xscale=-1; tEffect.image_yscale=-1
      tEffect.type=1; tEffect.decay=12 tEffect.xSpd=-1; tEffect.ySpd=2; tEffect.grav=-0.3; tEffect.image_blend=image_blend
      tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0

      yVel=0
      y=ystart
      bActive=false
      visible=false
      rising=-50
    }
  }
  if rising<0 {rising+=1}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
magicInterpDrawStart()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*glowScl,image_yscale*glowScl,image_angle,image_blend,0.25)
event_inherited()
magicInterpDrawEnd()
