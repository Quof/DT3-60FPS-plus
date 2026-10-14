if instance_exists(oHammerBro)
{
  with oHammerBro
  {
    if distance_to_object(other)<160
    {
      if random(10)>7
      {
        var newMessage;
        newMessage=instance_create(x-46,y-70,oEnemyChat)
        newMessage.enemyMessage="Broooooo!"
      }
      bEnraged=1
      if hammerSpam<3 {hammerSpam=3}
      if throwTime<throwDelay-15 {throwTime=throwDelay-15}
    }
  }
}
if instance_exists(oFireBro) and room!=rBelmont3_4C //spsp
{
  with oFireBro
  {
    if distance_to_object(other)<160
    {
      if random(10)>7
      {
        var newMessage;
        newMessage=instance_create(x-46,y-70,oEnemyChat)
        newMessage.enemyMessage="I didn't like him anyway."
      }
      bEnraged=1
      if fireSpam<3 {fireSpam=3}
      if throwTime<throwDelay-15 {throwTime=throwDelay-15}
    }
  }
}
if instance_exists(oBoomerBro)
{
  with oBoomerBro
  {
    if distance_to_object(other)<160
    {
      if random(10)>7
      {
        var newMessage;
        newMessage=instance_create(x-46,y-70,oEnemyChat)
        newMessage.enemyMessage="Was he even my friend?"
      }
      bEnraged=1
      if boomSpam<3 {boomSpam=3}
      if throwTime<throwDelay-15 {throwTime=throwDelay-15}
    }
  }
}
