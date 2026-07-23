#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(0,0,oScreenCutIn)
x=global.newMapX
y=global.newMapY

bMoveStep=0
moveTime=0
bCanMove=1
bOnBird=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Controls -----
if !instance_exists(oZeldaSaveMenu)
{
  if bOnBird=0 {image_speed=0.15}
  else {image_speed=0.25}
  event_user(0)
  if bMoveStep>0
  {
    if bOnBird=0
    {
      if bMoveStep=1 {y-=4}
      else if bMoveStep=2 {y+=4}
      else if bMoveStep=3 {x-=4}
      else if bMoveStep=4 {x+=4}
    }
    else if bOnBird=1
    {
      if bMoveStep=1 {y-=8}
      else if bMoveStep=2 {y+=8}
      else if bMoveStep=3 {x-=8}
      else if bMoveStep=4 {x+=8}
    }

    moveTime+=1
    if moveTime=4 and bOnBird=0
    {
      moveTime=0
      bMoveStep=0
    }
    else if moveTime=2 and bOnBird=1
    {
      moveTime=0
      bMoveStep=0
    }
  }
  event_user(0)

  //----- Pause Menu -----
  if bMoveStep=0 and bCanMove=1 and bOnBird=0
  {
    if oKeyCodes.kCodePressed[12]=1
    {
      io_clear()
      resetKeyCodes()
      playSound(global.snd_MenuOpen,0,1,1)
      instance_create(0,0,oZeldaSaveMenu)
    }
  }

  if oKeyCodes.kCodePressed[6]=1 and bOnBird=1 and bMoveStep=0 //Get off bird
  {
    if !collision_point(x,y,oSolid,0,1) and !collision_point(x,y,oGameMapExit,0,1) and !collision_point(x,y,oNoLandingZone,0,1)
    {
      io_clear()
      bOnBird=0
      sprite_index=sClaireGDown
      global.stCGame_C[1]=x
      global.stCGame_C[2]=y
      instance_create(x,y,oGreatBird)
    }
  }

  if oKeyCodes.kCodePressed[8]=1 and bOnBird=0 and bMoveStep=0 and global.gameProgress>=3810 //Call bird
  {
    if !collision_point(x,y,oSolid,0,1) and !collision_point(x,y,oGameMapExit,0,1) and !collision_point(x,y,oNoLandingZone,0,1)
    {
      io_clear()
      playSound(global.snd_RPG_ItemGrab,0,1,33500)
      global.stCGame_C[1]=x
      global.stCGame_C[2]=y
      oGreatBird.x=global.stCGame_C[1]
      oGreatBird.y=global.stCGame_C[2]
    }
  }
}
#define Collision_oOverworldCloud
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bOnBird=1
{
  global.recCloudsBusted+=1
  with other
  {
    var tEffect;
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x+random_range(-16,16),y+random_range(-16,16),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sOverworldCloud; tEffect.newBlend=-1; tEffect.image_alpha=0.75
      tEffect.direction=random(360); tEffect.speed=random(1)+1; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
      tEffect.fadeSpd=0.025; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
    instance_destroy()
  }
}
#define Collision_oGreatBird
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Get on bird -----
if oKeyCodes.kCodePressed[5]=1 and !instance_exists(oZeldaSaveMenu) and bMoveStep=0
{
  io_clear()
  bOnBird=1
  sprite_index=sGreatBirdDown
  with oGreatBird {instance_destroy()}
}
#define Mouse_54
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMenu=1
{
  var xCoord,yCoord;
  xCoord=get_integer("Enter target x coordinate.",x)
  yCoord=get_integer("Enter target y coordinate.",y)
  x=xCoord
  y=yCoord
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//---------- Movement Controls ----------
if bMoveStep=0 and bCanMove=1
{
  if scrController(3) and y>8
  {
    if bOnBird=0
    {
      sprite_index=sClaireGUp
      if !collision_point(x,y-16,oSolid,0,1) {bMoveStep=1}
    }
    else
    {
      sprite_index=sGreatBirdUp
      bMoveStep=1
    }
    image_xscale=1
  }
  else if scrController(4) and y<room_height-8
  {
    if bOnBird=0
    {
      sprite_index=sClaireGDown
      if !collision_point(x,y+16,oSolid,0,1) {bMoveStep=2}
    }
    else
    {
      sprite_index=sGreatBirdDown
      bMoveStep=2
    }
    image_xscale=1
  }
  else if scrController(1) and x>8
  {
    if bOnBird=0
    {
      sprite_index=sClaireGRight
      if !collision_point(x-16,y,oSolid,0,1) {bMoveStep=3}
    }
    else
    {
      sprite_index=sGreatBirdRight
      bMoveStep=3
    }
    image_xscale=-1
  }
  else if scrController(2) and x<room_width-8
  {
    if bOnBird=0
    {
      sprite_index=sClaireGRight
      if !collision_point(x+16,y,oSolid,0,1) {bMoveStep=4}
    }
    else
    {
      sprite_index=sGreatBirdRight
      bMoveStep=4
    }
    image_xscale=1
  }
}
