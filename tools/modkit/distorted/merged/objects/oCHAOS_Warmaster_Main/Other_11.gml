///MAIN FORM
if currentAttack=1 //==================== ATK A: SWORD SWING 1 - (Leads into Atk B) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_SwingAReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4
  {
    image_index=1
    if ATTACK_SPEED>=3 {actTime=5}
  }
  else if actTime=7
  {
    image_index=2
    if ATTACK_SPEED>=3 {actTime=8}
  }
  else if actTime=13 //Strike
  {
    playSound(global.snd_DeathSlash,0,1,28500)
    sprite_index=sWarmasterA_SwingAStrike; image_index=0
    var tAtk;
    tAtk=instance_create(x,y,oWMA_SwordSlash)
    tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale

    tAtk=instance_create(x+(12*scaleForFacing),y-30,oWMA_SwordWave)
    tAtk.atkPower=atkPower; tAtk.warTarget=id
    if image_xscale<0 {tAtk._direction=180; tAtk.image_angle=180}
    if DIFFICULTY=1 {tAtk.moveSpd=5} else {tAtk.moveSpd=10}
    if ATTACK_SPEED>=2 {actTime=14}
  }
  else if actTime=17 {image_index=1}
  else if actTime=19 {image_index=2}
  else if actTime=21
  {
    image_index=3
    with oWMA_SwordSlash {instance_destroy()}
    if ATTACK_SPEED=2 {actTime=22}
    else if ATTACK_SPEED>=3 {actTime=23}
  }
  else if actTime>=28
  {
    actTime=0
    currentAttack=2
  }
}
else if currentAttack=2 //==================== ATK B: SWORD SWING 2 ====================
{
  if actTime=1
  {
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_SwingBReady; image_index=0
    if ATTACK_SPEED>=2 {actTime=2}
  }
  else if actTime=4
  {
    image_index=1
    if ATTACK_SPEED>=2 {actTime=5}
  }
  else if actTime=9 //Strike
  {
    playSound(global.snd_DeathSlash,0,1,30500)
    sprite_index=sWarmasterA_SwingBStrike; image_index=0
    var tAtk,tWaveDir;
    tWaveDir=point_direction(x+(12*scaleForFacing),y-30,oPlayer1.x,returnPlayerYCenter())
    tAtk=instance_create(x,y,oWMA_SwordSlash)
    tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale; tAtk.sprite_index=sWarmasterA_AtkB

    if scaleForFacing=1 //Keep sword wave from going behind
    {
      if tWaveDir>90 and tWaveDir<270 {tWaveDir+=180}
    }
    else
    {
      if tWaveDir>90 and tWaveDir<270 {}
      else {tWaveDir+=180}
    }

    tAtk=instance_create(x+(12*scaleForFacing),y-30,oWMA_SwordWave)
    tAtk.atkPower=atkPower; tAtk._direction=tWaveDir; tAtk.image_angle=tWaveDir; tAtk.warTarget=id
    if DIFFICULTY=1 {tAtk.moveSpd=5} else {tAtk.moveSpd=10}
    if ATTACK_SPEED>=2 {actTime=11}
  }
  else if actTime=17
  {
    image_index=1
    with oWMA_SwordSlash {instance_destroy()}
    if ATTACK_SPEED=2 {actTime=18}
    else if ATTACK_SPEED>=3 {actTime=19}
  }
  else if actTime>=24
  {
    event_user(0)
  }
}
else if currentAttack=3 //==================== ATK C: DASH + JUMP SLASH ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_DashReady; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=10 //Dash
  {
    playSound(global.snd_ChargeStrike,0,0.92,32000)
    sprite_index=sWarmasterA_Dashing
    xVel=dashAcc*scaleForFacing
  }
  else if actTime=22 //Jump
  {
    sprite_index=sWarmasterA_JumpUp
    xVel=dashJumpAcc*scaleForFacing
    y-=2; yVel=-12
  }
  else if actTime=37 //Stop midair
  {
    bGravity=0
    xVel=0; yVel=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_AirSwingA
    if ATTACK_SPEED>=2 {actTime=39}
  }
  else if actTime=47 //Strike down fast
  {
    sprite_index=sWarmasterA_GroundHit
    bGravity=1
    bGoombaStomp=0
    xVel=2*scaleForFacing
    yVel=8
  }
  else if actTime>=106
  {
    event_user(0)
  }
}
else if currentAttack=4 //==================== ATK D: ROPE AND BOMB (Goes into Atk E) ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_Kneel; image_index=0
    if ATTACK_SPEED=2 {actTime=2}
    else if ATTACK_SPEED>=3 {actTime=3}
  }
  else if actTime=8 //Place bomb
  {
    tAtk=instance_create(x,y-7,oWMA_GroundBomb)
    tAtk.atkPower=atkPower; tAtk.warTarget=id
  }
  else if actTime=10 //Spawn rope
  {
    sprite_index=sWarmasterA_GrabKneel
    bRope=1; ropeX=x-(10*image_xscale); ropeYscl=0
    if ATTACK_SPEED>=3 {actTime=13}
  }
  else if actTime=20
  {
    sprite_index=sWarmasterA_GrappleRopeA
    if ATTACK_SPEED>=2 {actTime=21}
  }
  else if actTime=26 //Jump up
  {
    sprite_index=sWarmasterA_JumpUp
    y-=2; yVel=-12
  }
  else if actTime>=27 and actTime<=99 //Grab rope
  {
    if y<=yGround-160+sprite_height-6
    {
      bGravity=0
      sprite_index=sWarmasterA_GrappleRopeB
      if ATTACK_SPEED=2 {actTime=103}
      else if ATTACK_SPEED>=3 {actTime=106}
      else {actTime=100}
    }
  }
  else if actTime>=120
  {
    actTime=0
    currentAttack=5
  }

  //if actTime>=11 and actTime<=20
  if actTime>10 and actTime<=20 //60fps change: covers every frame of ticks 11-20 (the rope only reached 0.95/0.925 of its length at 60/120fps)
  {
    if ATTACK_SPEED>=3 {ropeYscl+=0.2*gDeltaTime}
    else {ropeYscl+=0.1*gDeltaTime}
  }
}
else if currentAttack=5 //==================== ATK E: SWORD ROLL ====================
{
  if actTime=1
  {
    sprite_index=sWarmasterA_SwordRoll; image_index=0
    var tAtk;
    tAtk=instance_create(x,y,oWMA_SwordRoll); tAtk.atkPower=atkPower; tAtk.warTarget=id
    bGravity=1
    var xRollDist;
    xRollDist=point_distance(x,0,oPlayer1.x,0)/20
    if xRollDist>14 {xRollDist=14}
    else if xRollDist<0.75 {xRollDist=0.75}
    if x<oPlayer1.x {xVel=xRollDist; image_xscale=1.25; scaleForFacing=1}
    else {xVel=-xRollDist; image_xscale=-1.25; scaleForFacing=-1}
    yVel=3
  }
  else if actTime=102 {image_index=1}
  else if actTime=104 {image_index=2}
  else if actTime=106 {image_index=3}
  else if actTime>=108
  {
    ropeYscl=0; bRope=0
    if superAtkType=1
    {
      actTime=0
      ATTACK_FORM=4
      event_user(5)
      currentAttack=3
    }
    else if superAtkType=2
    {
      actTime=0
      ATTACK_FORM=2
      event_user(5)
      currentAttack=2
    }
    else {event_user(0)}
  }

  if ropeYscl>0 {ropeYscl-=0.1*gDeltaTime}
}
else if currentAttack=6 //==================== ATK F: BIG LEAP TOWARD WALL + LEAP OFF WALL (Needs charge) ====================
{
  if actTime=1
  {
    tEffect=instance_create(x,y-20,oEffectB)
    tEffect.type=1; tEffect.sprite_index=sWarSpellWave; tEffect.image_alpha=0.8; tEffect.fadeSpd=0; tEffect.image_speed=0.75
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=1; tEffect.followID=-1; tEffect.rotation=0; tEffect.image_alpha=0.66
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x+random_range(-16,16),y-random(4),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
      tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05; tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect.speed=1+random(2); tEffect.fadeSpd=0.02; tEffect.image_blend=make_color_rgb(190,10,190)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    sprite_index=sWarmasterA_BigLeapReady; image_index=0
    if ATTACK_SPEED=2 {actTime=5}
    else if ATTACK_SPEED>=3 {actTime=10}
  }
  else if actTime=18 //Jump toward wall
  {
    playSound(global.snd_ChargeStrike,0,0.92,32000)
    if x<xCenter {image_xscale=-1.25; scaleForFacing=-1}
    else {image_xscale=1.25; scaleForFacing=1}
    sprite_index=sWarmasterA_JumpUp
    xVel=fastDashJumpAcc*scaleForFacing
    y-=2; yVel=-12
  }
  else if actTime=108 //Fire shot
  {
    playSound(global.snd_SpearShot,0,0.98,28000)
    var tNewAttack,tShotDir;
    tShotDir=point_direction(x-(28*image_xscale),y-20,oPlayer1.x,returnPlayerYCenter())
    if DIFFICULTY=1
    {
      tNewAttack=instance_create(x-(28*image_xscale),y-20,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
      tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack._direction=tShotDir; tNewAttack.image_angle=tShotDir
    }
    else
    {
      tShotDir-=10
      for(i=0;i<3;i+=1)
      {
        tNewAttack=instance_create(x-(28*image_xscale),y-20,oPassBullet)
        tNewAttack.sprite_index=sWarmasterA_ShotA; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
        tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack._direction=tShotDir; tNewAttack.image_angle=tShotDir
        tShotDir+=10
      }
    }
    if ATTACK_SPEED>=2 {actTime=111}
  }
  else if actTime=116 //Jump off wall
  {
    bGravity=1
    if x<xCenter {x+=2; xVel=fastDashJumpAcc}
    else {x-=2; xVel=-fastDashJumpAcc}
    yVel=-4
    sprite_index=sWarmasterA_JumpUp
  }
  else if actTime=132 //Stop midair
  {
    bGravity=0
    xVel=0; yVel=0
    if x<oPlayer1.x {image_xscale=1.25; scaleForFacing=1}
    else {image_xscale=-1.25; scaleForFacing=-1}
    sprite_index=sWarmasterA_MidairCall
    var tEffect;
    tEffect=instance_create(x+(17*image_xscale),y-(27*image_yscale),oEffect)
    tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if ATTACK_SPEED>=2 {actTime=134}
  }
  else if actTime=137 //Spear shots down
  {
    playSound(global.snd_SpearShot,0,1,19000)
    var tNewAttack;
    for(i=0;i<8;i+=1)
    {
      tNewAttack=instance_create(200+(48*i),0,oPassBullet)
      tNewAttack.sprite_index=sWarmasterA_ShotB; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
      tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33; tNewAttack._direction=270; tNewAttack.image_angle=270
    }
    tNewAttack=instance_create(168,0,oPassBullet)
    tNewAttack.sprite_index=sWarmasterA_ShotB; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
    tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33; tNewAttack._direction=270; tNewAttack.image_angle=270
    tNewAttack=instance_create(568,0,oPassBullet)
    tNewAttack.sprite_index=sWarmasterA_ShotB; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
    tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33; tNewAttack._direction=270; tNewAttack.image_angle=270

    tNewAttack=instance_create(oPlayer1.x,0,oPassBullet)
    with tNewAttack
    {
      sprite_index=sWarmasterA_ShotB; atkPower=oCHAOS_Warmaster_Main.atkPower; bulletSpeed=12
      decayTime=-100; image_speed=0.33; _direction=270; tNewAttack.image_angle=270
      move_snap(8,1)
    }
    if ATTACK_SPEED=2 {actTime=139}
    else if ATTACK_SPEED>=3 {actTime=140}
  }
  else if actTime=143
  {
    sprite_index=sWarmasterA_JumpDown
    yVel=4
    bGravity=1
  }
  else if actTime>=150
  {
    event_user(0)
  }
}
else if currentAttack=100 //==================== EX SWORD BEAM ==================== spsp ns
{
  //EX MODE
  {
    if actTime=1
    {
      image_index=0
      var tEffect;
      tEffect=instance_create(x,y-24,oEffect)
      tEffect.sprite_index=sCWM_Ef_ChargeUp; tEffect.image_speed=0.45; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.newBlend=-1; tEffect.followID=id; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.xFollow=0; tEffect.yFollow=-26
      if x<oPlayer1.x
      {
        image_xscale=1.25; scaleForFacing=1
        if x>xCenter {sprite_index=sWarmasterA_SwingAReady; actTime=2} //Dash back
        else {sprite_index=sWarmasterA_SwingBReady} //Blink dash forward
      }
      else
      {
        image_xscale=-1.25; scaleForFacing=-1
        if x<xCenter {sprite_index=sWarmasterA_SwingAReady; actTime=2} //Dash back
        else {sprite_index=sWarmasterA_SwingBReady} //Blink dash forward
      }
    }
    else if actTime=3
    {
      if EX_DROPDASH=2 {actTime=10} //what does this do?
    }
    else if actTime=19
    {
      if sprite_index=sWarmasterA_SwingBReady //Blink dash forward
      {
        sprite_index=sWarmasterA_SwingBStrike
        x+=128*scaleForFacing
        if x>xCenter+roomSpan {x=xCenter+roomSpan-16}
        if x<xCenter-roomSpan {x=xCenter-roomSpan+16}
        actTime=100
      }
      else //Dash back
      {
        xVel=superFireDashAcc*-scaleForFacing
        actTime=40
      }
    }
    else if actTime=41
    {
      if EX_DROPDASH=2 {actTime=42} //what does this do?
    }
    else if actTime=45 //Strike
    {
      xVel=0
      playSound(global.snd_DeathSlash,0,1,28500)
      sprite_index=sWarmasterA_SwingAStrike; image_index=0
      var tAtk;
      tAtk=instance_create(x,y,oWMA_SwordSlash)
      tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(x+(12*scaleForFacing),y-30-(30*i),oWMA_EX_SwordWave)
        tAtk.atkPower=atkPower
        //if image_xscale<0 {tAtk.direction=180; tAtk.image_angle=180}
        if image_xscale<0 {tAtk._direction=180; tAtk.image_angle=180} //60fps change: DT3+'s sword wave moves by its own _direction
      }
    }
    else if actTime=47 {image_index=1}
    else if actTime=49 {image_index=2}
    else if actTime=51
    {
      image_index=3
      with oWMA_SwordSlash {instance_destroy()}
      if EX_DROPDASH=2 {actTime=52}
    }
    else if actTime=53
    {
      if EX_SWORDSWING=1 //Swing again
      {
        sprite_index=sWarmasterA_SwingAReady
        EX_SWORDSWING=2
        actTime=39
      }
      else
      {
        EX_SWORDSWING=3
        actTime=200
      }
    }
    else if actTime=101
    {
      playSound(global.snd_DeathSlash,0,1,30500)
      sprite_index=sWarmasterA_SwingBStrike; image_index=0
      
      tAtk=instance_create(x-(64*scaleForFacing),y-7,oWMA_GroundBomb)
      tAtk.atkPower=atkPower; tAtk.warTarget=id
      
      var tAtk,tWaveDir;
      tWaveDir=point_direction(x+(12*scaleForFacing),y-30,oPlayer1.x,returnPlayerYCenter())
      tAtk=instance_create(x,y,oWMA_SwordSlash)
      tAtk.atkPower=atkPower; tAtk.image_xscale=image_xscale; tAtk.image_yscale=image_yscale; tAtk.sprite_index=sWarmasterA_AtkB
    }
    else if actTime=108
    {
      image_index=1
      with oWMA_SwordSlash {instance_destroy()}
      actTime=200
    }
    
    if actTime>=202
    {
      if EX_DROPDASH=2 {EX_DROPDASH=0}
      EX_SWORDSWING=0
      event_user(0)
    }
    
    //if actTime>=20 and actTime<=26 and EX_SWORDSWING=1 {instance_create(x,y,oWMA_EX_DashImage)} //Dash back effect
    if actTime>=20 and actTime<=26 and EX_SWORDSWING=1 and gDeltaDoTicks {instance_create(x,y,oWMA_EX_DashImage)} //Dash back effect //60fps change: once per tick (as DT3+'s EX Warmaster)
  }
}
