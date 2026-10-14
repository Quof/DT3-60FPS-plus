///purples
//purples - two "beams" left and right of the idle player at certain times
avoPillarL=oPlayerIdle.x-48
avoPillarR=oPlayerIdle.x+48
var tAtk;
for(i=0;i<20;i+=1)
{
  tAtk=instance_create(avoPillarL,32,oPassBullet)
  tAtk.sprite_index=sHFight_DespBulletA; tAtk.atkPower=atkPower
  //tAtk.bulletSpeed=2-i*0.1; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=270
  tAtk.bulletSpeed=2-i*0.1; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk._direction=270 //60fps change: DT3+'s bullets move by their own _direction
  tAtk=instance_create(avoPillarR,32,oPassBullet)
  tAtk.sprite_index=sHFight_DespBulletA; tAtk.atkPower=atkPower
  //tAtk.bulletSpeed=2-i*0.1; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=270
  tAtk.bulletSpeed=2-i*0.1; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk._direction=270 //60fps change: DT3+'s bullets move by their own _direction
}
