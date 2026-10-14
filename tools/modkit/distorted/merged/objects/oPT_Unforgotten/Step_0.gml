if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    jeremyText="Putting all meta-jokes aside, this guy can be pretty tough. He cycles through 5 different movement sets. During each, he will cycle between 1 of 3 different attacks. During his escape out of each movement set, he will begin to shake. Move out of the way when he does that. You can't parry when he flies through the arena. Do note that when he glows red, Claire can parry that attack."
    chaoText="This thing is from a Sega Genesis game called 'Beyond Oasis', and known as 'Story of Thor' in Japan."
    devText="This has been a highly requested enemy ever since there was a screenshot of it in DT1. It was originally planned to be a boss fight upon immediate arrival in the first Distortion level, but was cut very early on. I didn't want a boss fight immediately after Meta Knight and I couldn't come up with anything very interesting for it."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //spsp ns
    //if global.stJGame_C[0]>4000 {life-=30} //maxLife is 21000
    if global.stJGame_C[0]>4000 and gDeltaDoTicks {life-=30} //maxLife is 21000. 60fps change: once per 30fps tick, in whole points
    
    waitTime+=1*gDeltaTime
    if waitTime>=5 and flythrough<=1
    {
      event_user(0) //Movement cycles
      event_user(1) //Attack cycles
    }
    else if flythrough>=2 //Fly through arena
    {
      flythrough+=1*gDeltaTime
      //if flythrough>=6 and flythrough<=30
      if flythrough>5 and flythrough<=30 //60fps change: covers every frame of ticks 6-30
      {
        //if flythrough mod (2*gDeltaTime)=0 {y+=2} else {y-=2}
        if frac(flythrough)=0 {if flythrough mod 2=0 {y+=2} else {y-=2}} //60fps change: one 2px shake per 30fps tick, alternating like at 30fps; the old check shook 2px every frame (4x as fast at 120fps)
      }
      else if flythrough>=31 and flythrough<=200
      {
        if moveCycle=1 {x-=12*gDeltaTime}
        else if moveCycle=2 {x+=12*gDeltaTime; y-=9.6*gDeltaTime}
        else if moveCycle=3 {x-=12*gDeltaTime; y-=9.6*gDeltaTime}
        else if moveCycle=4 {x+=12*gDeltaTime}
        else if moveCycle=5 {y+=12*gDeltaTime}
        if x<=-312 or x>=room_width+312 or y<=-312 or y>=room_height+312 {flythrough=200}
      }
      else if flythrough>=205
      {
        moveTime=0
        image_angle=0
        moveCycle+=1
        if moveCycle=6 {moveCycle=1}
        flythrough=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if true and bossProgress=0       // spinach special
    {
      moveSpd+=5
      maxSpawn+=2
      bossProgress+=3
    }
    if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
    {
      moveSpd+=2
      maxSpawn+=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.26 and bossProgress=1
    {
      maxSpawn+=1
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=2
    {
      moveSpd+=2
      bossProgress+=1
    }
  }
  else if life<=0
  {
    //deathAnim+=1
    deathAnim+=1*gDeltaTime //60fps change: was never scaled (the death sound, every 8 ticks, played 4x as often at 120fps)
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      with oPT_ForgottenSpawn {instance_destroy()}
    }

    if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
    if gDeltaDoTicks {tEffect=instance_create(x+random_range(-300,100),y+random_range(-72,72),oEffect)
    tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
    tEffect.image_alpha=0.5+(image_alpha/3)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0}
    image_alpha-=0.02*gDeltaTime
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(44)
        global.newMapX=2152; global.newMapY=528; room_goto(rBossGallery)
      }
      else
      {
        oEvCh15MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
