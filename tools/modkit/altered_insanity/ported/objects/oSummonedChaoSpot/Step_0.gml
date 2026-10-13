if global.gamePaused=0 and !halted
{
  //if shotDelay>0 {shotDelay-=1}
  if shotDelay>0 {shotDelay-=1*gDeltaTime} //60fps change (as oVP_AtkSpot's)

  //decayTime-=1
  decayTime-=1*gDeltaTime //60fps change
  if decayTime<=0 and transformAddColor != 1 //only decays if not secondary red, else goes boom after decayed
  {
    //image_alpha-=0.1
    image_alpha-=0.1*gDeltaTime //60fps change
    if image_alpha<=0 {instance_destroy()}
  }
  if (transformStyle = 1 and transformColor = 1) or (transformStyle = 3 and transformAddColor = 1 and decayTime <= 0) //Explode
  {
    if image_xscale < 2
    {
        //image_xscale += 0.1
        //image_yscale += 0.1
        image_xscale += 0.1*gDeltaTime //60fps change
        image_yscale += 0.1*gDeltaTime
    }
    else
    {
        playSound(global.snd_BombExplode,0,0.92,20000)
        if enemyBullets = false
        {
            instance_create(x,y,oChaoExplosion)
        }
        else
        {
            instance_create(x,y,oChaoBossExplosion)
        }
        instance_destroy()
    }
    //make a collision event for this with baseDamageable
  }
  if autoFire = true //offense blue is auto firing
  {
    if decayTime>0 and shotDelay=0
    {
        event_user(0)
    }
  }
}
