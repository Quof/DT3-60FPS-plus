#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(0,0,sprite_width,sprite_height)

//variables for the break platform
bBreaking=0          //is the platform breaking
timeUntilBreak=20    //time till platform falls
newSprite=0
effectXscale=0.4
effectYscale=0.4
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("spriteChange")
  newSprite=spriteChange

if global.location=10 //Gate 2
{
  if room=rLink2_PalaceC_5
    newSprite=2
  else if room=rLink2_PalaceF_11
    newSprite=4
  else
    newSprite=1
  timeUntilBreak=8
}
else if global.location=58 //Gate 6
{
  timeUntilBreak=15
  sprite_index=sG6BreakPlat
  image_speed=0
}

if newSprite=3 //Magical Fields - Cloud
{
  x+=8
  image_xscale=2
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Platform breaks
if global.gamePaused=false && gDeltaDoTicks
{
  if bBreaking
  {
    timeUntilBreak-=1
    if sprite_index=sG6BreakPlat //Platform break effect if in Gate 6
    {
      if timeUntilBreak=10 {image_index=1}
      else if timeUntilBreak=6 {image_index=2}
      else if timeUntilBreak=2 {image_index=3}
    }

    if timeUntilBreak<=0 //Play effect and destroy object
    {
      awardAwesome(10)
      if newSprite=3 //Cloud
      {
        for(i=0;i<12;i+=1)
        {
          var tFFScl,tEffect;
          tFFScl=random(0.15)
          tEffect=instance_create(x+random(32),y+random(16),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
          tEffect.image_alpha=0.6; tEffect.image_xscale=0.1+tFFScl; tEffect.image_yscale=0.1+tFFScl
          tEffect.direction=random_range(70,110); tEffect.speed=random(0.75)+0.5
          tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.015; tEffect.image_blend=c_silver
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        }
      }
      else
      {
        if sprite_index!=sG6BreakPlat
        {
          var tEffect;
          tEffect=instance_create(x+(sprite_width/2),y+(sprite_height/2),oEffect)
          tEffect.sprite_index=sDustCloud; tEffect.image_xscale=effectXscale; tEffect.image_yscale=effectYscale
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      instance_destroy()
    }
  }
  else
  {
    //if the character touches the platform, start the timer
    if newSprite=3
    {
      if isCollisionCharacterTop(1,0) {bBreaking=1}
    }
    else
    {
      if isCollisionCharacterTop(1,0) {bBreaking=1}
      if isCollisionCharacterBottom(1,0) {bBreaking=1}
      if isCollisionCharacterLeft(1,0) {bBreaking=1}
      if isCollisionCharacterRight(1,0) {bBreaking=1}
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if newSprite=0
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
else if newSprite=1 //Gate 2 - 1
  draw_background_part(tileZelda2,32,32,16,16,x,y)
else if newSprite=2 //Gate 2 - 2
  draw_background_part(tileZelda2,128,176,16,16,x,y)
else if newSprite=3 //Magical Quest - Cloud
  draw_background_part(tileMagicalQuestA,0,128,48,16,x-8,y)
else if newSprite=4 //Gate 2 - 2
  draw_background_part(tileZelda2,128,192,16,16,x,y)
