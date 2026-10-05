#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
sprite_index=sNull
image_xscale=room_height
image_yscale=4
image_angle=90

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2
decayTime=0
warnTime=45
warnAlpha=1
alphaChange=0
warnToPlayer=y
flashT=0 //ticks since the laser turned on (shade flicker, see Step)
shadeTick=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("onPlayer")
  warnToPlayer=oPlayer1.y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCanDealDamage=true
  {
    //Vanilla (30fps): the laser keeps its own (blue) color for the tick it turns on, because the shade is only set from the
    //next step on; then it gets a new random shade every tick. With a new laser every 3 ticks that's the blue flicker.
    //Above 30fps the same: blue for the first whole tick after turning on, then a new shade at each tick after that
    //(counted from when this laser turned on). flashT counts ticks since then.
    flashT+=gDeltaTime
    if flashT<1 {image_blend=c_white}
    else if floor(flashT)!=shadeTick
    {
      shadeTick=floor(flashT)
      if room=rLowFacR {image_blend=make_color_rgb(160+random(50),160+random(50),160+random(50))}
      else {image_blend=make_color_rgb(25+random(50),25+random(50),25+random(50))}
    }

    if gDeltaDoTicks
    {
      tEffect=instance_create(x+(-8+random(16)),y+(-8+random(16)),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.33
      tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5
      tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.035
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0

      if decayTime<5000 {decayTime+=1}
      if decayTime>=idleTime {instance_destroy()}
    }
  }
  else
  {
    warnTime-=1*gDeltaTime
    if warnTime=0
    {
      playSound(global.snd_Shock,0,0.9,1)
      if bShake=1 {instance_create(0,0,oScreenEffect)}
      sprite_index=sShroudLLaser
      bCanDealDamage=true
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if warnTime>0
{
  draw_sprite_ext(sWarningSymbol,-1,x,warnToPlayer,0.6,0.6,0,c_white,warnAlpha)
  alphaChange+=1*gDeltaTime
  if alphaChange=8
  {
    if warnAlpha=1 {warnAlpha=0}
    else {warnAlpha=1}
    alphaChange=0
  }
}
