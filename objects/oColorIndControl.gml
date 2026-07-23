#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
parent="none"
damageType="NORMAL"
bCanDealDamage=true
bCauseKnockback=true
bDealZeroDamage=0
atkPower=16

rotateAmt=-1
bWillDamagePlayer=0 //on 0, it WILL damage the player
warnTime=999
currentColor=1
for(i=0;i<4;i+=1)
{
  bColorActive[i]=0
}
bWarnStart=0
warnRotate=0
warnAlpha=1
warnScale=1
textColor=make_color_rgb(255,248,155)
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
warnTime=warnDelay
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bWillDamagePlayer>0
    bWillDamagePlayer-=1
  warnTime-=1
  if warnTime>=1 and warnTime<=90
  {
    if bWarnStart=0 and warnTime<=90
    {
      playSound(global.snd_ColorPulseA,0,0.93,22050)
      warnAlpha=0.7
      warnScale=2.5
      bWarnStart=1
    }
    else if bWarnStart=1 and warnTime<=60
    {
      playSound(global.snd_ColorPulseA,0,0.95,33075)
      warnAlpha=0.6
      warnScale=3.25
      bWarnStart=2
    }
    else if bWarnStart=2 and warnTime<=30
    {
      playSound(global.snd_ColorPulseA,0,0.97,44100)
      warnAlpha=0.5
      warnScale=4
      bWarnStart=3
    }
    warnRotate-=10
  }
  if warnTime<=0
  {
    playSound(global.snd_ColorPulseB,0,0.98,22050)
    //Deal damage to player if not inside the appropriate zone
    if bWillDamagePlayer=0
    {
      with oPlayer1
      {
        invertScreen=instance_create(0,0,oScreenInvert)
        invertScreen.invertTime=3
        if global.debugInvincible=false
          takeDamage(other)
      }
    }
    //Return to normal state
    currentColor+=1
    if currentColor=5
      currentColor=1
    warnRotate=0
    warnAlpha=1
    warnScale=1
    bWarnStart=0
    warnTime=warnDelay
  }
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  bColorActive[i]=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xPort=view_xview[0]+290
yPort=view_yview[0]+8
draw_sprite(sColorZoneMain,0,xPort,yPort)
draw_sprite_ext(sColorZoneDiamond,0,xPort+65,yPort+15,0.8,0.8,0,image_blend,0.3)
draw_sprite_ext(sColorZoneDiamond,1,xPort+99,yPort+15,0.8,0.8,0,image_blend,0.3)
draw_sprite_ext(sColorZoneDiamond,2,xPort+133,yPort+15,0.8,0.8,0,image_blend,0.3)
draw_sprite_ext(sColorZoneDiamond,3,xPort+167,yPort+15,0.8,0.8,0,image_blend,0.3)

if currentColor=1 {draw_sprite_ext(sColorZoneDiamond,0,xPort+65,yPort+15,warnScale,warnScale,warnRotate,image_blend,warnAlpha)}
else if currentColor=2 {draw_sprite_ext(sColorZoneDiamond,1,xPort+99,yPort+15,warnScale,warnScale,warnRotate,image_blend,warnAlpha)}
else if currentColor=3 {draw_sprite_ext(sColorZoneDiamond,2,xPort+133,yPort+15,warnScale,warnScale,warnRotate,image_blend,warnAlpha)}
else if currentColor=4 {draw_sprite_ext(sColorZoneDiamond,3,xPort+167,yPort+15,warnScale,warnScale,warnRotate,image_blend,warnAlpha)}

if bColorActive[0]=1 {draw_sprite_ext(sColorZoneAct,0,xPort+65,yPort+15,1,1,0,c_red,1)}
if bColorActive[1]=1 {draw_sprite_ext(sColorZoneAct,0,xPort+99,yPort+15,1,1,0,c_blue,1)}
if bColorActive[2]=1 {draw_sprite_ext(sColorZoneAct,0,xPort+133,yPort+15,1,1,0,c_green,1)}
if bColorActive[3]=1 {draw_sprite_ext(sColorZoneAct,0,xPort+167,yPort+15,1,1,0,c_yellow,1)}

draw_set_color(textColor)
draw_set_alpha(1)
draw_set_font(fnt_ColorTime)
draw_set_halign(fa_center)
draw_text(xPort+22,yPort+4,warnTime)
