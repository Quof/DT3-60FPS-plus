if oPlayer1.extraBulletCheck=0
{
  if oPlayer1.attackState=oPlayer1.ACT_BLOCK
  {
    //exBulletBlockCheck+=1
    exBulletBlockCheck+=1*gDeltaTime //60fps change: the 3-step block grace counted frames (as in oExe_FireRed's own collision)
    if exBulletBlockCheck>=3
    {
      exBulletBlockCheck=0
      event_inherited()
    }
  }
  else
  {
    //exBulletNormalCheck+=1
    exBulletNormalCheck+=1*gDeltaTime //60fps change: as in oExe_FireRed's own collision
    if exBulletNormalCheck>=1
    {
      exBulletNormalCheck=0
      event_inherited()
    }
  }
}
