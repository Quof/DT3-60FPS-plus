#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recAtkNum+=1
global.stCGame_B[2]+=1
lifeTime=75

if oPlayer1.image_xscale=1
{
  type=1
  xSpawn=-16
}
else
{
  type=2
  xSpawn=16
}
xSpacing=24
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  lifeTime-=1
  if lifeTime mod 4=0
  {
    var tChainsword;
    if type=1
    {
      tChainsword=instance_create(view_xview[0]+xSpawn,view_yview[0],oJCGameChainsword)
      xSpawn+=xSpacing
      if xSpawn>112 {xSpawn=-16; xSpacing+=16}
    }
    else
    {
      tChainsword=instance_create(view_xview[0]+view_wview[0]+xSpawn,view_yview[0],oJCGameChainsword)
      xSpawn-=xSpacing
      if xSpawn<-112 {xSpawn=16; xSpacing+=16}
    }
    tChainsword.type=type
  }
  if lifeTime=0 {instance_destroy()}
}
