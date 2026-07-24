#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bClouds=0
if room=rMario1_1 or room=rMario1_3 or room=rMario1_5 or room=rMario1_6 or room=rMario1_8 or room=rMario1_9 or room=rMario1_11
{
  bClouds=1
  cloudSpawn=irandom(50)
}
else if room=rMario1_2
  platformSpawn=0
else if room=rMario1_4
{
  bowserFireProg=0
  bowserFire=50
}

if room=rMario1_6 {lakituSpawn=120}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false //&& gDeltaDoTicks != 0
{
  if bClouds=1
  {
    cloudSpawn+=1*gDeltaTime
    if cloudSpawn=250
    {
      instance_create(view_xview[0]+view_wview[0]+4,view_yview[0]+random_range(8,96),oBkgCloud)
      cloudSpawn=irandom(50)
    }
  }

  if room=rMario1_1 //Achievement for hopping on beginning enemies in a row
  {
    if oPlayer1.hopOnCount>=8
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,19)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Major League Plumbing"; tAchievement.checkNum=19
      }
    }
  }
  if room=rMario1_2 //Automove platforms
  {
    platformSpawn+=1*gDeltaTime
    if platformSpawn mod 80=0
    {
      var tNewPlat;
      for(i=0;i<2;i+=1)
      {
        if i=0
        {
          tNewPlat=instance_create(2464,-16,oPlatformAutoMove)
          tNewPlat.moveSpeedY=2
        }
        else
        {
          tNewPlat=instance_create(2784,room_height+16,oPlatformAutoMove)
          tNewPlat.moveSpeedY=-2
        }
        tNewPlat.sprite_index=sInvisibleSolidMask
        tNewPlat.image_xscale=4; tNewPlat.spriteChange=1; tNewPlat.moveSpeedX=0
      }
    }
  }
  else if room=rMario1_4 //Bowser fire
  {
    if global.gameProgress=220
    {
      if oPlayer1.x>=1408 and bowserFireProg=0
      {
        playSound(global.snd_Fireball,0,0.99,1)
        var tNewAttack;
        for(i=0;i<4;i+=1)
        {
          tNewAttack=instance_create(view_xview[0]+view_wview[0]+8,200+(i*16),oPassBullet)
          tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=4
          tNewAttack.bulletSpeed=3; tNewAttack._direction=180; tNewAttack.decayTime=-100
        }
        bowserFireProg+=1
      }
      else if oPlayer1.x>=1728 and bowserFireProg=1
      {
        playSound(global.snd_Fireball,0,0.99,1)
        var tNewAttack;
        for(i=0;i<6;i+=1)
        {
          tNewAttack=instance_create(view_xview[0]+view_wview[0]+8,168+(i*16),oPassBullet)
          tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=4
          tNewAttack.bulletSpeed=3; tNewAttack._direction=180; tNewAttack.decayTime=-100
        }
        bowserFireProg+=1
      }
      else if oPlayer1.x>=1936 and bowserFireProg=2
      {
        playSound(global.snd_Fireball,0,0.99,1)
        var tNewAttack;
        for(i=0;i<8;i+=1)
        {
          tNewAttack=instance_create(view_xview[0]+view_wview[0]+8,168+(i*16),oPassBullet)
          tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=4
          tNewAttack.bulletSpeed=3; tNewAttack._direction=180; tNewAttack.decayTime=-100
        }
        bowserFireProg+=1
      }
    }

    if oPlayer1.x>=2176 and oPlayer1.x<=3104
    {
      bowserFire+=1*gDeltaTime
      if bowserFire=60
      {
        playSound(global.snd_Fireball,0,0.99,1)
        var tNewAttack;
        tNewAttack=instance_create(view_xview[0]+view_wview[0]+8,random_range(176,240),oPassBullet)
        tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=4
        tNewAttack.bulletSpeed=3; tNewAttack._direction=180; tNewAttack.decayTime=-100
        bowserFire=0
      }
    }
  }
  else if room=rMario1_6 //Lakitu spawn
  {
    if !instance_exists(oLakitu)
    {
      lakituSpawn+=1*gDeltaTime
      if lakituSpawn=210
      {
        var tNewEnemy;
        tNewEnemy=instance_create(view_xview[0]-16,48,oLakitu)
        tNewEnemy.bActive=true
        lakituSpawn=0
      }
    }
  }
  else if global.gameProgress=400 and room=rMario1_9 //Invisible platforms
  {
    if sceneProgress=0
    {
      for (i=0;i<=1;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=1120 and oPlayer1.x<=1152
    {
      msgCreate(0,0,"Jerry","Whoa, what's going on here?",0,1,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue[0]+=1
    }
    else if charDialogue[0]=1 {convo[0]+=1*gDeltaTime;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=2
    {
      msgCreate(0,0,"Jeremy","It's a bug, just look closely.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
  }
  else if global.gameProgress=410 and room=rMario1_10 //Bullet Bill Hell
  {
    if sceneProgress=0
    {
      for (i=0;i<=1;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 {convo[0]+=1*gDeltaTime;if convo[0]>=30 {charDialogue[0]+=1; convo[0]=0}}
    else if charDialogue[0]=1
    {
      msgCreate(0,0,"Jeremy","Take this slow and watch for gaps.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
  }
  else if global.gameProgress=430 and room=rMario1_12 //Munchers
  {
    if sceneProgress=0
    {
      for (i=0;i<=1;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=96
    {
      charDialogue[0]+=1
    }
    else if charDialogue[0]=1
    {
      msgCreate(0,0,"Jerry","Bite me, level designers!",0,1,oMessagePerson,0)
      newMessage.fadingTime=70; charDialogue[0]+=1
    }
  }
}
