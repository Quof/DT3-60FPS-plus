/*
This script is used to give Awesome Points to the player
argument0: Awesome awarded
*/
var tAwesomeAward;
tAwesomeAward=argument0

//spsp ns power glove
tGloveBonus=1
if global.activeCharacter=0
{
  for(jjj=0;jjj<3;jjj+=1){tGloveBonus+=(global.equipJerry[jjj]==3)}
}
else
{
  for(jjj=0;jjj<3;jjj+=1){tGloveBonus+=(global.equipClaire[jjj]==3)}
}

global.awesomePoints+=tAwesomeAward*tGloveBonus //spsp ns new factor

if global.optShowScore=1 and global.charScan[1]=1
{
  var tPointGain;
  tPointGain=instance_create(70,70,oAwesomeAward)
  tPointGain.AwesomeValue=tAwesomeAward
}
