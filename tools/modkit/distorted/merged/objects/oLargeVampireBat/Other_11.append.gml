///Second bullet spawns
if bossProgress>=3
{
  var tFire,tFireDir;
  tFireDir=player_sprite_center()
  tFireDir-=14+14*(bossProgress==4)
  for(i=0;i<5+4*(bossProgress==4);i+=1) //spsp
  {
    tFire=instance_create(x,y,oPassBullet)
    tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.bulletSpeed=4
    //tFire.direction=tFireDir; tFire.decayTime=-100; tFire.damageType="ELEMENTAL"
    tFire._direction=tFireDir; tFire.decayTime=-100; tFire.damageType="ELEMENTAL" //60fps change: DT3+'s oPassBullet moves by its own _direction
    tFireDir+=7
  }
}
