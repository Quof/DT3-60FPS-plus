//Evil Boss Gallery: Evil Dead Hand's evil moves (its Step runs this in its own step's place while evgMove isn't 0;
//stage 0 is a move's first frame). Each leaves its own cycle where it should go on (atkSequence, atkTime)
evgT+=1*gDeltaTime
var tEffect,tXspd;
if evgMove=1 //---------- CLAW WAVE ----------
{
  if evgStage=0
  {
    image_index=1
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}
    playSound(global.snd_Earthquake,0,1,30000)
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(the rumble at its feet, 16 ticks)
  {
    if gDeltaDoTicks
    {
      tXspd=random_range(-2,2)
      tEffect=instance_create(x+random_range(-24,24),yGround+random_range(-2,3),oEffectGrav)
      tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
      tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
    }
    if evgT>=16
    {
      playSound(global.snd_HardHit2,0,0.9,1)
      var tW;
      tW=instance_create(x-16,yGround,oEvgClawWave); tW.dir=-1; tW.atkPower=atkPower; tW.xMin=xCenter-roomSpan; tW.xMax=xCenter+roomSpan
      tW=instance_create(x+16,yGround,oEvgClawWave); tW.dir=1; tW.atkPower=atkPower; tW.xMin=xCenter-roomSpan; tW.xMax=xCenter+roomSpan
      if bossProgress>=3
      {
        tW=instance_create(x-16,yGround,oEvgClawWave); tW.dir=-1; tW.spd=3.5; tW.atkPower=atkPower; tW.xMin=xCenter-roomSpan; tW.xMax=xCenter+roomSpan
        tW=instance_create(x+16,yGround,oEvgClawWave); tW.dir=1; tW.spd=3.5; tW.atkPower=atkPower; tW.xMin=xCenter-roomSpan; tW.xMax=xCenter+roomSpan
      }
      evgStage=2
      evgT=0
    }
  }
  else if evgT>=14
  {
    image_index=0
    atkTime=0
    evgMove=0
  }
}
else if evgMove=2 //---------- AMBUSH ----------
{
  if evgStage=0
  {
    visible=0
    bCanDealDamage=false; bCanTakeDamage=false
    ambX=median(xCenter-roomSpan+16,oPlayer1.x,xCenter+roomSpan-16)
    playSound(global.snd_Earthquake,0,1,60000)
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(the floor rumbles under where the player was, 24 ticks)
  {
    if gDeltaDoTicks
    {
      tEffect=instance_create(ambX+random_range(-16,16),yGround+random_range(-2,3),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if evgT>=24
    {
      playSound(global.snd_Earthquake,0,1,88200)
      x=ambX
      y=yGround
      visible=1
      sprite_index=sDeadHand_Jump
      image_speed=0.33
      if bPoeActive=0 {resType[0]=4}
      for(i=0;i<8;i+=1)
      {
        tXspd=random_range(-2,2)
        tEffect=instance_create(x+random_range(-13,13),yGround+random_range(-2,3),oEffectGrav)
        tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
        tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
      }
      ySpd=-9
      bCanDealDamage=true
      bCanTakeDamage=true
      evgStage=2
      evgT=0
    }
  }
  else if evgStage=2 //(up and back down, as the game's jump)
  {
    if ySpd<-2 {ySpd=scrGravAcc(ySpd,0.2,1)}
    else if ySpd<8 {ySpd=scrGravAcc(ySpd,0.4,1)}
    y+=ySpd*gDeltaTime
    if y>=yGround and ySpd>0
    {
      sprite_index=sDeadHand_Idle
      image_speed=0; image_index=0
      if bPoeActive=0 {resType[0]=3}
      y=yGround
      atkTime=0
      atkSequence=2
      evgPrev=2
      evgMove=0
    }
  }
}
else if evgMove=3 //---------- GRAVEBOUND ----------
{
  if evgStage=0 and bPoeActive=1 {evgMove=0; exit} //(not once the Poe has come: it can't be hurt then anyway)
  if evgStage=0
  {
    bCanDealDamage=false
    for(i=0;i<6;i+=1) {resType[i]=1}
    resType[4]=3
    graveHands=0
    evgStage=1
    evgT=0
  }
  else if evgStage=1 //(down to its head)
  {
    if gDeltaDoTicks
    {
      tEffect=instance_create(x-8+random_range(-15,15),yGround+random_range(-3,15),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    y+=0.5*gDeltaTime
    if y>=yGround+18
    {
      y=yGround+18
      evgStage=2
      evgT=0
    }
  }
  else if evgStage=2 //(buried: bombs only; hands come faster; 200 ticks)
  {
    if evgT>=graveHands*45+20 and instance_number(oGrabbingHand)<maxHands+2
    {
      var tHand;
      tHand=instance_create(median(xCenter-roomSpan+24,oPlayer1.x+((graveHands mod 2)*2-1)*40,xCenter+roomSpan-24),yGround+25,oGrabbingHand)
      tHand.timeout=handTimeout
      graveHands+=1
    }
    if collision_rectangle(x-18,y-34,x+18,y,oLinkBExplosion,0,1)!=noone
    {
      playSound(global.snd_PotShatter,0,1,1)
      y=yGround
      sprite_index=sDeadHand_Jump; image_speed=0; image_index=1
      for(i=0;i<6;i+=1) {resType[i]=4}
      bCanTakeDamage=true
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_blend=make_color_rgb(255,240,200); tFlash.image_alpha=0.35; tFlash.fadeSpeed=0.05
      evgStage=3
      evgT=0
    }
    else if evgT>=200
    {
      for(i=0;i<6;i+=1) {resType[i]=3}
      atkTime=0
      atkSequence=4
      evgPrev=4
      evgMove=0
    }
  }
  else if evgStage=3 //(yanked out: stunned, 75 ticks, everything double)
  {
    if evgT>=75
    {
      sprite_index=sDeadHand_Idle; image_index=0
      for(i=0;i<6;i+=1) {resType[i]=3}
      atkTime=0
      atkSequence=4
      evgPrev=4
      evgMove=0
    }
  }
}
else {evgMove=0}
