#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,-6,32,14)
bMoving=false
bPlayerOn=false
timeLeft=120
stepOffset=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
deathCheck=0

textCMain=make_color_rgb(72,192,248)
textCBorder=make_color_rgb(48,80,152)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character stands on the platform, move the platform continuously
if global.gamePaused=false
{
  if isCollisionCharacterTop(1,0)
  {
    stepOffset=3
    bPlayerOn=true
    if bMoving=false
    {
      xVel=2
      bMoving=true
    }
  }
  else
  {
    stepOffset=0
    bPlayerOn=false
  }

  if bMoving=true
  {
    if oGame.time mod 3=0
    {
      var tEffect;
      tEffect=instance_create(x-6+random(2),y+7+random(3),oEffectB); tEffect.image_speed=0.33
      tEffect.type=3; tEffect.sprite_index=sSamusMissileEffect; tEffect.speed=0.25+random(0.25)
      tEffect.image_alpha=0.8; tEffect.direction=random_range(173,187); tEffect.fadeSpd=0.04
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }

    if place_meeting(x,y,oNightmareEffect) {xVel=1}
    else {xVel=2}

    timeLeft-=1
    if timeLeft<=0
    {
      playSound(global.snd_EnemyDieMM,0,0.98,1)
      var tEffect;
      tEffect=instance_create(x+16,y+8,oEffect)
      tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  draw_sprite(sTimerPlatformStep,0,x,y-10+stepOffset)
  draw_sprite(sprite_index,0,x,y)
  draw_set_alpha(1)
  draw_set_font(fnt_Swap)
  draw_set_halign(fa_center)
  textDropShadow(floor(timeLeft/15),x+16,y,textCMain,textCBorder,4)
}
