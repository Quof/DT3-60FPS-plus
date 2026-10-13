if special=1
{
    var playerAttack,tIceDir;
    //if direction = 0
    if _direction = 0 //60fps change: DT3+'s own motion (_direction)
    {
    iceAngle=12.5
    }
    else
    {
    iceAngle=-12.5
    }
    tIceDir=90
    for(i=0;i<10;i+=1)
    {
      playerAttack=instance_create(x+9+lengthdir_x(3,tIceDir),y+lengthdir_y(3,tIceDir),oMMXshotgunIceB)
      //playerAttack.direction=tIceDir
      playerAttack._direction=tIceDir //60fps change: DT3+'s own motion (_direction)
      playerAttack.special=1
      tIceDir-=iceAngle
    }
    instance_destroy()
}
