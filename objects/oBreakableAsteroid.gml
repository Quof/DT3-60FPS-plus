#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
baseColor=make_color_rgb(180,220,255)
image_blend=baseColor

//Enemy base statistics
eName="An Asteroid"
eLevel=37
maxLife=100
life=maxLife
pointWorth=10
atkPower=16
dieEffect=0
moveSpd=2
spinSpd=1

jeremyText="These are like asteroids you may have seen in other video games."
chaoText="You can't eat asteroids."
devText="Thanks Bea."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 //Big Asteroid
{
  maxLife=100
  life=maxLife
}
else if type=2 //Medium Asteroid
{
  maxLife=60
  life=maxLife
  spinSpd=3
  moveSpd=5
  image_xscale=0.66; image_yscale=0.66
}
else if type=3 //Small Asteroid
{
  maxLife=30
  life=maxLife
  spinSpd=5
  moveSpd=7
  image_xscale=0.33; image_yscale=0.33
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  event_inherited()
  if bActive=true and life>0
  {
    image_angle+=spinSpd
    speed=moveSpd
  }
  else if life<=0
  {
    if type=1 or type=2 //Break into smaller asteroids
    {
      playSound(global.snd_BombExplode,0,0.98,43000)
      var tAst;
      for(i=0;i<4;i+=1)
      {
        tAst=instance_create(x,y,oBreakableAsteroid); tAst.type=type+1; tAst.direction=30+(i*90)
        instance_destroy()
      }
    }
    else //Is already a small asteroid, so get it the fuck out
    {
      playSound(global.snd_BombExplode,0,1,15000)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sEfAstExplode; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
move_wrap(1,1,60)
