if global.gamePaused=false and room!=rLink2_PalaceW_13 and room!=rBelmont3_6B and false //spsp ns never
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
else if global.gamePaused=false and (room=rLink2_PalaceW_13 or room=rBelmont3_6B)
{
  event_inherited()
}
else if global.gamePaused=false //spsp ns complete fight in E
{
  //excludes all MM weapons
  if other.weaponTag=10 or other.weaponTag=11 or other.weaponTag=12 {event_user(0)}
  else
  {
    if other.damageType="NORMAL" {Dnumber=0}
    else if other.damageType="PIERCE" {Dnumber=1}
    else if other.damageType="ELEMENTAL" {Dnumber=2}
    else if other.damageType="SHOT" {Dnumber=3}
    else if other.damageType="EXPLOSION" {Dnumber=4}
    else if other.damageType="SPECIAL" {Dnumber=5}
    
    if Dtrack[Dnumber]=0 {resType[Dnumber]+=1; event_inherited(); resType[Dnumber]-=1}
    else if Dtrack[Dnumber]<3 {event_inherited()}
    else if Dtrack[Dnumber]<6 {resType[Dnumber]-=1; event_inherited(); resType[Dnumber]+=1}
    else {event_user(0)}
  }
}
