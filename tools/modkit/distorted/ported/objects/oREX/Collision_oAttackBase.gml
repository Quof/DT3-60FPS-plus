if bossProgress>=3 and bossProgress<6
{
    for(i=0;i<6;i+=1)
    {
      resType[i]=3-instance_number(oShroudlerHand)
    }
    event_inherited()
    for(i=0;i<6;i+=1)
    {
      resType[i]=3
    }
}
else if bossProgress>=6
{
    if instance_exists(oShroudlerHand)
    {
        //don't take damage
    }
    else
    {
        event_inherited()
    }
}
else
{
    event_inherited()
}
