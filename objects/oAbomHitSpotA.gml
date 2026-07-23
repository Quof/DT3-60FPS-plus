#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
image_speed=0.3
animFrm=0

//Enemy base statistics
eName="Abomination Weak Spot"
if global.modeWahfuu=1 {eName="Wahfuu Weak Spot"}
eLevel=39
maxLife=2000
life=maxLife
atkPower=12
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0

scaleWave=pi/2

deathAnim=0

var tEffect;
for(i=0;i<20;i+=1)
{
  tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffect)
  tEffect.sprite_index=sWitchFire; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_speed=0.2+random(0.2)
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.05
  tEffect.image_xscale=1+(i*1.25); tEffect.image_yscale=1+(i*1.25); tEffect.image_angle=random(360)
}

jeremyText="This is one of the weak spots that formed when the melody started playing. As for attacks this creature has; There's a continuous one where it summons those weird... things from the bottom that slowly rise up. They're a constant annoyance. Another attack I see are from those spike claws. It used this attack in the Vault. The other attack is some rain attack that I can't get info on."
chaoText="These 'weak spots' are awfully odd, even for this thing. It's like something is trying to hide itself. Let's keep the music playing and maybe we can drive it out of the creature."
devText="Oh man, this thing. Its design has changed many times over the course of the project, but the one thing that remained the same is keeping the instruments playing."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
maxLife=HPSet
life=maxLife
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if oEvAbom.instrumentActNum>=6 {bCanTakeDamage=1}
    else {bCanTakeDamage=0}
    animFrm+=image_speed
  }
  enemyStepEvent()

  if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_Slam,0,1,1)
      playSound(global.snd_DemonVoice1,0,1,1)
      var tViewShake;
      tViewShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
      tViewShake.turbulance=2; tViewShake.shakeTime=20
      bCanTakeDamage=0; bCanDealDamage=0
    }
    if deathAnim>=1
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

      image_alpha-=0.02
      if image_alpha<=0
      {
        instance_create(x+heartOffsetX,y,oHealthPickup)
        instance_destroy()
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanTakeDamage=0 and life>0 {scaleWave+=pi/60}
for(i=0;i<5;i+=1)
{
  draw_sprite_ext(sAbomBodyConnectorA,0,x+lengthdir_x(20+(18*i),direction),y+lengthdir_y(20+(18*i),direction),1.25+(sin(scaleWave+i)/2),1.25+(sin(scaleWave+i)/2),i*20,c_white,image_alpha)
}

draw_sprite_ext(sAbomHitSpotA,animFrm,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotA,animFrm+1,x,y,image_xscale,image_yscale,90,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotA,animFrm+2,x,y,image_xscale,image_yscale,180,image_blend,image_alpha)
draw_sprite_ext(sAbomHitSpotA,animFrm+3,x,y,image_xscale,image_yscale,270,image_blend,image_alpha)
