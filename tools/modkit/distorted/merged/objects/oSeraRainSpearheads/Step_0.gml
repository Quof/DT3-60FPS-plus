if global.gamePaused=false
{
  spearheadRain+=1*gDeltaTime
  if spearheadRain>=30
  {
    var tNewAttack;
    for(i=0;i<12;i+=1)
    {
      tNewAttack=instance_create(104+(48*i),0,oPassBullet)
      tNewAttack.sprite_index=sSeraSpearhead; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=12
      tNewAttack.decayTime=-100; tNewAttack.image_speed=0.33; tNewAttack._direction=270
    }

    tNewAttack=instance_create(oPlayer1.x,0,oPassBullet)
    with tNewAttack
    {
      sprite_index=sSeraSpearhead; atkPower=oSeraRainSpearheads.atkPower; bulletSpeed=12
      decayTime=-100; image_speed=0.33; _direction=270
      move_snap(8,1)
    }
    if instance_exists(oSera)   //spsp
    {
    if oSera.bossProgress>=3
    {
      tNewAttack=instance_create(oPlayer1.x-48,0,oPassBullet)
      with tNewAttack
      {
          sprite_index=sSeraSpearhead; atkPower=oSeraRainSpearheads.atkPower; bulletSpeed=12
        decayTime=-100; image_speed=0.33; _direction=270
        move_snap(8,1)
      }
      tNewAttack=instance_create(oPlayer1.x+48,0,oPassBullet)
      with tNewAttack
      {
          sprite_index=sSeraSpearhead; atkPower=oSeraRainSpearheads.atkPower; bulletSpeed=12
          //decayTime=-100; image_speed=0.33; direction=270
          decayTime=-100; image_speed=0.33; _direction=270 //60fps change: DT3+'s oPassBullet moves by its own _direction
          move_snap(8,1)
        }
      }
    }
    else if oSeraV.bossProgress>=3
    {
      tNewAttack=instance_create(oPlayer1.x-48,0,oPassBullet)
      with tNewAttack
      {
        sprite_index=sSeraSpearhead; atkPower=oSeraRainSpearheads.atkPower; bulletSpeed=12
        //decayTime=-100; image_speed=0.33; direction=270
        decayTime=-100; image_speed=0.33; _direction=270 //60fps change: DT3+'s oPassBullet moves by its own _direction
        move_snap(8,1)
      }
      tNewAttack=instance_create(oPlayer1.x+48,0,oPassBullet)
      with tNewAttack
      {
        sprite_index=sSeraSpearhead; atkPower=oSeraRainSpearheads.atkPower; bulletSpeed=12
        decayTime=-100; image_speed=0.33; _direction=270
        move_snap(8,1)
      }
    }
    instance_destroy()
  }
}
//correctSpeedDirection(self)
