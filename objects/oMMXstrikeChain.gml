#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(1,-7,7,7)
bodyFrm=0
bCollide=0
extend=0
bRetract=0

bCheckMiss=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  bodyFrm+=0.33
  if oPlayer1.grappleState=1
  {
    if bCheckMiss=0 //Check if the chain ever comes close to a latch point
    {
      if instance_exists(oStrikeChainPoint)
      {
        myChainPoint=instance_nearest(x,y,oStrikeChainPoint)
        if point_distance(x,y,myChainPoint.x,myChainPoint.y)<32
        {
          bCheckMiss=1
        }
      }
    }

    if bRetract=0
    {
      extend+=12
      if extend>=84 {bRetract=1}
    }
    else
    {
      extend-=12
      if extend<=0 {bCollide=1}
    }

    if oPlayer1.bWallGrab=0
    {
      tYadjust=32
      if oPlayer1.mmState=oPlayer1.BUSTER_STAND {tYadjust=32}
      else if oPlayer1.mmState=oPlayer1.BUSTER_DUCK {tYadjust=24}
      else if oPlayer1.mmState=oPlayer1.BUSTER_RUN {tYadjust=26}
      else if oPlayer1.mmState=oPlayer1.BUSTER_JUMP {tYadjust=32}
      image_xscale=oPlayer1.image_xscale
      x=oPlayer1.x+(extend*oPlayer1.image_xscale)
      y=oPlayer1.y-tYadjust
    }
    else
    {
      tYadjust=37
      image_xscale=oPlayer1.image_xscale
      x=oPlayer1.x+(extend*-oPlayer1.image_xscale)
      y=oPlayer1.y-tYadjust
    }

    if isCollisionLeft(1) {bCollide=1}
    if isCollisionRight(1) {bCollide=1}
    if bCollide=1
    {
      if bCheckMiss=1 {global.recStrikeChainMisses+=1}
      oPlayer1.grappleState=0
      oPlayer1.busterAnimStay=1
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
if extend>12
{
  if oPlayer1.bWallGrab=0
  {
    for(i=0;i<extend/8;i+=1)
    {
      draw_sprite_ext(sMMXstrikeChainBody,bodyFrm,x-((i*8)*oPlayer1.image_xscale),y,oPlayer1.image_xscale,1,0,image_blend,image_alpha)
    }
    draw_sprite_ext(sprite_index,image_index,x,y,oPlayer1.image_xscale,1,0,image_blend,image_alpha)
  }
  else
  {
    for(i=0;i<extend/8;i+=1)
    {
      draw_sprite_ext(sMMXstrikeChainBody,bodyFrm,x-((i*8)*-oPlayer1.image_xscale),y,-oPlayer1.image_xscale,1,0,image_blend,image_alpha)
    }
    draw_sprite_ext(sprite_index,image_index,x,y,-oPlayer1.image_xscale,1,0,image_blend,image_alpha)
  }
}
