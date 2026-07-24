#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
image_xscale=1.5
image_yscale=1.5
image_speed=0.33
moveProg=0
messageDelayTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if messageDelayTime>0 {messageDelayTime-=1}

  moveProg+=1*gDeltaTime
  if moveProg<=32
  {
    y-=0.5*gDeltaTime
    if moveProg=32
    {
      xVel=2.5
      if x>=oPlayer1.x
        xVel=2.5
      else
        xVel=-2.5
    }
  }
  else
  {
    yVel+=0.3*gDeltaTime
    if isCollisionBottom(1)
      yVel=-5
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

    if isCollisionSolid()
      y-=2
    if y>room_height+24
      instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.difficulty>=2
{
  if moveProg>=20
  {
    if global.hasAbilToken[0]>=2
    {
      playSound(global.snd_MoneyPickup,0,0.9,1)

      stopAllMusic()
      if !SS_IsHandleValid(global.msc_Starman)
        global.msc_Starman=SS_LoadSound(working_directory+"\Music\DT_Starman.ogg",1)
      if !SS_IsSoundLooping(global.msc_Starman)
        playMusic(global.msc_Starman,0,0)

      awardAwesome(250)
      oPlayer1.starmanTime=300
      instance_destroy()
    }
    else
    {
      if messageDelayTime=0
      {
        msgCreate(170,100,"","Without the Mario ability, this cannot be used.",6,1,oMessagePerson,0)
        newMessage.fadingTime=60
        messageDelayTime=120
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
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
