#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase=0
image_speed=0.5
image_alpha=0.7
image_blend=make_color_rgb(50,50,50)
efLightDelay=irandom(29)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
phase+=0.02

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
    tEffect.depth=101; tEffect.image_angle=tTempDir; tEffect.image_xscale=2.25
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
Vault Gate script.
This will move the player to the Vault.
*/
if global.gamePaused=false
{
  if global.gameProgress>=2170
  {
    if oKeyCodes.kCodePressed[3]=1
    {
      resetKeyCodes()
      global.recAreaTrans+=1
      global.rmDeaths=0
      global.newMapX=160
      global.newMapY=288
      writeToPlayerGlobals()

      transition_steps=20
      transition_kind=21
      room_goto(rVault_1)
    }
  }
  else //First time going into the Vault
  {
    global.gamePaused=true
    global.gameProgress=2160
  }
}
#define Collision_oMisc
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  image_alpha-=0.1
  if image_alpha<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_wave(sprite_index,image_index,x,y,1,12,2,phase)
