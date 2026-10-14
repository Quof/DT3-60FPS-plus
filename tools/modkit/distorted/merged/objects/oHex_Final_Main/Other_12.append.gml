///red wall
//left right red bullet wall; use max i=4 for a "small wall"
var tAtk;
for(i=0;i<avoWallHeight;i+=1)
{
  tAtk=instance_create(xCenter+roomSpan+8,yGround-(8-4)-(16*i),oHF_HexBulletRed)
  //tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100; tAtk.direction=180
  tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100; tAtk._direction=180 //60fps change: DT3+'s bullets move by their own _direction
}
