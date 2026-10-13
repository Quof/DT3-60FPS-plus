playSound(global.snd_Fireball,0,0.92,1)
var tYY;
if meteorSeq=0 {tYY=272}
else if meteorSeq=1 {tYY=208}
else if meteorSeq=2 {tYY=160}
else if meteorSeq=3 {tYY=244}
else if meteorSeq=4 {tYY=192}
else if meteorSeq=5 {tYY=264}
else if meteorSeq=6 {tYY=224}
else if meteorSeq=7 {tYY=192}
else if meteorSeq=8 {tYY=244}
else if meteorSeq=9 {tYY=208}
else {tYY=244} //Used as a failsafe

//Main
tAtk=instance_create(xCenter+roomSpan+120,tYY,oPassBullet)
tAtk.sprite_index=sKamFlame; tAtk._direction=180; tAtk.damageType="ELEMENTAL"
tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; 
if global.inBossChallenge
{
    tAtk.decayTime=100
}
else
{ 
    tAtk.decayTime=-100
}
if meteorSeq=0 or meteorSeq=8
{
  tAtk=instance_create(xCenter+roomSpan+120,oPlayer1.y-26,oPassBullet)
  tAtk.sprite_index=sKamFlame; tAtk._direction=270; tAtk.damageType="ELEMENTAL"
  tAtk.atkPower=atkPower; tAtk.bulletSpeed=7; 
  if global.inBossChallenge
    {
        tAtk.decayTime=100
}
    else
    { 
        tAtk.decayTime=-100
    }
}
