#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bossProg=0
progTime=0
bShareHP=0
linkFrm=0

syncAtk=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bossProg=0 //Spawn first bot
  {
    botA=instance_create(704,352,oBladeBot)
    botA.activateBoss=1; botA.myBotNum=1
    if global.bBossGallery=1 {instance_create(0,0,oBossGalleryCheck)}
    bossProg=1
  }
  else if bossProg=1 //First bot falls below 55%, spawn second bot
  {
    if botA.lifePercent<=0.55
    {
      progTime+=1
      if progTime>=1 and progTime<=80
      {
        var tEffect;
        tEffect=instance_create(560+random(96),random(64),oEffect)
        tEffect.sprite_index=sMMSmokeCloud; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9

        if oGame.time mod 2=0
        {
          tEffect=instance_create(560+random(96),random(56),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sPushRock; tEffect.newBlend=-1
          tEffect.speed=random(5)+5; tEffect.friction=random(0.02)+0.02; tEffect.image_angle=random(360)
          tEffect.fadeSpd=0.05; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          tEffect.image_xscale=0.1+random(0.3); tEffect.image_xscale=0.1+random(0.3)
          tEffect.direction=random_range(268,272)
        }
      }
      else if progTime>=81
      {
        for(i=0;i<40;i+=1)
        {
          tEffect=instance_create(560+random(96),random(56),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sPushRock; tEffect.newBlend=-1
          tEffect.speed=random(6)+6; tEffect.friction=random(0.02)+0.02; tEffect.image_angle=random(360)
          tEffect.fadeSpd=0.05; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          tEffect.image_xscale=0.1+random(0.3); tEffect.image_xscale=0.1+random(0.3)
          tEffect.direction=random_range(268,272)
        }
        with (377769) {instance_destroy()}
        tile_layer_hide(999999)
        botB=instance_create(608,0,oBladeBot)
        botB.activateBoss=1; botB.myBotNum=2
        progTime=0; bossProg=2
      }
    }
  }
  else if bossProg=2 //Slight wait
  {
    progTime+=1
    if progTime>=45 {progTime=0; bossProg=3}
  }
  else if bossProg=3 //Equalize HP values if they are too far apart
  {
    if instance_exists(botA) and instance_exists(botB)
    {
      //--Desperation attack start--
      if syncAtk=0 //Set bots to check for team attack
      {
        if botA.lifePercent<=0.43 and botB.lifePercent<=0.43
        {
          botA.syncAtk=1; botB.syncAtk=1
          syncAtk=1
        }
      }
      else if syncAtk=1 //Check if both bots are ready
      {
        if botA.syncAtk=3 and botB.syncAtk=3
        {
          botA.sprite_index=sBBot_SparkSword; botB.sprite_index=sBBot_SparkSword
          botA.bSpark=1; botB.bSpark=1
          botA.syncAtk=4; botB.syncAtk=4
          syncAtk=2
        }
      }

      if botA.life>500 and botB.life>500
      {
        if botA.life+500<botB.life //BotA needs HP
        {
          bShareHP=1
          if botB.lifePercent>0.65
          {
            botA.life+=30
            botB.life-=30
          }
          else
          {
            botA.life+=3
            botB.life-=3
          }
        }
        else if botB.life+500<botA.life //BotB needs HP
        {
          bShareHP=1
          if botA.lifePercent>0.65
          {
            botA.life-=30
            botB.life+=30
          }
          else
          {
            botA.life-=3
            botB.life+=3
          }
        }
        else
        {
          bShareHP=0
        }
      }
    }
    else {bShareHP=0; bossProg=4}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShareHP=1
{
  linkFrm+=0.33
  var tMyDist,tMyDir;
  if instance_exists(botA) and instance_exists(botB)
  {
    tMyDist=point_distance(botA.x,botA.y-40,botB.x,botB.y-40)
    tMyDir=point_direction(botA.x,botA.y-40,botB.x,botB.y-40)
    draw_sprite_ext(sEfLinkLightning,linkFrm,botA.x,botA.y-40,0.5,tMyDist/64,tMyDir+90,c_white,0.45)
  }
}
