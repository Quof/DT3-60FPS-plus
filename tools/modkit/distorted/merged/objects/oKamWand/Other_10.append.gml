playSound(global.snd_Fireball,0,0.92,1)
var tYY;
if meteorSeq mod 10=0 {tYY=272}
else if meteorSeq mod 10=1 {tYY=returnPlayerYCenter()}//208}
else if meteorSeq mod 10=2 {tYY=160}
else if meteorSeq mod 10=3 {tYY=244}
else if meteorSeq mod 10=4 {tYY=192}
else if meteorSeq mod 10=5 {tYY=264}
else if meteorSeq mod 10=6 {tYY=224}
else if meteorSeq mod 10=7 {tYY=returnPlayerYCenter()}//192}
else if meteorSeq mod 10=8 {tYY=244}
else if meteorSeq mod 10=9 {tYY=208}

//Main
tAtk=instance_create(oKamek.xCenter+oKamek.roomSpan+120,tYY,oPassBullet)
//tAtk.sprite_index=sKamFlame; tAtk.direction=180; tAtk.damageType="ELEMENTAL"
tAtk.sprite_index=sKamFlame; tAtk._direction=180; tAtk.damageType="ELEMENTAL" //60fps change: DT3+'s oPassBullet moves by its own _direction
tAtk.atkPower=oKamek.atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100

if meteorSeq=0 or meteorSeq=8
{
  tAtk=instance_create(oKamek.xCenter+oKamek.roomSpan+120,oPlayer1.y-26,oPassBullet)
  //tAtk.sprite_index=sKamFlame; tAtk.direction=270; tAtk.damageType="ELEMENTAL"
  tAtk.sprite_index=sKamFlame; tAtk._direction=270; tAtk.damageType="ELEMENTAL" //60fps change: DT3+'s oPassBullet moves by its own _direction
  tAtk.atkPower=oKamek.atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100
}
