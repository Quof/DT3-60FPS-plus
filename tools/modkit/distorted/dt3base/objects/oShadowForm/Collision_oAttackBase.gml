if global.gamePaused=false
{
  if bossProgress=0 {event_inherited()} //[0] No rules
  else if bossProgress>=1 and bossProgress<=2 //[1] Hit from behind
  {
    if checkFacing()=1 {event_user(0)}
    else {event_inherited()}
  }
  else if bossProgress>=3 and bossProgress<=4 //[2] Hit from behind, only with opposite character
  {
    if checkFacing()=1 {event_user(0)}
    else
    {
      if charForm!=global.activeCharacter {event_inherited()}
      else {event_user(0)}
    }
  }
  else if bossProgress>=5 and bossProgress<=6 //[3] Hit from behind, only with opposite character, only when taking an action
  {
    if currentAction=0
    {
      event_user(0)
      if other.damageType!="NORMAL" {with other {instance_destroy()}}
    }
    else
    {
      if checkFacing()=1 {event_user(0)}
      else
      {
        if charForm!=global.activeCharacter {event_inherited()}
        else {event_user(0)}
      }
    }
  }
  else if bossProgress>=7 //[4] Hit from behind, only when taking an action, only with opposite character, only NORMAL type
  {
    if currentAction=0
    {
      event_user(0)
      if damageType!="NORMAL" {with other {instance_destroy()}}
    }
    else
    {
      if checkFacing()=1 {event_user(0)}
      else
      {
        if charForm!=global.activeCharacter
        {
          if other.damageType="NORMAL" {event_inherited()}
          else {event_user(0)}
        }
        else {event_user(0)}
      }
    }
  }
}
