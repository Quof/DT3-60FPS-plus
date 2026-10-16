//Evil Boss Gallery: Evil Death's evil moves, run by his Step in his duel's place while evgMove isn't 0 (stage 0 is a
//move's first frame)
evgT+=1*gDeltaTime
if evgMove=1 //---------- SICKLE STORM: sickles circle above him, then fly at the player one by one ----------
{
  if evgStage=0
  {
    sprite_index=sEvgDeathReadyC
    if x>oPlayer1.x {image_xscale=-1}
    else {image_xscale=1}
    playSound(global.snd_FadeAway,0,0.96,12000)
    evgStage=1; evgT=0
  }
  else
  {
    if gDeltaDoTicks
    {
      var tEffect;
      tEffect=instance_create(x-24+random(48),yGround-100-random(24),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8; tEffect.image_blend=make_color_rgb(170,60,200)
      tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05
      tEffect.speed=1+random(2); tEffect.fadeSpd=0.03
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    if evgT>=24
    {
      playSound(global.snd_OrbThrow,0,0.9,22050)
      var k,tSickle;
      for(k=0;k<sickleNum;k+=1)
      {
        tSickle=instance_create(x,yGround-112,oEvgSickle)
        tSickle.owner=id
        tSickle.ang=k*(360/sickleNum)
        tSickle.launchT=36+(k*sickleGap)
        tSickle.atkPower=atkPower
      }
      sprite_index=sEvgDeathWalk
      evgMove=0
    }
  }
}
else if evgMove=2 //---------- PHANTOM RUSH: he fades out, phantoms tear across the arena, he fades back in ----------
{
  if evgStage=0
  {
    sprite_index=sEvgDeathWalk
    playSound(global.snd_Teleport,0,0.9,1)
    myHS.bCanTakeDamage=false
    bCanDealDamage=false
    if oPlayer1.x>room_width/2 {rushSide=1} //the first from the far side of the player, then each from the other side
    else {rushSide=-1}
    rushNum=0
    if random(10)>6
    {
      var newMessage;
      newMessage=instance_create(x-46,y-114,oEnemyChat)
      newMessage.enemyMessage="Can you see me?"
    }
    evgStage=1; evgT=0
  }
  else if evgStage=1 //fading out
  {
    fadeA=1-0.8*min(1,evgT/12)
    if evgT>=12 {evgStage=2; evgT=0; evgNext=0}
  }
  else if evgStage=2 //the phantoms, 30 ticks apart, low (L) and high (H) in his phase's order (rushPat)
  {
    var tPat;
    tPat=rushPat[min(bossProgress,5)]
    if evgT>=evgNext and rushNum<string_length(tPat)
    {
      playSound(global.snd_DashWarn,0,0.9,1)
      var tPh;
      tPh=instance_create(0,0,oEvgPhantom)
      tPh.dir=rushSide
      if rushSide=1 {tPh.x=-72}
      else {tPh.x=room_width+44}
      if string_char_at(tPat,rushNum+1)="H" {tPh.high=1; tPh.y=yGround-100}
      else {tPh.high=0; tPh.y=yGround-48}
      tPh.atkPower=atkPower
      rushSide*=-1
      rushNum+=1
      evgNext+=30
    }
    if rushNum>=string_length(tPat) and !instance_exists(oEvgPhantom) {evgStage=3; evgT=0}
  }
  else //fading back in
  {
    fadeA=0.2+0.8*min(1,evgT/12)
    if evgT>=12
    {
      fadeA=1
      myHS.bCanTakeDamage=true
      bCanDealDamage=true
      evgMove=0
    }
  }
}
else if evgMove=3 //---------- SOUL SIPHON: a vortex pulls the player in, then he reaps all round him ----------
{
  if evgStage=0
  {
    sprite_index=sEvgDeathBlock
    if x>oPlayer1.x {image_xscale=-1}
    else {image_xscale=1}
    playSound(global.snd_KirbySuck,0,0.9,14000)
    siphon=instance_create(x,y-40,oEvgSiphon)
    siphon.owner=id
    if random(10)>6
    {
      var newMessage;
      newMessage=instance_create(x-46,y-114,oEnemyChat)
      newMessage.enemyMessage="Come closer."
    }
    evgStage=1; evgT=0
  }
  else if evgStage=1 //the pull: like Gate 6's strongest wind by the end, and holy water breaks it
  {
    var tPull;
    tPull=1+0.85*min(1,evgT/60)
    if instance_exists(siphon) {siphon.str=min(1,evgT/30)}
    if abs(oPlayer1.x-x)>6 {oPlayer1.extForceX=-sign(oPlayer1.x-x)*tPull}
    if evgT=66 {playSound(global.snd_DashWarn,0,1,1)}
    if collision_rectangle(x-40,y-100,x+40,y,oBelmontHWExplosion,0,1)!=noone {event_user(4)}
    else if evgT>=90 //the reap: Death's spin, huge
    {
      playSound(global.snd_DeathSlash,0,1,18000)
      sprite_index=sEvgDeathSwingA
      var newAtk;
      newAtk=instance_create(x,y-26,oDeathScytheAtk)
      newAtk.sprite_index=sEvgDeathScytheSlashA
      newAtk.atkPower=atkPower; newAtk.decay=10; newAtk.atkSpd=0.25
      newAtk.image_xscale=2.3*image_xscale; newAtk.image_yscale=2.3
      newAtk=instance_create(x,y-26,oDeathScytheAtk)
      newAtk.sprite_index=sEvgDeathScytheSlashA
      newAtk.atkPower=atkPower; newAtk.decay=10; newAtk.atkSpd=0.25
      newAtk.image_xscale=1.4*image_xscale; newAtk.image_yscale=1.4
      with (siphon) {instance_destroy()}
      siphon=noone
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_blend=make_color_rgb(150,20,50); tFlash.image_alpha=0.4; tFlash.fadeSpeed=0.05
      evgStage=2; evgT=0
    }
  }
  else //recovering
  {
    if evgT>=24
    {
      sprite_index=sEvgDeathWalk
      evgMove=0
    }
  }
}
else {evgMove=0}
