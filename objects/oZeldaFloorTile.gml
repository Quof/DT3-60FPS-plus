#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bActive=true

//Enemy base statistics
eName="Wall Block"
eLevel=10
maxLife=100
life=maxLife
pointWorth=10
atkPower=5
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=3
stunResist=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

atkProg=0
atkTime=0
colorOther=255

jeremyText="Nothing really note worthy about these except that you can destroy them, which I'd recommend you do."
chaoText="You know what these are, just the floor tiles."
devText="These were considered traps right up until the very end of development, where I changed them into an enemy type so the player could destroy them with explosives."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle-=22.5
  atkTime+=1
  if atkProg=0 //Rise
  {
    y-=1
    if atkTime=30 {atkTime=0; atkProg+=1}
  }
  else if atkProg=1 //Wait
  {
    colorOther-=5
    image_blend=make_color_rgb(255,colorOther,colorOther)
    if atkTime=30
    {
      direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      bCanDealDamage=1
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=2 //Attack and collision check
  {
    speed=6
  }
  enemyStepEvent()
}
else {speed=0}
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg=2 and atkTime>5
{
  playSound(global.snd_MarioBlockBreak,0,1,1)
  tEffect=instance_create(x+4,y-4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=1; tEffect.ySpd=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  tEffect=instance_create(x-4,y-4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=-1; tEffect.ySpd=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  tEffect=instance_create(x-4,y+4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=-1; tEffect.ySpd=1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  tEffect=instance_create(x+4,y+4,oEffect)
  tEffect.sprite_index=sEfMarioBHit; tEffect.decay=10; tEffect.xSpd=1; tEffect.ySpd=1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=5
  instance_destroy()
}
