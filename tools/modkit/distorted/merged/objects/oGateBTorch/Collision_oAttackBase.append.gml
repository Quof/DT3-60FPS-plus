if room=rExtGateB_4 and other.damageType="EXPLOSION" and killable=1 and global.gamePaused=false
{
    var poof;
    poof=instance_create(x,y,oEffect)
    poof.sprite_index=sMMSmokeCloud
    poof.image_speed=0.2; poof.image_xscale=1.5; poof.image_yscale=1.5
    poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=0; poof.ySpd=0
    instance_destroy()
}
