if room=rHexPlat43 and !instance_exists(oEnemyChat)
{
    var tFlash;
    tFlash=instance_create(0,0,oScreenFlash)
    tFlash.fadeSpeed=0.2
    with oExit {instance_destroy()}
    var brah;
    brah=instance_create(x+16,y-48,oEnemyChat)
    brah.enemyMessage="You dun goofed."
}
