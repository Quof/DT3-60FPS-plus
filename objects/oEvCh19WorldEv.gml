#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
shakeTime=320+irandom(90)
shakeDelay=600
fadeAlpha=0
fadeColor=c_black
bCanShake=0
sideConvoTime=0
eventProg=0
eventTime=0

explodeAlpha=0
explodeRad=0
explodeX=3616; explodeY=256

if room=rMain_32 {if global.Ch19WIn=1 {global.Ch19WIn=2}}
else if room=rMain_31 {if global.Ch19WIn=2 {global.Ch19WIn=3}}
else if room=rMain_30 {if global.Ch19WIn=3 {global.Ch19WIn=4}}
else if room=rMain_17 {if global.Ch19WIn=4 {global.Ch19WIn=5}}
else if room=rMain_11 {if global.Ch19WIn=5 {global.Ch19WIn=6}}
else if room=rMain_8 {if global.Ch19WIn=6 {global.Ch19WIn=7}}
else if room=rMain_61 {if global.Ch19WIn=7 {global.Ch19WIn=8}}
else if room=rMain_62 {if global.Ch19WIn=8 {global.Ch19WIn=9}}
else if room=rMain_79 {if global.Ch19WIn=9 {global.Ch19WIn=10}}
else if room=rMain_80 {if global.Ch19WIn=10 {global.Ch19WIn=11}}
else if room=rMain_83 {if global.Ch19WIn=11 {global.Ch19WIn=12}}
else if room=rMain_84 {if global.Ch19WIn=12 {global.Ch19WIn=13}}

if global.Ch19WIn>=1 and global.Ch19WIn<=6
{
  fadeAlpha=0.2
  bCanShake=1
}
else if global.Ch19WIn>=7 and global.Ch19WIn<=10
{
  fadeAlpha=0.3
  bCanShake=1
}
else if global.Ch19WIn>=11 and global.Ch19WIn<=13
{
  fadeAlpha=0.4
  bCanShake=1
}
else if global.Ch19WIn>=14
{
  fadeAlpha=0.4
}

