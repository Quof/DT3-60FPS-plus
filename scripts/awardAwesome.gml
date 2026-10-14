/*
This script is used to give Awesome Points to the player
argument0: Awesome awarded
*/
if global.modOvr[awardAwesome]>=0 {var __n; __n=0; repeat (argument_count) {global.modArg[__n]=argument[__n]; __n+=1}; return scrModOverride(awardAwesome,argument_count)} //mods change (added): a mod's own version of this script runs instead (scrModOverride)
var tAwesomeAward;
tAwesomeAward=argument0

global.awesomePoints+=tAwesomeAward

if global.optShowScore=1 and global.charScan[1]=1
{
  var tPointGain;
  tPointGain=instance_create(70,70,oAwesomeAward)
  tPointGain.AwesomeValue=tAwesomeAward
}
