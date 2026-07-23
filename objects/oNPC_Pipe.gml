#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
image_xscale=2
image_yscale=3

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384

growSeq=0
growTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if growSeq=0 //Wait till player gets close enough
  {
    var chkDist;
    chkDist=point_distance(oPlayer1.x,0,x,0)
    if chkDist<=growDist
    {
      playSound(global.snd_ItemSprout,0,1,1)
      visible=1
      growSeq+=1
    }
  }
  else if growSeq=1 //Grow
  {
    yVel=-2
    growTime+=1
    if growTime>=24
    {
      yVel=0
      growTime=0
      growSeq+=1
    }
  }
  else if growSeq=2 //Slight wait
  {
    growTime+=1
    if growTime>=10
    {
      if type=1 //Make NPC appear
      {
        var tEffect,tDir;
        tDir=0
        for(i=0;i<16;i+=1)
        {
          tEffect=instance_create(x+16,y-12,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sEnemyDieStar; tEffect.speed=random(1)+1
          tEffect.friction=random(0.01)+0.02; tEffect.fadeSpd=0.02; tEffect.direction=tDir
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
          tDir+=360/16
        }

        targetNPC.visible=1
        targetNPC.x=x+16
        targetNPC.y=y
        growSeq+=1
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  draw_background_part(tileMarioWorldA,0,112,32,32,x,y)
  draw_background_part(tileMarioWorldA,0,128,32,16,x,y+32)
}
