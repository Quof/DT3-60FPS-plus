initFireDir=image_xscale
if (special=1)
{
    image_xscale = 1.5
    image_yscale = 1.5
    atkPower*=1.5
    image_blend = make_color_rgb(0,100,0)
    if global.alterEquip=1
    {
          for(i=0;i<3;i+=1)
            if global.equipClaire[i]=39
                weakenTime=90
    }
}
