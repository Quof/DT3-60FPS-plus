#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bBlownUp=0
soundDelay=0
x+=8
xPrev=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bBlownUp=1
{
  soundDelay+=1
  if soundDelay mod 2=0
  {
    if soundDelay mod 8=0 {playSound(global.snd_BombExplode,0,0.95,1)}
    tEffect=instance_create(oPlayer1.x-20+random(40),oPlayer1.y-20+random(40),oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.depth=15
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.attackState=oPlayer1.ACT_IN_BIKE and bBlownUp=0
{
  if xPrev=oPlayer1.x
  {
    for(i=0;i<7;i+=1)
    {
      tDir=random_range(-3,3)
      tEffect=instance_create(oPlayer1.x-22+random(44),oPlayer1.y-random(20),oEffectGrav); tEffect.sprite_index=sJerryBikeParts
      tEffect.image_speed=0; tEffect.type=2; tEffect.image_index=i
      tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
      tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    }
    tEfPlayer=instance_create(oPlayer1.x,oPlayer1.y,oEffectGrav); tEfPlayer.sprite_index=sJerryBikeThrown
    tEfPlayer.image_speed=0.33; tEfPlayer.type=1; tEfPlayer.image_xscale=-1
    tEfPlayer.xSpd=6; tEfPlayer.ySpd=-5-random(1); tEfPlayer.grav=0.4
    tEfPlayer.newBlend=-1; tEfPlayer.decay=-100; tEfPlayer.followID=-1; tEfPlayer.rotation=0

    global.recBikeCrashes+=1
    oPlayer1.visible=0
    oPlayer1.life-=oPlayer1.maxLife
    bBlownUp=1
  }
  else
  {
    xPrev=oPlayer1.x
  }
}
