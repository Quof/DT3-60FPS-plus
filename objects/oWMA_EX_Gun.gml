#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Gun
event_inherited()
bActive=true
bShowDamagePopout=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanDealDamage=false

eName="Warmaster Gun"
eLevel=40
maxLife=10
life=maxLife
atkPower=12
affiliation=7
bIsBoss=true
bNoBonus=true
hitSound=0
dieSound=0
dieEffect=0

moveTime=0
myAngle=0

var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

jeremyText="That's some mouse accuracy you have there if you scanned this. Ah, anyway, he can create hand guns that... well, they float in the air and are automated."
chaoText="HOW DO YOU HAVE TIME TO SCAN THIS?!"
devText="The gold time for this encounter is very lenient mainly due to the challenge primarily being in even winning this. Also stop trying to scan really small things on the field and get to surviving. You probably got hit trying to scan this."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Normal
  {
    moveTime+=1
    if moveTime>=1 and moveTime<=35
    {
      myAngle=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    }
    else if moveTime=50
    {
      playSound(global.snd_CShotB,0,0.9,35000)
      tNewAttack=instance_create(x+lengthdir_x(6,image_angle),y+lengthdir_y(6,image_angle),oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=myAngle; tNewAttack.image_angle=myAngle
      moveTime=0
    }
  }
  else if type=1 //Final super
  {
    moveTime+=1
    if moveTime>=shotDelay
    {
      moveTime=0
      type=0
    }
  }
  enemyStepEvent()

  if life<=0
  {
    playSound(global.snd_BombExplode,0,0.9,1)
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.45; tEffect.image_yscale=0.45
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,myAngle,image_blend,image_alpha)
