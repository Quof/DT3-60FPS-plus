if global.gamePaused=false
{
  shootTime+=1*gDeltaTime
  if shootTime>=shootDelay
  {
    newAttack=instance_create(x+8,y+8,objectUse)
    newAttack.sprite_index=spriteUse; newAttack.atkPower=atkPower
    newAttack.bulletSpeed=bulletSpeed; newAttack._direction=dir
    if room=rGame6_CoDB and x<1800 //spsp ns
    {
        newAttack.image_xscale=3; newAttack.image_yscale=6
    }
    if spriteUse=sSkelefire {newAttack.damageType="ELEMENTAL"}
    shootTime=0
  }
}
correctSpeedDirection(self)
