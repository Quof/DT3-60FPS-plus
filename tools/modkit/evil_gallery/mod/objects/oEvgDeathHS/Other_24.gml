//Evil Boss Gallery: hit, before the damage (user event 14). Holy water on Evil Death during his soul siphon breaks it
//(his user event 4: the vial breaks on him without its fire, so it's caught here); staggered, he takes double (his
//resistances back after, Other_25)
evgResSet=0
if instance_exists(oEvgDeath)
{
  if other.weaponTag=32
  {
    with (oEvgDeath)
    {
      if evgMove=3 and evgStage=1 {event_user(4)}
    }
  }
  if oEvgDeath.staggerTime>0
  {
    evgRes0=resType[0]; evgRes1=resType[1]; evgRes2=resType[2]
    resType[0]=4; resType[1]=4; resType[2]=4
    evgResSet=1
  }
}
