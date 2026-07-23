#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
stealProg=0
stealTime=0
timeThatIHaveBeenActive=0
mySpeed=2
playSound(global.snd_OrbThrow,0,1,10000)

var tEffect,tDir;
tDir=0
for(i=0;i<64;i+=1)
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sHexShieldOrb; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.direction=tDir
  tEffect.speed=4; tEffect.image_angle=tDir-90
  tDir+=360/64
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle-=15
  direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  speed=mySpeed

  timeThatIHaveBeenActive+=1
  if timeThatIHaveBeenActive=40 {mySpeed+=1}
  else if timeThatIHaveBeenActive=80 {mySpeed+=1}
  else if timeThatIHaveBeenActive=120 {mySpeed+=1}
  else if timeThatIHaveBeenActive=160 {mySpeed+=1}
  else if timeThatIHaveBeenActive=200 {mySpeed+=1}
  else if timeThatIHaveBeenActive=240 {mySpeed+=1}
  else if timeThatIHaveBeenActive=280 {mySpeed+=1}
  else if timeThatIHaveBeenActive=320 {mySpeed+=1}
  else if timeThatIHaveBeenActive=460 {mySpeed+=1}
  else if timeThatIHaveBeenActive=400 {mySpeed+=1}
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 //Megaman
{
  global.hasAbilToken[3]=1
  if global.activeAbility[0]=2 {global.activeAbility[0]=1}
  oHex_Final_Main.phaseTimeShiftA=500
}
else if type=2 //Samus
{
  global.hasAbilToken[4]=1
  if global.activeAbility[1]=2 {global.activeAbility[1]=1}
}
else if type=3 //Link
{
  global.hasAbilToken[1]=1
  if global.activeAbility[0]=1 {global.activeAbility[0]=0}
}
else if type=4 //Belmont
{
  global.hasAbilToken[2]=1
  if global.activeAbility[1]=1 {global.activeAbility[1]=0}
  oHex_Final_Main.phaseTimeShiftE=200
}
else if type=5 //Dashing
{
  global.hasShoes[2]=1
  global.hasShoes[3]=1
  oHex_Final_Main.phaseTimeShiftC=200
}

var tFlash;
tFlash=instance_create(0,0,oScreenFlash)
tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.05

var tEffect;
tEffect=instance_create(oPlayer1.x+24,oPlayer1.y-26,oEffectB)
tEffect.type=3; tEffect.sprite_index=sHexStealSkull; tEffect.newBlend=-1; tEffect.depth=21
tEffect.fadeSpd=0.04; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.rotation=0
tEffect.followID=oPlayer1; tEffect.xFollow=24; tEffect.yFollow=-26
tEffect=instance_create(oPlayer1.x-24,oPlayer1.y-26,oEffectB)
tEffect.type=3; tEffect.sprite_index=sHexStealSkull; tEffect.newBlend=-1; tEffect.depth=21
tEffect.fadeSpd=0.04; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.rotation=0; tEffect.image_xscale=-1
tEffect.followID=oPlayer1; tEffect.xFollow=-24; tEffect.yFollow=-26

instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<mySpeed;i+=1)
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale+(i*0.5),image_yscale+(i*0.5),image_angle*(1.05*i),image_blend,0.2)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
