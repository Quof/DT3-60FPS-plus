///top down reds
var tAtk;
for(i=0;i<5;i+=1)
{
  tAtk=instance_create(avoX1+(16*i),32,oHF_HexBulletRed)
  //tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
  tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270 //60fps change: DT3+'s bullets move by their own _direction
  tAtk=instance_create(avoX2+(16*i),32,oHF_HexBulletRed)
  //tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
  tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270 //60fps change: DT3+'s bullets move by their own _direction
  tAtk=instance_create(avoX3+(16*i),32,oHF_HexBulletRed)
  //tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
  tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk._direction=270 //60fps change: DT3+'s bullets move by their own _direction
}
