/*
This script is called when an enemy dies that has a quest value or scripted event attached to it.
Typically used for bosses or scripted encounters.
*/
var tQuestType;
tQuestType=argument0

if tQuestType=1
{
  if instance_exists(oGlobalEvent) {oGlobalEvent.enemyCount-=1}
}
else if tQuestType=2
{
  if instance_exists(oEnemyRemain) {oEnemyRemain.enemyCount-=1}
}
