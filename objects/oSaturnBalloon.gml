#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
balloonProg=0
balloonTime=0
jitterAmt=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if balloonProg=1 //-------------------- Balloon is popped --------------------
{
  balloonTime+=1
  if balloonTime>=30 {balloonTime=0; balloonProg+=1}
}
else if balloonProg=2 //-------------------- Mr. Saturn jitters --------------------
{
  balloonTime+=1
  if balloonTime>=70
  {
    oMrSaturnLayDown.jitterX=random_range(-jitterAmt,jitterAmt)
    oMrSaturnLayDown.jitterY=random_range(-jitterAmt,jitterAmt)
  }

  if balloonTime=100 {jitterAmt=2}
  else if balloonTime=150 {jitterAmt=4}
  else if balloonTime=200 {jitterAmt=10}
  else if balloonTime=250 {jitterAmt=24}
  else if balloonTime=300 {jitterAmt=48}
  else if balloonTime=350 {jitterAmt=96}

  if balloonTime>=370
  {
    if balloonTime mod 10=0 {playSound(global.snd_Cucco1,0,1,16000+random(12000))}
    if global.gamePaused=false {instance_create(random(view_xview[0]+480),random(view_yview[0]+352),oUltraChicken)}
  }

  if oPlayer1.life<=0
  {
    oMrSaturnLayDown.jitterX=0; oMrSaturnLayDown.jitterY=0
    abilSetRemove(1)
    balloonTime=0; balloonProg+=1
  }
}
else if balloonProg=3 //-------------------- Wait time --------------------
{
  balloonTime+=1
  if balloonTime=90
  {
    oPlayer1.x=592; oPlayer1.y=176
    var tEffect;
    tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
    tEffect.sprite_index=sEfInternetzGrab; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75
    tEffect.image_xscale=2; tEffect.image_yscale=2
  }
  else if balloonTime=140
  {
    instance_create(oPlayer1.x-16,-16,oStaticSpike)
    instance_create(oPlayer1.x,-16,oStaticSpike)
  }
  else if balloonTime>=141 and balloonTime<=364 //112 pixels
  {
    with oStaticSpike {y+=0.5}
  }
  else if balloonTime=365 {balloonTime=0; balloonProg+=1}
}
else if balloonProg=4 //-------------------- Smash player with traps --------------------
{
  balloonTime+=1
  if balloonTime mod 3=0
  {
    playSound(global.snd_ComicHit2,0,1,20000+random(5000))
    playSound(global.snd_CShotA,0,0.9,20000+random(5000))
    setSpawnDir=random(360)
    newSatSpike=instance_create(oPlayer1.x+lengthdir_x(96,setSpawnDir),oPlayer1.y-26+lengthdir_y(96,setSpawnDir),oSaturnSpike)
    newSatSpike.direction=point_direction(oPlayer1.x+lengthdir_x(96,setSpawnDir),oPlayer1.y-26+lengthdir_y(96,setSpawnDir),oPlayer1.x,oPlayer1.y-26)
  }
  if balloonTime>=120 {balloonTime=0; balloonProg+=1}
}
else if balloonProg=5 //-------------------- Kill player --------------------
{
  balloonTime+=1
  if balloonTime=60
  {
    abilSetRemove(0)
    global.bCanGameOver=1
    global.bRecordHits=1
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if balloonProg=0
{
  playSound(global.snd_ComicHit2,0,1,1)
  for(i=0;i<8;i+=1)
  {
    tEffect=instance_create(x,y-8,oEffect)
    tEffect.sprite_index=sMMchargeEffect1; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_speed=0.25
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.speed=3; tEffect.direction=i*45; tEffect.image_angle=i*45
  }
  enemyBarrier=instance_create(80,784,oEnemyBarrier); enemyBarrier.image_yscale=8
  enemyBarrier=instance_create(864,784,oEnemyBarrier); enemyBarrier.image_yscale=8
  oBackgroundFollow.image_blend=make_color_rgb(255,180,180)
  var tGOMess;
  tGOMess=instance_create(0,0,oSituationalGO_Message)
  tGOMess.type=1
  global.canPause=0
  global.bCanGameOver=0
  global.bRecordHits=0
  showEmote(oIdentifier,0,-6,sEmEmbarrass)
  with oExit {instance_destroy()}
  var tempMplay;
  tempMplay=findMusic(0)
  playMusic(tempMplay,0,0)
  balloonProg=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if balloonProg=0
{
  draw_set_alpha(1)
  draw_set_color(c_black)
  draw_line(oMrSaturnLayDown.x-2,oMrSaturnLayDown.y-12,x,y-1)
  draw_sprite_ext(sSaturnBalloon,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
