#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=3
image_yscale=4
findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
for(i=0;i<2;i+=1)
{
  char[i]=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if collision_rectangle(x,y,x+48,y+64,oPlayer1,1,1)
    char[0]=1
  else
    char[0]=0
  if collision_rectangle(x,y,x+48,y+64,oPlayerIdle,1,1)
    char[1]=1
  else
    char[1]=0

  if char[0]=1 and char[1]=1 //Win condition
  {
    if progCheck=global.gameProgress
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      global.gameProgress+=10
    }
  }

  if oGame.time mod 3=0 //Sparkle effect
  {
    var tEffect;
    //top
    tEffect=instance_create(x+random(48),y,oEffect)
    if random(4)>2 {tEffect.sprite_index=sMMshotgunIceEffect}
    else {tEffect.sprite_index=sBelmontWepEffect}
    tEffect.image_speed=0.2+random(0.1)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    //bottom
    tEffect=instance_create(x+random(48),y+64,oEffect)
    if random(4)>2 {tEffect.sprite_index=sMMshotgunIceEffect}
    else {tEffect.sprite_index=sBelmontWepEffect}
    tEffect.image_speed=0.2+random(0.1)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    //left
    tEffect=instance_create(x,y+random(64),oEffect)
    if random(4)>2 {tEffect.sprite_index=sMMshotgunIceEffect}
    else {tEffect.sprite_index=sBelmontWepEffect}
    tEffect.image_speed=0.2+random(0.1)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    //right
    tEffect=instance_create(x+48,y+random(64),oEffect)
    if random(4)>2 {tEffect.sprite_index=sMMshotgunIceEffect}
    else {tEffect.sprite_index=sBelmontWepEffect}
    tEffect.image_speed=0.2+random(0.1)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  draw_set_alpha(0.2)
  draw_set_color(c_silver)
  draw_rectangle(x,y,x+48,y+64,0)
}
