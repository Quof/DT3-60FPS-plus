if bCanDealDamage=true and (global.gameOptDT<3 or room=rWarshipZ_H) {oneHitKill()}
else if bCanDealDamage=true and global.gameOptDT>=3
{
    with other
        hitPlayer(other)
} //spsp ns, normal damage here to make some barrens items easier after he dies in tower
