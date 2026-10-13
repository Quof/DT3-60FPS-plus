///Explosion

if explodeLevel > 0
{
    tAtk = instance_create(x,y,oChaoExplosion)
    tAtk.atkPower = explosionPower
    tAtk.image_xscale = explosionSize
    tAtk.image_yscale = explosionSize
}
