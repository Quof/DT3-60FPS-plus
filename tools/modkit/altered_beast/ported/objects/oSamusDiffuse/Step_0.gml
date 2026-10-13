event_inherited()
if global.gamePaused=false
{
    x = manager.x + cos(angle)*radius;
    y = manager.y + sin(angle)*radius;

    //radius+=outwardSpeed
    radius+=outwardSpeed*gDeltaTime //60fps change

    //angle += angleSpeed
    angle += angleSpeed*gDeltaTime //60fps change
    if damageCountdown > 0
    {
        //damageCountdown-=1
        damageCountdown-=1*gDeltaTime //60fps change
        if damageCountdown=0
        {
            bCanDealDamage=true
        }
    }
}
