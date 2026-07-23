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
bCameraMove=0
flashSprite=0
spawnTime=0
spawnDelay=1000000
spikeScale=0
deathCheck=0
distToPlayer=0
yArmAdj=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  distToPlayer=point_distance(0,y-224,0,oPlayer1.y)
  if sequence=0 //Init
  {
    playSound(global.snd_DemonVoice1,0,1,17000)

    var tCamera;
    tCamera=instance_create(784,oPlayer1.y,oGameCamera); tCamera.type=3; tCamera.axisFollow=784
    sideWall=instance_create(528,0,oInvisibleSolid); sideWall.image_yscale=256
    oGameCamera.shakeAmp=3; oGameCamera.shakeTime=330
    yVel=-1
    sequence+=1
  }
  else if sequence=1 //Rise up
  {
    var tEffect;
    tEffect=instance_create(x+random_range(-168,168),room_height-2,oEffectB)
    tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
    tEffect.direction=random_range(1,179); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0

    if y<=3968 {sequence+=1}
  }
  else if sequence=2 //Grow spikes
  {
    seqTime+=1
    if seqTime=10
    {
      var tCharActive;
      if global.activeCharacter=0 {tCharActive="Jerry"} else {tCharActive="Claire"}
      msgCreate(0,0,"Jeremy",string("Ooh man. ") +string(tCharActive) +string(", get off that thing as soon as you can!"),0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if seqTime=150 {spikeScale=0.1}
    else if seqTime=160
    {
      for(i=0;i<3;i+=1)
      {
        myDmgBox[i]=instance_create(x,y,oTempTrap)
        myDmgBox[i].sprite_index=sprite_index; myDmgBox[i].visible=0; myDmgBox[i].atkPower=12
        myDmgBox[i].image_xscale=2.05; myDmgBox[i].image_yscale=2.05
      }
      seqTime=0; sequence+=1
    }
  }
  else if sequence=3 //Spawn claws
  {
    if oPlayer1.y<=2512
    {
      playSound(global.snd_DemonVoice1,0,1,28000)
      myClawL=instance_create(x-124,y-192,oVAbom_P2_Claw)
      myClawR=instance_create(x+124,y-192,oVAbom_P2_Claw)
      seqTime=0; sequence+=1
    }
  }
  else if sequence=4 //Spawn spawns
  {
    if oPlayer1.y<=1200
    {
      playSound(global.snd_DemonVoice1,0,1,31000)
      spawnDelay=210
      seqTime=0; sequence+=1
    }
  }
  else if sequence=5 //Stop at top
  {
    if y<=544
    {
      playSound(global.snd_DemonVoice1,0,1,31000)
      spawnDelay=1000000
      yVel=0
      seqTime=0; sequence+=1
    }
  }

  //-- Continual effects --
  if sequence>=3 //Damage box / Speed adapt
  {
    myDmgBox[0].x=x; myDmgBox[0].y=y; myDmgBox[0].image_angle=image_angle
    myDmgBox[1].x=x-28; myDmgBox[1].y=y; myDmgBox[1].image_angle=image_angle
    myDmgBox[2].x=x+28; myDmgBox[2].y=y; myDmgBox[2].image_angle=image_angle

    if sequence<6
    {
      if distToPlayer<400 {yVel=-1}
      else {yVel=-2}
    }
  }
  if oGame.time mod 2=0 //Dust effect
  {
    if distToPlayer<272
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-140,140),y-144+random(96),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.4; tEffect.image_xscale=choose(-1,1)
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(3)
      tEffect.image_blend=make_color_rgb(180,180+random(75),180)
    }
    if distToPlayer<160
    {
      var tEffect;
      for(i=0;i<2;i+=1)
      {
        tEffect=instance_create(x+random_range(-192,192),y-16+random(80),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.followID=-1; tEffect.image_speed=0.4
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(4)
        tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
        tEffect.image_blend=make_color_rgb(180,180+random(75),180)
      }
    }
  }
  if instance_exists(oVAbom_P2_Claw) //Claw follow arm
  {
    myClawL.x=x-124; myClawL.y=y-192
    myClawR.x=x+124; myClawR.y=y-192
  }
  spawnTime+=1
  if spawnTime>=spawnDelay and instance_number(oAbomSpawn)<2
  {
    instance_create(x,y-96,oAbomSpawn)
    spawnTime=0
  }

  if solidIsNearPlayers=1 //Kill player if crushed
  {
    if mstYPrev=y and yVel!=0
    {
      deathCheck+=1
      if deathCheck>=3 {oPlayer1.life-=oPlayer1.maxLife}
    }
    else {deathCheck=0}
  }
  if y<oPlayer1.y-52 {oPlayer1.life-=oPlayer1.maxLife} //Kill player if falling below Abomination
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if spikeScale>0
{
  if spikeScale<2 {spikeScale+=0.05}
  draw_sprite_ext(sAbom_Spike,0,x-156,y-54,spikeScale,spikeScale,image_angle+155,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-144,y-139,spikeScale,spikeScale,image_angle+135,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-142,y-214,spikeScale,spikeScale,image_angle+130,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-131,y-282,spikeScale,spikeScale,image_angle+125,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-114,y-308,spikeScale,spikeScale,image_angle+65,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-115,y-253,spikeScale,spikeScale,image_angle+40,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-87,y-195,spikeScale,spikeScale,image_angle+75,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-30,y-194,spikeScale,spikeScale,image_angle+100,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x-20,y-213,spikeScale,spikeScale,image_angle+70,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+29,y-192,spikeScale,spikeScale,image_angle+85,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+87,y-184,spikeScale,spikeScale,image_angle+115,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+117,y-229,spikeScale,spikeScale,image_angle+125,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+117,y-270,spikeScale,spikeScale,image_angle+90,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+142,y-267,spikeScale,spikeScale,image_angle+65,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+138,y-204,spikeScale,spikeScale,image_angle+50,image_blend,image_alpha)
  draw_sprite_ext(sAbom_Spike,0,x+141,y-91,spikeScale,spikeScale,image_angle+30,image_blend,image_alpha)
}

/*draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(view_xview[0]+16,view_yview[0]+96,damageTaken)
