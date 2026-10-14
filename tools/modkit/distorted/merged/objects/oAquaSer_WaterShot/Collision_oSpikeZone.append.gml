/// break and shoot ice
if global.gamePaused=false and y<64
{
    playSound(global.snd_SpearShot,0,1,27000)
    var tAtk,tIceDir;
    tIceDir=240
    for(i=0;i<3;i+=1)
    {
      tAtk=instance_create(x,y,oPassBullet)
      tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=4; tAtk.bulletSpeed=6
      //tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tIceDir; tAtk.image_angle=tIceDir
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk._direction=tIceDir; tAtk.image_angle=tIceDir //60fps change: DT3+'s oPassBullet moves by its own _direction
      tIceDir+=30
    }
    instance_destroy()
}
