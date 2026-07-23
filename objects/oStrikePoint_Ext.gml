#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: mySpd
event_inherited()

startLatchTime=0
latchTimer=0
latchMax=105
touchFrames=0
currSpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if bGrappled=1 {startLatchTime=1}
  if startLatchTime=1
  {
    latchTimer+=1
    if latchTimer>=latchMax
    {
      if mySpd>10
      {
        speed=mySpd
      }
      else
      {
        if currSpd<8 {currSpd+=0.1}
        speed=currSpd
      }
    }
  }
}
else {speed=0}
#define Collision_oMovingTrap
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
touchFrames+=1
if touchFrames>=7
{
  playSound(global.snd_EnemyDieMM,0,0.97,1)

  for(i=0;i<4;i+=1)
  {
    var tEffect;
    tEffect=instance_create(x+irandom_range(-4,4),y+irandom_range(-4,4),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sStrikeChainPole; tEffect.newBlend=-1;
    tEffect.direction=random(360); tEffect.speed=random(1)+2; tEffect.fadeSpd=0.05
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-3,3)
  }

  instance_destroy()
}
#define Collision_oBTB_ZeroGlass
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
touchFrames+=1
if touchFrames>=1
{
  if oPlayer1.grappleState=3 and oPlayer1.grappleID=id //Player is latched to this chain
  {
    tEfPlayer=instance_create(oPlayer1.x,oPlayer1.y-12,oEffectGrav); tEfPlayer.sprite_index=sJerryBikeThrown
    tEfPlayer.image_speed=0.33; tEfPlayer.type=1
    tEfPlayer.ySpd=-5-random(1); tEfPlayer.grav=0.4
    tEfPlayer.newBlend=-1; tEfPlayer.decay=-100; tEfPlayer.followID=-1; tEfPlayer.rotation=0
    if direction=0 {tEfPlayer.xSpd=6; tEfPlayer.image_xscale=-1}
    else if direction=180 {tEfPlayer.xSpd=-6; tEfPlayer.image_xscale=1}

    oPlayer1.visible=0
    oPlayer1.life-=oPlayer1.maxLife
  }

  playSound(global.snd_EnemyDieMM,0,0.94,1)
  playSound(global.snd_PotShatter,0,0.93,37000)
  playSound(global.snd_RupeeBounce,0,0.84,37000)

  for(i=0;i<4;i+=1)
  {
    var tEffect;
    tEffect=instance_create(x+irandom_range(-4,4),y+irandom_range(-4,4),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sStrikeChainPole; tEffect.newBlend=-1;
    tEffect.direction=random(360); tEffect.speed=random(1)+2; tEffect.fadeSpd=0.05
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=random_range(-3,3)
  }

  with other
  {
    for(i=0;i<2;i+=1)
    {
      for(ii=0;ii<4;ii+=1)
      {
        tEffect=instance_create(x+8+random_range(-3,3),y+8+(i*16)+random_range(-3,3),oEffect)
        tEffect.sprite_index=sMMGlassBreak; tEffect.image_speed=0.2+random(0.1); tEffect.image_angle=ii*90
        tEffect.direction=45+(ii*90); tEffect.speed=1+random(1)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    instance_destroy()
  }
  instance_destroy()
}
