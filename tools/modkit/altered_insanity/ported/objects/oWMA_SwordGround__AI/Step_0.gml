if global.gamePaused=false
{
  atkTime+=1*gDeltaTime
  if atkTime=3 {image_index=1}
  else if atkTime=6 {image_index=2}
  else if atkTime=9 {image_index=3}
  else if atkTime=12 {image_index=4}
  else if atkTime=15
  {
    if type=0 {instance_destroy()}
    else
    {
      visible=0
      bCanDealDamage=0
    }
  }

  if type=1 //Bomb pillars
  {
    if atkTime>=4
    {
      if atkTime mod 2=0
      {
        var tAtk;
        tAtk=instance_create(x+(xSpread*image_xscale),warTarget.yGround,oWMA_BombExpWave)
        tAtk.atkPower=atkPower; 
        tAtk.image_xscale=1+(0.025*spreadNum); 
        if global.activeCharacter=3
        {
            tAtk.image_yscale=3+(0.075*spreadNum)
        }
        else
        {
            tAtk.image_yscale=1+(0.025*spreadNum)
        }
        tAtk.image_blend=image_blend; tAtk.damageType=damageType
        xSpread+=20
        spreadNum+=1
        if spreadNum>=spreadMax {instance_destroy()}
      }
    }
  }
}
