event_inherited()
if moveTime<moveThres
{
    //moveTime+=5
    moveTime+=5*gDeltaTime //60fps change: per frame of contact (the collision event runs every frame)
    if moveTime>=moveThres {moveTime=moveThres-1}
}
