if oPlayer1.extraBulletCheck=0
{
  if oPlayer1.attackState=oPlayer1.ACT_BLOCK
  {
    exBulletBlockCheck+=1*gDeltaTime
    if exBulletBlockCheck>=3
    {
      exBulletBlockCheck=0
      redDmgHit(0)
    }
  }
  else
  {
    exBulletNormalCheck+=1*gDeltaTime
    if exBulletNormalCheck>=1
    {
      exBulletNormalCheck=0
      redDmgHit(0)
    }
  }
}
