#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
image_alpha=0
image_xscale=2; image_yscale=2

sequence=0
seqTime=0
phaseIn=0
damageTaken=0
shotTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sequence=0 //Fade in / start music
  {
    if phaseIn>=1 {phaseIn+=1}
    if phaseIn>=2 and phaseIn<=7 {image_alpha+=0.05}
    else if phaseIn>=9 and phaseIn<=14 {image_alpha-=0.05}
    else if phaseIn>=40 {phaseIn=0}

    if oPlayer1.x>=912
    {
      collisionL=instance_create(x-120,0,oInvisibleSolid); collisionL.image_yscale=22
      collisionR=instance_create(x+124,0,oInvisibleSolid); collisionR.image_yscale=22
      for(i=0;i<4;i+=1)
      {
        bossArmL[i]=instance_create(x-114,y-266-(i*16),oVAbom_P1_Arm)
        bossArmL[i].waveOffset=i*0.41; bossArmL[i].image_alpha=0
        bossArmR[i]=instance_create(x+130,y-266-(i*16),oVAbom_P1_Arm)
        bossArmR[i].waveOffset=i*0.43; bossArmR[i].image_alpha=0
      }
      var tEffect;
      for(i=0;i<24;i+=1)
      {
        tEffect=instance_create(x-112+random_range(-48,48),y-286+random_range(-48,48),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.followID=-1; tEffect.image_blend=make_color_rgb(88,80,24)
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.25
        tEffect=instance_create(x+130+random_range(-48,48),y-286+random_range(-48,48),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.followID=-1; tEffect.image_blend=make_color_rgb(88,80,24)
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.25
      }
      with oAntiDashField {instance_destroy()}
      playSound(global.snd_DemonVoice1,0,1,1)
      var tempMplay;
      tempMplay=findMusic(814)
      playMusic(tempMplay,0,0)
      sequence+=1
    }
  }
  else if sequence=1 //Spawn arms
  {
    if image_alpha<=1
    {
      image_alpha+=0.025
      for(i=0;i<4;i+=1) {bossArmL[i].image_alpha+=0.025; bossArmR[i].image_alpha+=0.025}
    }
    for(i=0;i<4;i+=1)
    {
      bossArmL[i].y-=0.25+(i*0.25)
      bossArmR[i].y-=0.25+(i*0.25)
    }
    seqTime+=1
    if seqTime>=90
    {
      image_alpha=1
      for(i=0;i<4;i+=1) {bossArmL[i].image_alpha=1; bossArmR[i].image_alpha=1}
      seqTime=3
      sequence+=1
    }
  }
  else if sequence=2 //Damage threshold 1
  {
    if damageTaken>=1400 {playSound(global.snd_DemonVoice1,0,1,1); damageTaken=0; sequence+=1}
  }
  else if sequence=3 //Wait time
  {
    shotTime+=1
    if shotTime>=45
    {
      shotTime=0
      damageTaken=0
      sequence+=1
    }
  }
  else if sequence=4 //Damage threshold 2
  {
    shotTime+=1
    if shotTime>=44
    {
      var tNewAttack;
      tNewAtk=instance_create(oPlayer1.x,room_height+16,oPassBullet)
      tNewAtk.sprite_index=sAbomProjectileA; tNewAtk.atkPower=9; tNewAtk.bulletSpeed=2.75
      tNewAtk.decayTime=-100; tNewAtk.image_xscale=2; tNewAtk.image_yscale=2; tNewAtk.direction=90
      shotTime=0
    }

    if damageTaken>=7500
    {
      playSound(global.snd_DemonVoice1,0,1,1)
      with collisionL {instance_destroy()}
      with collisionR {instance_destroy()}
      yVel=2
      damageTaken=0; shotTime=0; sequence+=1
    }
  }
  else if sequence=5 //Despawn arms and drop down
  {
    shotTime+=1
    if shotTime=30 and instance_exists(oVAbom_P1_Arm)
    {
      var tEffect;
      tEffect=instance_create(bossArmL[seqTime].x,bossArmL[seqTime].y,oEffect)
      tEffect.sprite_index=sPoisonCloud; tEffect.followID=-1; tEffect.image_blend=make_color_rgb(88,80,24)
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2
      tEffect=instance_create(bossArmR[seqTime].x,bossArmR[seqTime].y,oEffect)
      tEffect.sprite_index=sPoisonCloud; tEffect.followID=-1; tEffect.image_blend=make_color_rgb(88,80,24)
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2
      with bossArmL[seqTime] {instance_destroy()}
      with bossArmR[seqTime] {instance_destroy()}
      seqTime-=1
      shotTime=0
    }

    tEffect=instance_create(x+random_range(-168,168),room_height-2,oEffectB)
    tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
    tEffect.direction=random_range(1,179); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    if y>=720
    {
      var tempMplay;
      tempMplay=findMusic(11)
      playMusic(tempMplay,0,0)
      msgCreate(0,0,"Jeremy","What the heck was that thing...",0,1,oMessagePerson,0)
      newMessage.fadingTime=95
      global.gameProgress=2290
      instance_destroy()
    }
  }
}
