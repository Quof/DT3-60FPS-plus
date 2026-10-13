if global.gamePaused=false
{
    if spawnDelay = 0
    {
        if red=1
        {
            if room=rDragoonMapA
            {
                instance_create(oPlayer1.x-6,oPlayer1.y-6,oSnakeSpikeRed);
            }
            else
            {
                instance_create(oPlayer1.x,oPlayer1.y-27,oSnakeSpikeRed);
            }
        }
        else
        {
            if room=rDragoonMapA
            {
                instance_create(oPlayer1.x-6,oPlayer1.y-6,oSnakeSpike);
            }
            else
            {
                instance_create(oPlayer1.x,oPlayer1.y-27,oSnakeSpike);
            }
        }
        spawnDelay=maxSpawnDelay;
        if red = 1
        {
            if (instance_number(oSnakeSpikeRed) > snakeLength+(30/maxSpawnDelay))
            {
                var found;
                found=0;
                with oSnakeSpikeRed
                {
                    if (found=0 || found > id) && id > other.id
                        found = id;
                }
                
                with found { instance_destroy() };
            }
        }
        else
        {
            if (instance_number(oSnakeSpike) > snakeLength+(30/maxSpawnDelay))
            {
                var found;
                found=0;
                with oSnakeSpike
                {
                    if (found=0 || found > id) && id > other.id
                        found = id;
                }
                
                with found { instance_destroy() };
            }
        }
    }
    //spawnDelay-=1;
    spawnDelay-=1*gDeltaTime; //60fps change: per frame (whole numbers of steps, so it still lands on 0)
}
