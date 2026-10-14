if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    jeremyText="N/A"
    chaoText="There's a weird thing masking some of its defensive data, but its offensive capabilities look to be wide open for me to read. It has two danmaku like attacks, some sort of scatter-missile attack that then burst into... ugh, homing missiles. Use bombs to blow those away. Oh yeah, dodge the big laser."
    devText="Prepare yourself for quite the fight. This boss probably took the longest to make of any boss fight I've ever made."
    activateBoss=2
    if true {bossTime=0; bossTick=1} //spsp
  }
  else if activateBoss=2 and true     //spsp
  {
    //bossTime+=1
    bossTime+=1*gDeltaTime //60fps change: per frame
    if bossTime=50
    {
        //newMet=instance_create(x,room_height-16,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3; newMet.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)
        newMet=instance_create(x,room_height-16,oSkyfallMeteor); newMet.bBlue=1; newMet.moveSpd=3; newMet._direction=point_direction(x,y,oPlayer1.x,oPlayer1.y) //60fps change: DT3+'s meteor moves by its own _direction
        bossTime=0
    }
    /*if bossTime mod round(100/(bossTick+1))=0
    {
        playSound(global.snd_CShotB,0,0.95,1)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPointExpBullet)
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7
        tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    }*/
    //if life>0 and bActive=true
    if life>0 and bActive=true and gDeltaDoTicks //60fps change: the three fire streams once per 30fps tick (every frame, they were 2x/4x as thick)
    {
        /*playSound(global.snd_CShotB,0,0.95,1)
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPointExpBullet)
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7
        tNewAttack.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())*/

        var myAtk;
        myFireDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
        playSound(global.snd_Fireball,0,0.9,32000)
        myAtk=instance_create(x,y,oTOTO_FireB)
        myAtk.atkType=0; myAtk.atkPower=atkPower
        //myAtk.mySpd=12; myAtk.direction=myFireDir
        myAtk.mySpd=12; myAtk._direction=myFireDir //60fps change: DT3+'s oTOTO_FireB moves by its own _direction
        
        myAtk=instance_create(x,y,oTOTO_FireB)
        myAtk.atkType=0; myAtk.atkPower=atkPower
        //myAtk.mySpd=12; myAtk.direction=myFireDir+35
        myAtk.mySpd=12; myAtk._direction=myFireDir+35 //60fps change: DT3+'s oTOTO_FireB moves by its own _direction
        
        myAtk=instance_create(x,y,oTOTO_FireB)
        myAtk.atkType=0; myAtk.atkPower=atkPower
        //myAtk.mySpd=12; myAtk.direction=myFireDir-35
        myAtk.mySpd=12; myAtk._direction=myFireDir-35 //60fps change: DT3+'s oTOTO_FireB moves by its own _direction
    }
    /*else if bossTime>=60
    {
        bossTime=0
    }*/
  }
  if bActive=true and life>0
  {
    if bossPhase=0 and gDeltaDoTicks
    {
      y-=2
      if y<=room_height
      {
        bCanTakeDamage=1
        bossPhase=1
      }
    }
  }
  enemyStepEvent()
}

if life<=0 //Defeat animation
{
  deathAnim+=1*gDeltaTime
  if deathAnim>=1 and deathAnim<=60
  {
    if deathAnim mod 3=0 {playSound(global.snd_BombExplode,0,0.92,1)}
    //if oGame.time mod 2=0
    if oGame.time mod (2/gDeltaTime)=0 //60fps change: oGame.time counts frames, so this made 2x/4x the explosions at 60/120fps
    {
      var tEffect;
      tEffect=instance_create(x+random_range(-sprite_width,sprite_width),y+random_range(-sprite_height,sprite_height),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
  else if deathAnim=61
  {
    playSound(global.snd_BombExplode,0,0.98,11025)
    var tEffect;
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x-52+(i*52),y-(sprite_height/2),oEffect)
      tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.25; tEffect.image_xscale=2.5; tEffect.image_yscale=2.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    oEvCh21Falling.sceneDelay=1
    instance_destroy()
  }
}
