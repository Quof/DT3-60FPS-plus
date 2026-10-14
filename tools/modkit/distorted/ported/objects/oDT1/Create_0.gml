sceneProgress=0
sceneDelay=0
lazyDelay=0
initial=0
counter=1
war1=192
war2=448
war3=704
war4=960
wary=368
stored=0
invact=0
koopaRings=0
//nothing in particular
if room=rYellowRide
{
    if global.newMapX=892
        sceneProgress=4
    else if global.newMapX=1792
        sceneProgress=10
}
/*else if room=rYellowRide2
{
    for(i=0;i<room_width;i+=16)
    {
        instance_create(i,0,oDSSR)
        instance_create(i,room_height-16,oDSSR)
    }
}*/
else if room=rHexPlat5 or room=rHexPlat52 or room=rHexPlat53 or room=rHexPlat55
{
    with oDHexRing
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=1; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDHexTunnel
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=1; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDBlueHexRing
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=2; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDBlueHexTunnel
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=2; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDGreenHexRing
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=3; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDGreenHexTunnel
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=3; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDGreenUDHexRing
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=3; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oGUDHexTunnel
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=3; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDYellowHexRing
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=4; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
    with oDYellowHexTunnel
    {
        var myZone;
        myZone=instance_create(x,y,oDColourZone)
        myZone.zoneColor=4; myZone.bFollow=1; myZone.idFollow=id
        myZone.zoneRadius=78*image_xscale
    }
}
else if room=rDoubleSplit2
{
    for(i=0;i<=room_width;i+=32)
    {
        instance_create(i,272,oDSSR)
        instance_create(i+16,256,oDSSR)
        instance_create(i,240,oDSSR)
    }
}