if room=rHiddenVillage_Destroyed
{
  fadeAlpha=0.2
  fadeColor=c_red
  explodeX=2640; explodeY=288
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if global.gameProgress=4940
  {
    if global.Ch19WIn=0 or global.Ch19WIn=1 and room=rMain_34
    {
      eventTime+=1
      if eventTime=150
      {
        msgCreate(0,0,"Jerry","Eh?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
        shakeTime=shakeDelay
        bCanShake=1
        global.Ch19WIn=1
      }
      else if eventTime>=151 and eventTime<=250 {if fadeAlpha<0.2 {fadeAlpha+=0.002}}

      if sideConvoTime=0
      {
        if (oPlayer1.x>=1968 and oPlayer1.y>=1008) or (oPlayer1.x>=288 and oPlayer1.x<=480 and oPlayer1.y<=208)
        {
          msgCreate(0,0,"Jerry","What's up with this barrier here?",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
          sideConvoTime=1
        }
      }
      else
      {
        sideConvoTime+=1
        if sideConvoTime=70
        {
          msgCreate(0,0,"Claire","And that shake... what's going on?",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
      }
    }
    else if global.Ch19WIn=2 and room=rMain_32
    {
      if eventProg=0
      {
        if oPlayer1.x<=2224
        {
          msgCreate(0,0,"Jerry","Ah hell no.",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
          eventProg=1
        }
      }
    }
    else if global.Ch19WIn=3 and room=rMain_31
    {
      if eventProg=0
      {
        if oPlayer1.x<=1120
        {
          var tEnemy;
          tEnemy=instance_create(1168,-32,oCHAOS_Rocketeer); tEnemy.bActive=1
          tEnemy=instance_create(1632,-32,oCHAOS_Rocketeer); tEnemy.bActive=1
          eventProg=1
        }
      }
    }
    else if global.Ch19WIn=4 and room=rMain_30
    {
      if eventProg=0
      {
        if oPlayer1.x<=560 {eventProg=1}
      }
      else if eventProg=1
      {
        eventTime+=1
        if eventTime=1
        {
          msgCreate(0,0,"Claire","These barriers are all over the place.",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
        else if eventTime=80
        {
          msgCreate(0,0,"Jerry","We know who's responsible for this.",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
      }
    }
    else if global.Ch19WIn=5 and room=rMain_17
    {
      if eventProg=0
      {
        eventTime+=1
        if eventTime=40
        {
          msgCreate(0,0,"Jerry","This big shadow is bothersome too.",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
        else if eventTime=120
        {
          msgCreate(0,0,"Claire","It's the warship hovering over the area...#It's heading north...",0,2,oMessagePerson,0)
          newMessage.fadingTime=110
        }
        else if eventTime=230
        {
          msgCreate(0,0,"Jerry","I say we keep going to the Hidden Village.",0,1,oMessagePerson,0)
          newMessage.fadingTime=85
        }
      }
    }
    else if global.Ch19WIn=6 and room=rMain_11
    {
      if eventProg=0
      {
        if oPlayer1.x<=2624 {eventProg=1}
      }
      else if eventProg>=1 {if fadeAlpha<0.3 {fadeAlpha+=0.002}}
    }
    else if global.Ch19WIn=7 and room=rMain_8
    {
      if eventProg=0
      {
        if oPlayer1.x<=2592
        {
          msgCreate(0,0,"Jerry","Even Central City has a barrier...",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
          eventProg=1
        }
      }
      else if eventProg=1
      {
        if oPlayer1.y<=480
        {
          var tEnemy;
          for(i=0;i<12;i+=1)
          {
            tEnemy=instance_create(1888+(32*i),352,oCHAOS_AirGunner); tEnemy.bActive=1
          }
          eventProg=2
        }
      }
    }
    else if global.Ch19WIn=10 and room=rMain_79
    {
      if eventProg=0
      {
        if oPlayer1.x>=1904 {eventProg=1}
      }
      else if eventProg=1
      {
        if oPlayer1.x>=3968
        {
          msgCreate(0,0,"Jerry","It's way too quiet now.",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
          eventProg=2
        }
      }

      if eventProg>=1 {if fadeAlpha<0.4 {fadeAlpha+=0.002}}
    }
    else if global.Ch19WIn=13 and room=rMain_84
    {
      if eventProg=0
      {
        if oPlayer1.x>=3344
        {
          with oVarViewShaker {instance_destroy()}
          view_object[0]=oPlayer1
          playSound(global.snd_HardHit2,0,1,2000)
          explodeAlpha=1
          bCanShake=0
          eventProg=1
        }
      }
      else if eventProg=1
      {
        eventTime+=1
        if eventTime>=1 and eventTime<=30
        {
          explodeRad+=24
        }
        else if eventTime=31
        {
          global.gamePaused=true
          explodeRad=0
          oEvCh19MainA.fadeAlpha=1
          eventTime=0; eventProg=0
          global.Ch19WIn=14
        }
      }
    }
    else if global.Ch19WIn=16 and room=rHiddenVillage_Destroyed
    {
      if eventProg=0 //The Master dies
      {
        if oPlayer1.x>=624
        {
          (420665).eventProg=1
          eventProg+=1
        }
      }
      else if eventProg=1 //Malignant Ooze
      {
        if oPlayer1.x>=1520
        {
          var enemyBarrier,tEnemy;
          enemyBarrier=instance_create(1040,1120,oEnemyBarrier); enemyBarrier.image_yscale=6; enemyBarrier.image_blend=c_dkgray
          enemyBarrier=instance_create(1872,1120,oEnemyBarrier); enemyBarrier.image_yscale=6; enemyBarrier.image_blend=c_dkgray
          tEnemy=instance_create(1728,1216,oMalignantOoze)
          eventProg+=1
        }
      }
      else if eventProg=2
      {
        if !instance_exists(oMalignantOoze)
        {
          with oEnemyBarrier {instance_destroy()}
          eventProg+=1
        }
      }
      else if eventProg=3 //A bot dies
      {
        if oPlayer1.x>=2048
        {
          playSound(global.snd_FadeAway,0,0.92,1)
          eventProg+=1
        }
      }
      else if eventProg=4 //They're killing the bots
      {
        eventTime+=1
        if eventTime=60
        {
          msgCreate(0,0,"Jerry","What the hell?!",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
          eventTime=0; eventProg+=1
        }
      }
      else if eventProg=5 //A bot dies
      {
        if oPlayer1.x>=2064 and oPlayer1.y<=848
        {
          (420819).eventProg=1
          playSound(global.snd_FadeAway,0,0.92,1)
          eventProg+=1
        }
      }
      else if eventProg=5 //A bot dies
      {
        if oPlayer1.x<=2016 and oPlayer1.y<=688
        {
          playSound(global.snd_FadeAway,0,0.92,1)
          eventProg+=1
        }
      }
      else if eventProg=6 //The Klonoa dies
      {
        if oPlayer1.x<=1760 and oPlayer1.y<=688
        {
          (420737).eventProg=1
          eventProg+=1
        }
      }
      else if eventProg=7 //The Klonoa dies
      {
        if oPlayer1.x<=384 and oPlayer1.y<=688
        {
          (420738).eventProg=1
          eventProg+=1
        }
      }
      else if eventProg=8 //A bot dies
      {
        if oPlayer1.x<=448 and oPlayer1.y<=512
        {
          playSound(global.snd_FadeAway,0,0.92,1)
          eventProg+=1
        }
      }
      else if eventProg=9 //The Battletoad dies
      {
        if oPlayer1.x>=656 and oPlayer1.y<=336
        {
          (420739).eventProg=1
          eventProg+=1
        }
      }
      else if eventProg=10 //The Earthworm Jim dies
      {
        if oPlayer1.x>=1440 and oPlayer1.y<=336
        {
          var enemyBarrier,tEnemy;
          enemyBarrier=instance_create(1872,160,oEnemyBarrier); enemyBarrier.image_yscale=6; enemyBarrier.image_blend=c_dkgray;
          (420740).eventProg=1
          eventProg+=1
        }
      }
      else if eventProg=11
      {
        eventTime+=1
        if eventTime>=120
        {
          if !instance_exists(oCHAOS_Rocketeer)
          {
            with oEnemyBarrier {instance_destroy()}
            eventTime=0; eventProg+=1
          }
        }
      }
      else if eventProg=12
      {
        if oPlayer1.x>=2480 and oPlayer1.y<=320
        {
          eventProg=0
          global.gamePaused=true
          global.Ch19WIn=17
        }
      }
    }
    
    if bCanShake=1 //Shake
    {
      shakeTime+=1
      if shakeTime>=shakeDelay
      {
        playSound(global.snd_HardHit2,0,0.9+random(0.05),3000+random(4000))
        var tShake;
        tShake=instance_create(oPlayer1.x,oPlayer1.y,oVarViewShaker)
        tShake.shakeTime=50; tShake.turbulance=2
        shakeTime=irandom(120)
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}

if explodeAlpha>0
{
  draw_set_alpha(explodeAlpha)
  draw_set_color(c_white)
  draw_circle(explodeX,explodeY,explodeRad,0)
}
