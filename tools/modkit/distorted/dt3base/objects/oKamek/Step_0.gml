if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if sprite_index=sKamekHit and hitStateTime>0 and life>0
  {
    //hitStateTime-=1
    hitStateTime-=1*gDeltaTime //60fps change: scaled
    if hitStateTime=0 {sprite_index=sKamekIdle}
  }

  if bActive=true and hitStateTime=0 and life>0
  {
    if sprite_index=sKamekWalk //Walk animation
    {
      walkFrm+=1*gDeltaTime
      if walkFrm=1 {image_index=0}
      else if walkFrm=7 {image_index=1}
      else if walkFrm=13 {image_index=2}
      else if walkFrm=19 {image_index=1}
      else if walkFrm>=24 {walkFrm=0}
    }

    atkTime+=1*gDeltaTime
    if moveType=0 //Walk to one end of the room and spawn orbs, walk to other end, spawn orbs, repeat
    {
      if atkTime=15 {sprite_index=sKamekHandsUp}
      else if atkTime=25 //Spawn Spin Orbs
      {
        var tEffect,tAtk;
        tEffect=instance_create(x+(12*image_xscale),y-26,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        if life=5 or life=4
        {
          for(i=0;i<2;i+=1)
          {
            tAtk=instance_create(x+(12*image_xscale),y-26,oKamBounceBall)
            tAtk.atkPower=atkPower; tAtk.type=i; tAtk.myDir=i*180; tAtk.xOrig=x+(12*image_xscale); tAtk.yOrig=y-26; tAtk.projType=0
          }
        }
        else
        {
          for(i=0;i<3;i+=1)
          {
            tAtk=instance_create(x+(12*image_xscale),y-26,oKamBounceBall)
            tAtk.atkPower=atkPower; tAtk.type=i; tAtk.myDir=i*120; tAtk.xOrig=x+(12*image_xscale); tAtk.yOrig=y-26; tAtk.projType=0
          }
        }
      }
      else if atkTime=45
      {
        sprite_index=sKamekIdle
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
      }
      else if atkTime>=60 and atkTime<=999 //Walk to end of room
      {
        sprite_index=sKamekWalk
        x+=moveSpd*image_xscale*gDeltaTime
        if shockPass>=3 //Middle of the room
        {
          if point_distance(x,0,xCenter,0)<moveSpd {sprite_index=sKamekHandsUp; shockPass=1000; atkTime=1000}
        }
        if (image_xscale=-1 and x<=xCenter-roomSpan+48) or (image_xscale=1 and x>=xCenter+roomSpan-48) //At end of the room
        {
          if life<=3 {shockPass+=1}
          sprite_index=sKamekIdle; atkTime=0
        }
      }
      else if atkTime=1050 //Release Charge
      {
        var tAtk;
        tAtk=instance_create(x,y-32,oPassBullet)
        tAtk.sprite_index=sKamFlame; tAtk._direction=90; tAtk.damageType="ELEMENTAL"
        tAtk.atkPower=atkPower; tAtk.bulletSpeed=12; tAtk.decayTime=-100
        sprite_index=sKamekIdle
        if x<oPlayer1.x {image_xscale=-1} else {image_xscale=1}
      }
      else if atkTime=1080 //Flames fall
      {
        playSound(global.snd_Fireball,0,0.98,1)
        var tAtk,tXpos;
        tXpos=xCenter-88
        for(i=0;i<maxFlames;i+=1)
        {
          tAtk=instance_create(tXpos,2,oPassBullet)
          tAtk.sprite_index=sKamFlame; tAtk._direction=270; tAtk.damageType="ELEMENTAL"
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100
          if maxFlames=3 {tXpos+=88}
          else if maxFlames=5 {tXpos+=44}
        }
        shockPass=0
        atkTime=50
      }
    }
    else if moveType=1 //Move to right side of room and face left
    {
      if atkTime>=1 and atkTime<=199
      {
        sprite_index=sKamekWalk; image_xscale=1
        x+=2*gDeltaTime
        if x>=xCenter+roomSpan-48
        {
          sprite_index=sKamekIdle; image_xscale=-1
          atkTime=0; moveType=2
        }
      }
    }
    else if moveType=2 //Shadow forms
    {
      if atkTime=30 {sprite_index=sKamekHandsUp; bShadow=1}
      else if atkTime=50 {playSound(global.snd_DemonLaugh,0,1,10000)}
      //else if atkTime>=51 and atkTime<=110 {shadowScl+=0.05*gDeltaTime}
      else if atkTime>50 and atkTime<=110 {shadowScl+=0.05*gDeltaTime} //60fps change: >50 so all frames of the first tick count
      else if atkTime>=120 {atkTime=0; moveType=3}
    }
    else if moveType=3 //Meteor shower
    {
      if atkTime=1 {sprite_index=sKamekHandsUp}
      else if atkTime>=20 and atkTime<=155 //From top
      {
        if atkTime mod 10=0
        {
          event_user(0)
          meteorSeq+=1
        }
      }
      else if atkTime=170 {meteorSeq=0}
      else if atkTime>=190 and atkTime<=335 //From right
      {
        if atkTime mod 17=0
        {
          event_user(1)
          meteorSeq+=1
        }
      }
      else if atkTime>=350 //Wait time
      {
        meteorSeq=0
        atkTime=0
      }
    }

    if wandState=0 and life<maxLife //----- Spawn Wand -----
    {
      instance_create(x,yGround-158,oKamWand)
      for(i=0;i<20;i+=1)
      {
        var tEffect;
        tEffect=instance_create(oKamWand.x,oKamWand.y,oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.15+random(0.05); tEffect.newBlend=-1
        tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
        tEffect.image_xscale=2; tEffect.image_yscale=2
      }
      wandState=2
    }

    //---------- Boss Difficulty Curve ----------
    if bossProgress=0 and life=4
    {
      jeremyText="So something is going on with that Wand. I know Kamek is controlling it, but it's like it has a mind of its own. Kamek is still able to cast spells while the wand does that as well."
      bossProgress+=1
    }
    else if bossProgress=1 and life=3
    {
      bossProgress+=1
    }
    else if bossProgress=2 and life=2
    {
      moveType=1
      bossProgress+=1
    }
    else if bossProgress=3 and life=1
    {
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    atkTime+=1*gDeltaTime
    if atkTime=1
    {
      bShadow=0
      with oEProjectileBase {instance_destroy()}
    }
    if atkTime mod 5=0
    {
      var tEffect;
      for(i=0;i<6;i+=1)
      {
        tEffect=instance_create(x-12+random(24),bbox_bottom-4-random(sprite_height-8),oKillEffect)
        tEffect.speed=5; tEffect.direction=random(360); tEffect.friction=0.1+random(0.3)
        tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
      }
    }

    image_alpha-=0.01*gDeltaTime
    if image_alpha<=0
    {
      if global.bBossGallery=1
      {
        bossRoomTally(2)
        global.newMapX=552; global.newMapY=1376; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
