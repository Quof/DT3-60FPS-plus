if global.gamePaused=false
{
  shootTime+=1*gDeltaTime
  if shootTime>=shootDelay
  {
    newAttack=instance_create(x+8,y+8,objectUse)
    newAttack.sprite_index=spriteUse; newAttack.atkPower=atkPower
    newAttack.bulletSpeed=bulletSpeed; newAttack._direction=dir
    if spriteUse=sSkelefire {newAttack.damageType="ELEMENTAL"}
    shootTime=0
  }
}
correctSpeedDirection(self)
