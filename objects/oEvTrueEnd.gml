#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

if room=rEnd_PartA
{
  fadeAlpha=0
  shipWhite=0
}
else if room=rEnd_PartB
{
  fadeColor=c_black
  fadeAlpha=1
  theWarship=instance_create(224,96,oMisc)
  theWarship.type=0; theWarship.sprite_index=sCHAOS_WarshipMain
  shipExplode=1
  whiteAlpha=1
  shipWhite=0
}

explosionsBehind=0
expSoundTime=0
soundVol=0.91
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rEnd_PartA //----- [] End A -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay=1
    {
      instance_create(496,176,oChao_End)
    }
    else if sceneDelay>=30
    {
      fadeAlpha-=0.05
      if fadeAlpha<=0 {fadeColor=c_black; sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=5 {explosionsBehind=1}
    oChao_End.x-=8
    if oChao_End.x<=240 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    sceneDelay+=1
    if sceneDelay=35 {explosionsBehind=2; soundVol=0.95}

    if sceneDelay>=80
    {
      oChao_End.x-=8
      if oChao_End.x<=-16 {soundVol=1; explosionsBehind=100; sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=3
  {
    sceneDelay+=1
    if sceneDelay>=50
    {
      fadeAlpha+=0.04
      if fadeAlpha>=1 {room_goto(rEnd_PartB)}
    }
  }

  if explosionsBehind>0 and explosionsBehind<9 //Explosion effect while Chao escapes
  {
    for(i=0;i<explosionsBehind;i+=1)
    {
      var tEffect;
      tEffect=instance_create(oChao_End.x+16+random(32),oChao_End.y+random_range(-64,64),oEffect)
      tEffect.image_speed=0.33+random(0.33); tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=5+random(10); tEffect.ySpd=random_range(-2,2)
      tEffect.sprite_index=sBombExplosion
    }

    expSoundTime+=1
    if expSoundTime mod 6=0 {playSound(global.snd_MetroidBomb,0,soundVol,1)}
  }
  else if explosionsBehind=100
  {
    for(i=0;i<4;i+=1)
    {
      var tEffect;
      tEffect=instance_create(random(480),random(352),oEffect)
      tEffect.image_speed=0.33+random(0.33); tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect.sprite_index=sBombExplosion
    }
    expSoundTime+=1
    if expSoundTime mod 6=0 {playSound(global.snd_MetroidBomb,0,soundVol,1)}
  }
}
else if room=rEnd_PartB //----- [] End B -----
{
  if sceneProgress=0
  {
    sceneDelay+=1
    if sceneDelay>=30
    {
      fadeAlpha-=0.04
      if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
    }
  }
  else if sceneProgress=1
  {
    sceneDelay+=1
    if sceneDelay=29
    {
      playSound(global.snd_BombExplode,0,1,14000)
      for(i=0;i<40;i+=1)
      {
        var tEffect;
        tEffect=instance_create(312+random_range(-128,160),96+random_range(-72,72),oEffect)
        tEffect.image_speed=0.33+random(0.33); tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      }
    }
    if sceneDelay>=30
    {
      shipWhite+=4
      if shipWhite>20 {shipExplode=0}
      if shipWhite=136 {with oMisc {instance_destroy()}}
      else if shipWhite>=137 {whiteAlpha-=0.02}
    }
    if sceneDelay>=170 {sceneDelay=0; sceneProgress+=1}
  }
  else if sceneProgress=2
  {
    fadeAlpha+=0.04
    if fadeAlpha>=1
    {
      room_goto(rEnd_PartC)
    }
  }

  if shipExplode=1
  {
    for(i=0;i<4;i+=1)
    {
      var tEffect;
      tEffect=instance_create(312+random_range(-128,160),96+random_range(-72,72),oEffect)
      tEffect.image_speed=0.33+random(0.33); tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
    }
    expSoundTime+=1
    if expSoundTime mod 6=0 {playSound(global.snd_MetroidBomb,0,soundVol,1)}
  }
}

keyWaitForInput()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if shipWhite>0
{
  draw_set_alpha(whiteAlpha)
  draw_set_color(c_white)
  draw_ellipse(312-(shipWhite*1.66),96-shipWhite,312+(shipWhite*1.66),96+shipWhite,0)
}

if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
