#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=-1
fanAnim=0
bDrawMe=1

bPete=0
peteYOffset=42
bLaser=0
laserScl=0
laserUp=1
circleRad=0

eventProg=0
eventTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fanAnim+=0.33
if global.gamePaused=false
{
  if eventProg=0 //Slight wait
  {
    eventTime+=1
    if eventTime=110
    {
      var tempMplay;
      tempMplay=findMusic(1017)
      playMusic(tempMplay,0,1)
      eventTime=0; eventProg+=1
    }
    else if eventTime>=120 {eventTime=0; eventProg+=1}
  }
  else if eventProg=1 //Fly down
  {
    y+=0.5
    if y>=80 {eventProg+=1}
  }
  else if eventProg=2 //Pete appears
  {
    eventTime+=1
    if eventTime=50 {playSound(global.snd_Dec_ChargeUp,0,1,1)}
    else if eventTime=70 {bPete=1}
    else if eventTime>=71 and eventTime<=77 {peteYOffset-=6}
    else if eventTime>=120 {eventTime=0; eventProg+=1}
  }
  else if eventProg=3 //Pete is shot down
  {
    eventTime+=1
    if eventTime=1
    {
      playSound(global.snd_Dec_Fire,0,1,1)
      bLaser=1
    }
    if eventTime>=1 //Laser Scale
    {
      if laserUp=1
      {
        laserScl+=0.01
        if laserScl>=0.15 {laserUp=0}
      }
      else
      {
        laserScl-=0.01
        if laserScl<=0 {laserUp=1}
      }
    }
    if eventTime mod 4=0 //Explosions
    {
      playSound(global.snd_BombExplode,0,0.92,1)
      tEffect=instance_create(x+random_range(-32,32),y+random(52),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if eventTime>=60
    {
      circleRad+=8
      if circleRad=224 {bDrawMe=0}
      else if circleRad>=304
      {
        image_alpha-=0.05
        if image_alpha<=0
        {
          oEvCh19MainA.sceneProgress=2
          instance_destroy()
        }
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
if bDrawMe=1
{
  if bPete=1
  {
    draw_sprite_ext(sPeteInMachine,0,x,y+peteYOffset,image_xscale,image_yscale,0,image_blend,image_alpha)
  }
  draw_self()
  draw_sprite_ext(sBowserM_Fan,fanAnim,x,y+56,image_xscale,image_yscale,0,image_blend,image_alpha)
  if bLaser=1
  {
    for(i=0;i<32;i+=1)
    {
      draw_sprite_ext(sDeci_BigLaser,0,i*16,y-16,image_xscale,image_yscale+laserScl,0,image_blend,image_alpha)
    }
  }
}

if circleRad>0
{
  draw_set_alpha(image_alpha)
  draw_set_color(c_white)
  draw_circle(x,y,circleRad,0)
}
