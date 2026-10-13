event_inherited()

if other.damageType="EXPLOSION"
{
  if turnCur>=8 and turnMax=100 and y=yGround
  {
    playSound(global.snd_KraidRoarA,0,1,78000)
    sprite_index=sArachnusIdle
    image_speed=0.2
    baseColor=c_white
    image_blend=baseColor
    otherColor=255
    turnCur=0
    progTime=0; behavior=3
  }
}
