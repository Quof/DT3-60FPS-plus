/*
This script is used when a character gets inflicted with a status ailment.
bPlayable is used to tell whether the character is your character or an enemy.
argument0 is the status ailment being inflicted.
0: Cripple
1: Poison
*/
if bPlayable=false
{
  if argument0=0 //cripple
  {
    if statusCripple=0 and global.optEnemyStatus=true
    {
      global.recCrippledTargetNumber+=1
      var awesomeAward;
      if bIsBoss=false
        awesomeAward=round(expWorth/50)
      else
        awesomeAward=round(expWorth/100)
      if awesomeAward<1
        awesomeAward=1
      else if awesomeAward>50
        awesomeAward=50
      awesomeA=instance_create(0,0,oAwesomeAward)
      awesomeA.awesomeValue=awesomeAward
      newDamage=instance_create(x,y-(sprite_height/2),oStatusAlert);
      newDamage.statusEffect="Cripple"
      newDamage.statusColor=c_white
    }
    statusCripple=300
  }
}
else
{
  if argument0=1 //poison
  {
    if statusPoison=0
    {
      newDamage=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oStatusAlert);
      newDamage.statusEffect="Poison"
      newDamage.statusColor=c_white
    }
    if global.SkProtection>=1
      statusPoison=225
    else
      statusPoison=300
  }
  else if argument0=2 //spirit drain
  {
    if statusSpiritDrain=0
    {
      newDamage=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oStatusAlert);
      newDamage.statusEffect="Spirit Drain"
      newDamage.statusColor=c_white
    }
    if global.SkProtection>=2
      statusSpiritDrain=450
    else
      statusSpiritDrain=600
  }
  else if argument0=3 //skill lock
  {
    if statusSkillLock=0
    {
      newDamage=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oStatusAlert);
      newDamage.statusEffect="Skill Lock"
      newDamage.statusColor=c_white
    }
    statusSkillLock=600
  }
}
