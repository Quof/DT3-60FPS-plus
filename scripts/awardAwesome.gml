/*
This script is used to give Awesome Points to the player
argument0: Awesome awarded
*/
var tAwesomeAward;
tAwesomeAward=argument0

global.awesomePoints+=tAwesomeAward

if global.optShowScore=1 and global.charScan[1]=1
{
  var tPointGain;
  tPointGain=instance_create(70,70,oAwesomeAward)
  tPointGain.AwesomeValue=tAwesomeAward
}
