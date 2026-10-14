///kill purple fire here
with oPassBullet
{
    if sprite_index=sDraculaFireballP or sprite_index=sFlameUpP
    {
        //if collision with holy flame -> destroy
        if place_meeting(x,y,oBelmontHWExplosion)
        {
            //smoke
            var poof;
            poof=instance_create(x,y,oEffect)
            poof.sprite_index=sMMSmokeCloud
            poof.image_speed=0.2; poof.image_xscale=1; poof.image_yscale=1
            poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=1-random(2); poof.ySpd=1-random(2)
            instance_destroy()
        }
    }
}
