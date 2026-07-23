#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase=0
image_speed=0.5
image_alpha=0.7
image_blend=make_color_rgb(10,10,10)
efLightDelay=irandom(29)
for(i=0;i<16;i+=1)
{
  scaleAmt[i]=0
}
changeScale=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=0.02

changeScale+=1
if changeScale mod 4=0
{
  for(i=0;i<16;i+=1)
  {
    if (random(10)>8) {scaleAmt[i]=random(0.05)}
  }
}
if changeScale mod 9=0
{
  var tEffect;
  tEffect=instance_create(x+random(64),y+random(64),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEf_DistortionSwirl; tEffect.newBlend=-1
  tEffect.image_alpha=0.5; tEffect.speed=1; tEffect.direction=90; tEffect.image_xscale=choose(-1,1)
  tEffect.fadeSpd=0.01; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
}

efLightDelay+=1
if efLightDelay=30
{
  var tEffect,tTempAmt,tTempDir,tTempDist;
  tTempAmt=irandom_range(1,2)
  for(i=0;i<tTempAmt;i+=1)
  {
    tTempDir=random(360)
    tTempDist=random(12)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMXTTLight
    tEffect.x=x+32+lengthdir_x(16+tTempDist,tTempDir); tEffect.y=y+30+lengthdir_y(16+tTempDist,tTempDir)
    tEffect.depth=101; tEffect.image_angle=tTempDir; tEffect.image_xscale=2.75
    tEffect.image_speed=0.5; tEffect.image_blend=image_blend
    tEffect.image_alpha=0.5; tEffect.decay=5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.xSpd=0; tEffect.ySpd=0
  }
  efLightDelay=irandom(29)
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Distortion Gate script.
This will move the player to the Distortion.
*/
if global.gamePaused=false
{
  if oKeyCodes.kCodePressed[3]=1
  {
    resetKeyCodes()
    global.recAreaTrans+=1
    global.rmDeaths=0
    global.newMapX=newMapX
    global.newMapY=newMapY
    writeToPlayerGlobals()

    transition_steps=20
    transition_kind=21
    room_goto(toRoom)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_wave(sprite_index,image_index,x,y,1,12,3,phase)

for(i=0;i<16;i+=1)
{
  draw_sprite_ext(sEf_DistortionDoorSpiral,0,x+32+lengthdir_x(22,(i*22.5)+180),y+32+lengthdir_y(22,(i*22.5)+180),image_xscale+scaleAmt[i],image_yscale+scaleAmt[i],i*22.5,c_white,0.75)
}
