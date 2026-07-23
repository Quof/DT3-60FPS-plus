#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
solidIsNearPlayers=0
makeActive()
image_xscale=2; image_yscale=2

sequence=0
seqTime=0
damageTaken=0
jawAng=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sequence=0 //Init
  {
    playSound(global.snd_DemonVoice1,0,1,13000)
    var tEffect;
    for(i=0;i<60;i+=1)
    {
      tEffect=instance_create(oPlayer1.x+random_range(-128,128),1968+random(48),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(3)
      tEffect.image_xscale=choose(-1,1); tEffect.image_yscale=choose(-1,1)
      tEffect.image_blend=make_color_rgb(180,180+random(75),180)
    }
    oPlayer1.yVelLimit=20
    yVel=-13
    sequence+=1
  }
  else if sequence=1 //Boost player
  {
    tEffect=instance_create(oPlayer1.x+random_range(-3,3),oPlayer1.y-4-random(4),oEffect)
    tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.4
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(3)
    tEffect.image_xscale=choose(-1,1); tEffect.image_yscale=choose(-1,1)
    tEffect.image_blend=make_color_rgb(180,180+random(75),180)

    oPlayer1.yVel=-20
    seqTime+=1
    if seqTime>=82
    {
      yVel=0
      y=room_height
      seqTime=0; sequence+=1
    }
  }
  else if sequence=2 //Check if player misses the right ledge
  {
    if oPlayer1.y>=832
    {
      x=oPlayer1.x
      y=oPlayer1.y+336
      yVel=-2
      seqTime=0; sequence+=1
    }
  }
  else if sequence=3 //Eat player
  {
    jawAng+=6
    if jawAng>=90
    {
      oPlayer1.life-=oPlayer1.maxLife
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sAbom_Jaw,image_index,x+4,y-190,image_xscale*0.95,image_yscale*0.95,jawAng,image_blend,image_alpha)
draw_sprite_ext(sAbom_Jaw,image_index,x-4,y-190,-image_xscale*0.95,image_yscale*0.95,-jawAng,image_blend,image_alpha)

draw_sprite_ext(sAbom_BallEye,image_index,x+164,y-144,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sAbom_BallEye,image_index,x-164,y-144,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
