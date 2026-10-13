playSound(global.snd_Fireball,0,0.92,1)
var tXX;
if meteorSeq=0 {tXX=256}
else if meteorSeq=1 {tXX=288}
else if meteorSeq=2 {tXX=192}
else if meteorSeq=3 {tXX=360}
else if meteorSeq=4 {tXX=224}
else if meteorSeq=5 {tXX=304}
else if meteorSeq=6 {tXX=240}
else if meteorSeq=7 {tXX=320}
else if meteorSeq=8 {tXX=248}
else if meteorSeq=9 {tXX=336}
else if meteorSeq=10 {tXX=168}
else if meteorSeq=11 {tXX=376}
else if meteorSeq=12 {tXX=296}
else if meteorSeq=13 {tXX=232}
else {tXX=360} //Used as a failsafe

//Main
if global.inBossChallenge
{
    tAtk=instance_create(tXX+160,2,oPassBullet)
}
else
{
tAtk=instance_create(tXX,2,oPassBullet)
}
tAtk.sprite_index=sKamFlame; tAtk._direction=270; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100

//Sides
if global.inBossChallenge
{
    if meteorSeq mod 2=0
    {
        tAtk=instance_create(375,2,oPassBullet)
    }
}
else
{
tAtk=instance_create(144,2,oPassBullet)
}

tAtk.sprite_index=sKamFlame; tAtk._direction=270; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100
if global.inBossChallenge
{
    if meteorSeq mod 2=0
    {
        tAtk=instance_create(550,2,oPassBullet)
    }
}
else
{
tAtk=instance_create(400,2,oPassBullet)
}
tAtk.sprite_index=sKamFlame; tAtk._direction=270; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100

if meteorSeq mod 4=0
{
  tAtk=instance_create(oPlayer1.x,2,oPassBullet)
  tAtk.sprite_index=sKamFlame; tAtk._direction=270; tAtk.damageType="ELEMENTAL"
  tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; tAtk.decayTime=-100
}
